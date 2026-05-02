<?php

namespace App\Console\Commands;

use Illuminate\Console\Command;
use App\Models\Player;
use App\Models\PlayerItem;
use App\Models\PlayerAction;
use App\Models\History;

class ResetPlayer extends Command
{
    protected $signature = 'player:reset {player_id}';
    protected $description = 'Resetea el progreso de un jugador';

    public function handle()
    {
        $playerId = $this->argument('player_id');
        $player = Player::find($playerId);

        if (!$player) {
            $this->error("Jugador $playerId no encontrado.");
            return;
        }

        PlayerItem::where('player_id', $playerId)->delete();
        PlayerAction::where('player_id', $playerId)->delete();
        History::where('player_id', $playerId)->delete();

        $player->location_scene_id = 1;
        $player->sanity = 100;
        $player->suspicion = 0;
        $player->save();

        $this->info("Jugador '{$player->name}' (ID: $playerId) reseteado correctamente.");
    }
}