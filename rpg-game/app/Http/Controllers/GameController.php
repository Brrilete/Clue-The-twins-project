<?php

namespace App\Http\Controllers;

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
}