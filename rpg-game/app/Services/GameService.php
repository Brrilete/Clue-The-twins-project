<?php

namespace App\Services;

use App\Models\Player;
use App\Models\History;
use App\Models\PlayerAction;
use App\Models\ActionRule;
use App\Models\PlayerItem;
use App\Models\Item;

class GameService
{
    protected $ai;
    protected $sceneService;

    public function __construct(AIService $ai, SceneService $sceneService)
    {
        $this->ai = $ai;
        $this->sceneService = $sceneService;
    }

    public function play(Player $player, string $text)
    {
        // 1. cargar escena actual
        $scene = $this->sceneService->getScene($player->location_scene_id);

        // 2. opciones disponibles
        $options = $this->sceneService->getOptions($scene);

        // 3. IA clasifica acción
        $result = $this->ai->classify($text, $options);
        $action = $result['opcion'] ?? array_key_first($options);

        // 4. guardar historial general
        History::create([
            'player_id' => $player->id,
            'scene_id' => $scene->id,
            'action_key' => $action
        ]);

        // 5. guardar acción del jugador (contador real)
        PlayerAction::create([
            'player_id' => $player->id,
            'action' => $action
        ]);

        // 6. calcular cuántas veces ha hecho esa acción
        $count = PlayerAction::where('player_id', $player->id)
            ->where('action', $action)
            ->count();
        // 7. buscar regla en BD
        $rule = ActionRule::where('action', $action)
            ->where('count', '<=', $count)
            ->orderBy('count', 'desc')
            ->first();

        $responseText = null;
        // 8. aplicar regla si existe
        if ($rule) {
 
            switch ($rule->effect) {

                case 'lose_wallet':
                    $player->wallet_lost = true;
                    break;

                case 'find_clue_restore_wallet':
                    // recuperar cartera

                    // buscar item "llaves"
                    $item = Item::where('name', 'Llaves de la casa de la víctima')->first();

                    if ($item) {
                        PlayerItem::firstOrCreate([
                            'player_id' => $player->id,
                            'item_id' => $item->id
                        ]);
                    }
  $player->save();
                    break;
                case 'none':
                default:
                    // no cambios en estado
                    break;
            }

            $responseText = $rule->message;
        }

        // 9. resolver transición de escena (solo si no es bloqueado por regla)
        $nextScene = $this->sceneService->resolveTransition($action, $scene->id);

        if ($nextScene) {
            $player->location_scene_id = $nextScene;
        }

        $player->save();

        // 10. respuesta final (SIEMPRE desde BD si existe regla)
        return [
            'player' => [
                'id' => $player->id,
                'name' => $player->name,
                'sanity' => $player->sanity,
                'suspicion' => $player->suspicion,
                'location_scene_id' => $player->location_scene_id,
            ],
            'scene' => $scene->name,
            'action' => $action,
            'text' => $responseText ?? 'No ocurre nada relevante...',
            'next_scene' => $nextScene
        ];
    }
}
