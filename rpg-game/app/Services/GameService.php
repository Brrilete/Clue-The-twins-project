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
    protected $interrogationService;
    protected $prisonService;

    public function __construct(AIService $ai, SceneService $sceneService, InterrogationService $interrogationService, PrisonService $prisonService)
    {
        $this->ai = $ai;
        $this->sceneService = $sceneService;
        $this->interrogationService = $interrogationService;
        $this->prisonService = $prisonService;
    }

    public function play(Player $player, string $text)
    {
        // Guardar input del jugador
        History::create([
            'player_id' => $player->id,
            'scene_id' => $player->location_scene_id,
            'action_key' => 'player_input',
            'message' => $text,
            'is_player' => 1,
        ]);

        // Calabozo
        if ($player->location_scene_id === 3) {
            $prisonResult = $this->prisonService->handlePrisonAction($player, $text);
            if ($prisonResult) {
                $this->saveResponse($player, $prisonResult['text'], $prisonResult['action']);
                return $prisonResult;
            }
        }

        // Interrogatorio
        if ($player->location_scene_id === 2) {
            $result = $this->interrogationService->handle($player, $text);
            $this->saveResponse($player, $result['text'], $result['action']);
            return $result;
        }

        // Lógica normal
        $scene = $this->sceneService->getScene($player->location_scene_id);
        $options = $this->sceneService->getOptions($scene);

        $result = $this->ai->classify($text, $options);
        $action = $result['opcion'] ?? array_key_first($options);

        PlayerAction::create([
            'player_id' => $player->id,
            'action' => $action
        ]);

        $count = PlayerAction::where('player_id', $player->id)
            ->where('action', $action)
            ->count();

        $rule = ActionRule::where('action', $action)
            ->where('count', '<=', $count)
            ->orderBy('count', 'desc')
            ->first();

        $responseText = null;

        if ($rule) {
            $this->applyEffect($rule->effect, $player);
            $responseText = $rule->message;
        }

        $nextScene = $this->sceneService->resolveTransition($action, $scene->id);
        if ($nextScene) {
            $player->location_scene_id = $nextScene;
        }

        $player->save();

        $finalText = $responseText ?? 'No ocurre nada relevante...';

        // Guardar respuesta del sistema
        History::create([
            'player_id' => $player->id,
            'scene_id' => $scene->id,
            'action_key' => $action,
            'message' => $finalText,
            'is_player' => 0,
        ]);

        return [
            'player' => $this->playerData($player),
            'scene' => $scene->name,
            'action' => $action,
            'text' => $finalText,
            'next_scene' => $nextScene
        ];
    }

    private function saveResponse(Player $player, string $text, string $action): void
    {
        History::create([
            'player_id' => $player->id,
            'scene_id' => $player->location_scene_id,
            'action_key' => $action,
            'message' => $text,
            'is_player' => 0,
        ]);
    }

    private function applyEffect(string $effect, Player $player)
    {
        if ($effect === 'increase_suspicion') {
            $player->suspicion = min(100, $player->suspicion + 20);
            return;
        }
        if ($effect === 'decrease_suspicion') {
            $player->suspicion = max(0, $player->suspicion - 10);
            return;
        }
        if (str_starts_with($effect, 'find_item:')) {
            $itemId = (int) str_replace('find_item:', '', $effect);
            PlayerItem::firstOrCreate([
                'player_id' => $player->id,
                'item_id' => $itemId
            ]);
            return;
        }
        switch ($effect) {
            case 'lose_wallet':
                $player->wallet_lost = true;
                break;
            case 'find_clue_restore_wallet':
                $item = Item::where('name', 'Llaves de la casa de la víctima')->first();
                if ($item) {
                    PlayerItem::firstOrCreate([
                        'player_id' => $player->id,
                        'item_id' => $item->id
                    ]);
                }
                break;
        }
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