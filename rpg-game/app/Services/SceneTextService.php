<?php

namespace App\Services;

use App\Models\SceneText;
use App\Models\PlayerItem;

class SceneTextService
{
    public function getText(int $sceneId, int $playerId, int $visitCount): ?SceneText
    {
        $playerItemIds = PlayerItem::where('player_id', $playerId)
            ->pluck('item_id')
            ->toArray();

        // Busca todos los textos de la escena
        $texts = SceneText::where('scene_id', $sceneId)->get();

        $candidates = $texts->filter(function ($t) use ($visitCount, $playerItemIds) {
            // Filtrar por visit_number si está definido
            if ($t->visit_number !== null && $t->visit_number !== $visitCount) {
                return false;
            }
            // Filtrar por min_visits si está definido
            if ($t->min_visits !== null && $visitCount < $t->min_visits) {
                return false;
            }
            // Filtrar por item requerido si está definido
            if ($t->required_item_id !== null && !in_array($t->required_item_id, $playerItemIds)) {
                return false;
            }
            return true;
        });

        return $candidates->sortByDesc('priority')->first();
    }
}