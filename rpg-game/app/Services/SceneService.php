<?php

namespace App\Services;

use App\Models\Scene;
use App\Models\Transition;
use App\Models\Player;

class SceneService
{
    public function getScene(int $sceneId)
    {
        return Scene::with('actions')->findOrFail($sceneId);
    }

    public function getOptions(Scene $scene, Player $player = null)
    {
        $options = [];
        foreach ($scene->actions as $action) {
            // Ocultar invitar_cerveza_servicio si el jugador no ha ido al servicio
            if ($action->key_name === 'invitar_cerveza_servicio' && $player) {
                $hasBeenToService = \App\Models\History::where('player_id', $player->id)
                    ->where('scene_id', 5)
                    ->where('action_key', 'ir_servicio')
                    ->exists();
                if (!$hasBeenToService) continue;
            }
            $options[$action->key_name] = $action->label;
        }
        return $options;
    }

    public function resolveTransition(string $actionKey, int $currentSceneId)
    {
        $transition = Transition::where('action_key', $actionKey)
            ->where('from_scene_id', $currentSceneId)
            ->first();

        return $transition ? $transition->to_scene_id : null;
    }
}
