<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class AIService
{
    public function classify(string $text, array $options, int $sceneId = 0)
    {
        $url = config('services.ai.url') . '/clasificar';

        $response = Http::timeout(120)
            ->post($url, [
                'text' => $text,
                'options' => $options,
                'scene_id' => $sceneId,
            ]);

        if (!$response->successful()) {
            return [
                'opcion' => array_key_first($options),
                'top' => []
            ];
        }

        return $response->json();
    }
}
