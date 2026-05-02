<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class AIService
{
    public function classify(string $text, array $options)
    {
        $url = config('services.ai.url') . '/clasificar';

        $response = Http::timeout(120)
            ->retry(2, 200)
            ->post($url, [
                'text' => $text,
                'options' => $options
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
