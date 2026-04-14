<?php

namespace App\Services;

use App\Models\Scene;
use App\Models\Transition;

class SceneService
{
    public function getScene(int $sceneId)
    {
        return Scene::with('actions')->findOrFail($sceneId);
    }

    public function getOptions(Scene $scene)
    {
        $options = [];

        foreach ($scene->actions as $action) {
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