<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;

class AIService
{
    public function classify(string $text, array $options)
    {
        $response = Http::timeout(10)->post('http://127.0.0.1:8000/clasificar', [
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