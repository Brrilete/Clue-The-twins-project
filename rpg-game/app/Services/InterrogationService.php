<?php

namespace App\Services;

use App\Models\Player;
use App\Models\History;
use App\Models\PlayerItem;
use App\Models\PlayerAction;

class InterrogationService
{
    private array $questions = [
        1 => [
            'text' => '"¿Cómo se llama usted?" — El inspector te mira fijamente esperando tu respuesta.',
            'key' => 'nombre'
        ],
        2 => [
            'text' => '"¿Ha tocado algo dentro de la habitación?" — Sus ojos no se apartan de los tuyos.',
            'key' => 'tocado'
        ],
        3 => [
            'text' => '"¿Sabe quién es la persona fallecida?" — Pone una foto sobre la mesa.',
            'key' => 'conoce_victima'
        ],
        4 => [
            'text' => '"¿Llamó usted a recepción?" — Ya sabe la respuesta. Solo quiere ver si mientes.',
            'key' => 'llamo_recepcion'
        ],
    ];

    public function handle(Player $player, string $text): array
    {
        $answeredCount = History::where('player_id', $player->id)
            ->where('scene_id', $player->location_scene_id)
            ->whereIn('action_key', array_column($this->questions, 'key'))
            ->count();

        $currentQuestionNum = $answeredCount + 1;

        if ($currentQuestionNum > count($this->questions)) {
            $player->location_scene_id = 3;
            $player->save();
            return [
                'player' => $this->playerData($player),
                'scene' => 'Pasillo del Hotel',
                'action' => 'fin_interrogatorio',
                'text' => '"Muy bien." El inspector cierra su libreta. "Acompáñeme." No es una petición.',
                'next_scene' => 3
            ];
        }

        $question = $this->questions[$currentQuestionNum];
        $isLying = $this->detectLie($player, $question['key'], $text);

        History::create([
            'player_id' => $player->id,
            'scene_id' => $player->location_scene_id,
            'action_key' => $question['key']
        ]);

        if ($isLying) {
            $player->suspicion = min(100, $player->suspicion + 25);
            $responseText = $this->lyingResponse($question['key']);
        } else {
            $player->suspicion = max(0, $player->suspicion - 10);
            $responseText = $this->truthResponse($question['key']);
        }

        // Si es la última pregunta → detener al jugador
        if ($currentQuestionNum === count($this->questions)) {
       $responseText .= "\n\nEl inspector cierra su libreta despacio.\n\"Queda usted detenido como sospechoso de asesinato.\"\n\n Esposas. Frías. Metálicas.\n\nEl pasillo. Las escaleras. Un coche patrulla.\nBarcelona pasa por la ventanilla como si fuera otra ciudad.\n\nUna puerta de hierro.\nUn número grabado en la pared.\nTu nombre en un registro.\n\nBienvenido al calabozo.";
            $player->location_scene_id = 3;
            $player->save();

            return [
                'player' => $this->playerData($player),
                'scene' => 'Pasillo del Hotel',
                'action' => $question['key'],
                'text' => $responseText,
                'next_scene' => 3
            ];
        }

        // Si quedan preguntas, añadir la siguiente
        $nextQuestionNum = $currentQuestionNum + 1;
        if (isset($this->questions[$nextQuestionNum])) {
            $responseText .= "\n\n" . $this->questions[$nextQuestionNum]['text'];
        }

        $player->save();

        return [
            'player' => $this->playerData($player),
            'scene' => 'Pasillo del Hotel',
            'action' => $question['key'],
            'text' => $responseText,
            'next_scene' => null
        ];
    }

    private function detectLie(Player $player, string $questionKey, string $answer): bool
    {
        $answerLower = strtolower($answer);

        switch ($questionKey) {
            case 'nombre':
                $realName = strtolower($player->name);
                $firstName = strtolower(explode(' ', $player->name)[0]);
                return !str_contains($answerLower, $firstName) && !str_contains($answerLower, $realName);

            case 'tocado':
                $hasItems = PlayerItem::where('player_id', $player->id)
                    ->whereIn('item_id', [1, 2])
                    ->exists();
                $saysNo = str_contains($answerLower, 'no') || str_contains($answerLower, 'nada');
                return $hasItems && $saysNo;

            case 'conoce_victima':
                $hasDni = PlayerItem::where('player_id', $player->id)
                    ->where('item_id', 1)
                    ->exists();
                $saysNo = str_contains($answerLower, 'no') || str_contains($answerLower, 'desconozco');
                return $hasDni && $saysNo;

            case 'llamo_recepcion':
                $called = History::where('player_id', $player->id)
                    ->where('action_key', 'llamar_recepcion')
                    ->exists();
                $saysNo = str_contains($answerLower, 'no') || str_contains($answerLower, 'nunca');
                return $called && $saysNo;
        }

        return false;
    }

    private function lyingResponse(string $key): string
    {
        $responses = [
            'nombre' => 'El inspector levanta una ceja. Compara lo que dices con tu documentación. "Interesante." Anota algo en su libreta. Algo no cuadra.',
            'tocado' => 'El inspector mira tus manos. Luego mira su informe. "Curioso. Nuestros técnicos encontraron huellas." Una pausa larga. "Continúe."',
            'conoce_victima' => '"¿No?" Saca el DNI de Tomás y lo pone frente a ti. El mismo que encontraste. "Inténtelo de nuevo."',
            'llamo_recepcion' => '"Qué curioso." Gira el ordenador hacia ti. El registro de llamadas de la habitación 209. Tu llamada. La hora exacta. Te mira.',
        ];

        return $responses[$key] ?? 'El inspector anota algo. No parece convencido.';
    }

    private function truthResponse(string $key): string
    {
        $responses = [
            'nombre' => 'Asiente levemente. Comprueba tu documentación. "Bien."',
            'tocado' => '"Al menos es honesto." Anota algo.',
            'conoce_victima' => 'Frunce el ceño. "¿Cómo sabe su nombre?" Le explicas lo del DNI. Asiente despacio.',
            'llamo_recepcion' => '"Eso cuadra con el registro." Marca algo en su libreta.',
        ];

        return $responses[$key] ?? 'El inspector asiente. Continúa escribiendo.';
    }

    private function playerData(Player $player): array
    {
        return [
            'id' => $player->id,
            'name' => $player->name,
            'sanity' => $player->sanity,
            'suspicion' => $player->suspicion,
            'location_scene_id' => $player->location_scene_id,
        ];
    }
}