<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Log;
use Illuminate\Http\Request;
use App\Models\Player;
use App\Services\GameService;

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

    $visitCount = \App\Models\History::where('player_id', $playerId)
        ->where('scene_id', $sceneId)
        ->where('action_key', 'scene_load')
        ->count() + 1;

    $sceneTextService = new \App\Services\SceneTextService();
    $sceneText = $sceneTextService->getText($sceneId, $playerId, $visitCount);

    $text = $sceneText?->text ?? 'Llegas a un nuevo lugar...';

    // Guardar en historial
    \App\Models\History::create([
        'player_id' => $playerId,
        'scene_id' => $sceneId,
        'action_key' => 'scene_load',
        'message' => $text,
        'is_player' => 0,
    ]);

    return response()->json([
        'text' => $text,
        'image_url' => $sceneText?->image_url ?? null,
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
        ]);

        return response()->json([
            'player' => [
                'id' => $player->id,
                'name' => $player->name,
                'role' => $player->role,  // ← añade esto
                'location_scene_id' => $player->location_scene_id,
                'suspicion' => $player->suspicion,
                'sanity' => $player->sanity,
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
}
