<?php

namespace App\Services;

use App\Models\Player;
use App\Models\PlayerAction;
use App\Models\History;
use App\Models\PlayerItem;

class PrisonService
{
    // Respuestas válidas para el acertijo
    private array $validAnswers = [
        'nadie',
        'nobody',
        'no hay inspector',
        'el muerto es rafael',
        'no mató al inspector',
        'ninguno',
        'el inspector no está muerto',
        'rafael',
        'nadie mató',
        'el muerto no es el inspector',
        'tomas',
        'el muerto es tomas'
    ];

    public function isInPrison(Player $player): bool
    {
        return $player->location_scene_id === 3;
    }

    public function getReleaseTime(Player $player): ?\Carbon\Carbon
    {
        $entry = History::where('player_id', $player->id)
            ->where('scene_id', 3)
            ->orderBy('id', 'asc')
            ->first();

        if (!$entry) return null;

        return \Carbon\Carbon::parse($entry->created_at)->addHours(48);
    }

    public function canBeReleased(Player $player): bool
    {
        $releaseTime = $this->getReleaseTime($player);
        if (!$releaseTime) return false;
        return now()->gte($releaseTime);
    }

    public function handlePrisonAction(Player $player, string $text): ?array
    {
        // Comprobar si puede salir
        if ($this->canBeReleased($player)) {
            $player->location_scene_id = 11;
            $player->save();
            return [
                'player' => $this->playerData($player),
                'scene' => 'Calabozo',
                'action' => 'liberado',
                'text' => 'Un guardia abre tu celda.\n"Es su hora. Recoja sus cosas."\n\nHan pasado 48 horas.',
                'next_scene' => 11
            ];
        }

        // Detectar si está respondiendo al acertijo
        if ($this->isAnsweringRiddle($player, $text)) {
            return $this->handleRiddleAnswer($player, $text);
        }

        return null; // Continuar con lógica normal
    }

    private function isAnsweringRiddle(Player $player, string $text): bool
    {
        // El jugador habló con el preso derecha al menos una vez
        $talkedToRight = PlayerAction::where('player_id', $player->id)
            ->where('action', 'hablar_derecha')
            ->exists();

        if (!$talkedToRight) return false;

        // No ha resuelto el acertijo aún
        $solved = PlayerAction::where('player_id', $player->id)
            ->where('action', 'acertijo_resuelto')
            ->exists();

        if ($solved) return false;

        // El texto no es una acción conocida
        $knownActions = ['hablar_izquierda', 'hablar_derecha', 'esperar', 'intentar_salir'];
        $textLower = strtolower($text);
        foreach ($knownActions as $action) {
            if (str_contains($textLower, str_replace('_', ' ', $action))) {
                return false;
            }
        }

        return true;
    }

    private function handleRiddleAnswer(Player $player, string $text): array
    {
        $textLower = strtolower(trim($text));
        $correct = false;

        foreach ($this->validAnswers as $valid) {
            if (str_contains($textLower, $valid)) {
                $correct = true;
                break;
            }
        }

        if ($correct) {
            // Marcar acertijo como resuelto
            PlayerAction::create([
                'player_id' => $player->id,
                'action' => 'acertijo_resuelto'
            ]);

            History::create([
                'player_id' => $player->id,
                'scene_id' => 3,
                'action_key' => 'acertijo_resuelto'
            ]);

            return [
                'player' => $this->playerData($player),
                'scene' => 'Calabozo',
                'action' => 'acertijo_resuelto',
                'text' => 'El preso sonríe despacio.\n"Exacto. Nadie mató al inspector."\nUna pausa larga.\n"Igual que nadie mató a Tomás."\n\nSe acerca más a los barrotes y baja la voz.\n\n"Ese hombre llevaba semanas en ese hotel. Solo. Su mujer no sabía que estaba allí. O eso creía él."\n\nSe aleja y se tumba en su catre.\n"Ya tienes lo que necesitabas."',
                'next_scene' => null
            ];
        }

        return [
            'player' => $this->playerData($player),
            'scene' => 'Calabozo',
            'action' => 'acertijo_fallado',
            'text' => 'El preso niega con la cabeza.\n "Piénsalo mejor." \n Se gira hacia la pared.',
            'next_scene' => null
        ];
    }

    public function timeRemaining(Player $player): string
    {
        $releaseTime = $this->getReleaseTime($player);
        if (!$releaseTime) return '48 horas';

        $diff = now()->diff($releaseTime);
        if ($diff->invert) return 'Puedes salir';

        return $diff->h . ' horas y ' . $diff->i . ' minutos';
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
