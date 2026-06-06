from fastapi import FastAPI
from pydantic import BaseModel
from sentence_transformers import SentenceTransformer
from sklearn.metrics.pairwise import cosine_similarity
import requests
import os

from synonyms import SYNONYMS

app = FastAPI()
model = SentenceTransformer('intfloat/multilingual-e5-base')
OLLAMA_URL = os.getenv("OLLAMA_URL", "http://ollama:11434/api/generate")

class RequestData(BaseModel):
    text: str
    options: dict

# 🔹 EMBEDDINGS
def get_top_options(text, options):
    text = text.lower().strip()
    user_emb = model.encode([f"query: {text}"])
    scores = []
    for option_id, desc in options.items():
        desc_clean = desc.lower().strip()
        opt_emb = model.encode([f"passage: {desc_clean}"])
        score = cosine_similarity(user_emb, opt_emb)[0][0]
        scores.append((option_id, desc, score))
    scores.sort(key=lambda x: x[2], reverse=True)
    return scores

# 🔹 LLM
def ask_llm(text, candidates):
    try:
        valid_options = [c[0] for c in candidates]
        options_text = "\n".join([
            f"{c[0]}: {c[1]}" for c in candidates
        ])
        prompt = f"""
Eres un sistema que decide la intención del jugador en una historia RPG.
Jugador dijo:
"{text}"
Opciones:
{options_text}
REGLAS:
- Interpreta lenguaje vulgar o indirecto
- Interpreta errores ortográficos y typos
- Responde SOLO con una de estas claves:
{", ".join(valid_options)}
- NO expliques nada
"""
        response = requests.post(
            OLLAMA_URL,
            json={
                "model": "mistral:latest",
                "prompt": prompt,
                "stream": False
            },
            timeout=30
        )
        data = response.json()
        decision = data.get("response", "").strip().split("\n")[0]
        if decision.isdigit():
            index = int(decision) - 1
            if 0 <= index < len(valid_options):
                decision = valid_options[index]
        if decision not in valid_options:
            return valid_options[0]
        return decision
    except Exception as e:
        print("ERROR LLM:", e)
        return candidates[0][0]

# 🔹 ENDPOINT
@app.post("/clasificar")
def clasificar(data: RequestData):
    text_lower = data.text.lower().strip()
    candidates = get_top_options(text_lower, data.options)

    # 🔥 BOOST POR SINÓNIMOS
    for i, c in enumerate(candidates):
        action_id = c[0]
        if action_id in SYNONYMS:
            for synonym in SYNONYMS[action_id]:
                if synonym in text_lower or text_lower in synonym:
                    candidates[i] = (c[0], c[1], min(1.0, c[2] + 0.3))
                    break

    # 🔥 BOOST MANUAL
    if "foll" in text_lower or "sexo" in text_lower:
        for i, c in enumerate(candidates):
            if c[0] == "sexual":
                candidates[i] = (c[0], c[1], c[2] + 0.2)

    candidates.sort(key=lambda x: x[2], reverse=True)

    if len(candidates) > 1:
        diff = candidates[0][2] - candidates[1][2]
    else:
        diff = 1

    if diff > 0.05:
        decision = candidates[0][0]
    else:
        decision = ask_llm(text_lower, candidates)

    return {
        "opcion": decision,
        "top": [
            {
                "id": t[0],
                "score": float(t[2])
            } for t in candidates
        ]
    }