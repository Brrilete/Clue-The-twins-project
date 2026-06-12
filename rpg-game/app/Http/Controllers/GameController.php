<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Models\Player;
use App\Services\GameService;
use Illuminate\Support\Facades\DB;

class GameController extends Controller
{
    protected $game;

    public function __construct(GameService $game)
    {
        $this->game = $game;
    }

    public function play(Request $request)
    {
        $request->validate([
            'player_id' => 'required|integer',
            'text' => 'required|string'
        ]);
        $player = Player::findOrFail($request->player_id);
        $result = $this->game->play($player, $request->text);

        return response()->json($result);
    }
    public function sceneText(int $sceneId, int $playerId)
    {
        $player = Player::findOrFail($playerId);
        $lang = $player->language ?? 'es';

        $visitCount = \App\Models\History::where('player_id', $playerId)
            ->where('scene_id', $sceneId)
            ->where('action_key', 'scene_load')
            ->count() + 1;

        $sceneTextService = new \App\Services\SceneTextService();
        $sceneText = $sceneTextService->getText($sceneId, $playerId, $visitCount);

        $text = $lang === 'en'
            ? ($sceneText?->text_en ?? $sceneText?->text ?? 'You arrive somewhere new...')
            : ($sceneText?->text ?? 'Llegas a un nuevo lugar...');

        $sceneData = DB::table('scenes')->where('id', $sceneId)->first();
        $imageUrl = $sceneData?->image_url ?? null;

        \App\Models\History::create([
            'player_id' => $playerId,
            'scene_id' => $sceneId,
            'action_key' => 'scene_load',
            'message' => $text,
            'is_player' => 0,
            'character' => $sceneText?->character ?? null,
        ]);

        return response()->json([
            'text' => $text,
            'image_url' => $imageUrl,
            'character' => $sceneText?->character ?? null,
        ]);
    }

    public function prisonStatus(int $playerId)
    {
        $player = Player::findOrFail($playerId);
        $prisonService = new \App\Services\PrisonService();

        return response()->json([
            'in_prison' => $prisonService->isInPrison($player),
            'can_be_released' => $prisonService->canBeReleased($player),
            'time_remaining' => $prisonService->timeRemaining($player),
        ]);
    }
    public function playerHistory(int $playerId)
    {
        $player = Player::findOrFail($playerId);

        $history = \App\Models\History::where('player_id', $playerId)
            ->whereNotNull('message')
            ->orderBy('id', 'asc')
            ->get();

        $messages = $history->map(fn($h) => [
            'text' => $h->message,
            'isPlayer' => (bool) $h->is_player,
            'character' => $h->character ?? null,
        ]);

        return response()->json([
            'player' => [
                'id' => $player->id,
                'name' => $player->name,
                'role' => $player->role,  // ← añade esto
                'location_scene_id' => $player->location_scene_id,
                'suspicion' => $player->suspicion,
                'sanity' => $player->sanity,
                'language' => $player->language ?? 'es',

            ],
            'messages' => $messages
        ]);
    }



    public function resetPlayer(int $playerId, Request $request)
    {
        $requester = Player::findOrFail($request->input('requester_id'));

        if (!in_array($requester->role, ['admin', 'advanced'])) {
            return response()->json(['error' => 'No autorizado'], 403);
        }

        $player = Player::findOrFail($playerId);

        \App\Models\PlayerItem::where('player_id', $playerId)->delete();
        \App\Models\PlayerAction::where('player_id', $playerId)->delete();
        \App\Models\History::where('player_id', $playerId)->delete();

        $player->location_scene_id = 1;
        $player->sanity = 100;
        $player->suspicion = 0;
        $player->save();

        return response()->json(['success' => true]);
    }


    public function inventory(int $playerId)
    {
        $items = \App\Models\PlayerItem::where('player_id', $playerId)
            ->with('item')
            ->get()
            ->map(fn($pi) => [
                'id' => $pi->item->id,
                'name' => $pi->item->name,
                'description' => $pi->item->description,
            ]);

        return response()->json(['items' => $items]);
    }

    public function minigameResult(Request $request)
    {
        $request->validate([
            'player_id' => 'required|integer',
            'game' => 'required|string',
            'result' => 'required|in:win,lose,draw',
            'score' => 'nullable|integer',
        ]);

        $player = Player::findOrFail($request->player_id);

        $message = '';

        if ($request->result === 'win') {
            $player->suspicion = max(0, $player->suspicion - 10);
            $message = 'Ganas la mano. El crupier te mira con respeto.\nAlgo en el ambiente cambia.';
        } elseif ($request->result === 'lose') {
            $player->suspicion = min(100, $player->suspicion + 5);
            $message = 'Pierdes. El dinero desaparece de la mesa.\nAlguien al fondo te observa.';
        } else {
            $message = 'Empate. Recuperas lo apostado.\nNadie gana. Nadie pierde.';
        }

        // Tras 3 victorias → crupier da información
        $wins = \App\Models\History::where('player_id', $player->id)
            ->where('action_key', 'blackjack_win')
            ->count();

        if ($request->result === 'win' && $wins >= 2) {
            $message .= "\n\nEl crupier se inclina hacia ti mientras recoge las cartas.\n\"El hombre de la foto que me enseñaste.\nLe vi aquí hace tres semanas.\nPerdió mucho dinero.\nSalió con alguien que no conocía.\"";

            \App\Models\History::create([
                'player_id' => $player->id,
                'scene_id' => $player->location_scene_id,
                'action_key' => 'blackjack_info',
                'message' => $message,
                'is_player' => 0,
            ]);
        }

        \App\Models\History::create([
            'player_id' => $player->id,
            'scene_id' => $player->location_scene_id,
            'action_key' => 'blackjack_' . $request->result,
            'message' => $message,
            'is_player' => 0,
        ]);

        $player->save();

        return response()->json([
            'message' => $message,
            'player' => [
                'id' => $player->id,
                'suspicion' => $player->suspicion,
                'sanity' => $player->sanity,
            ]
        ]);
    }


    public function characters()
    {
        $characters = DB::table('characters')->get();
        $map = [];
        foreach ($characters as $c) {
            $map[$c->key] = $c->image_url;
        }
        return response()->json($map);
    }


    public function setLanguage(int $playerId, Request $request)
{
    $player = Player::findOrFail($playerId);
    $player->language = $request->input('language', 'es');
    $player->save();
    return response()->json(['success' => true]);
}
}
