<?php
namespace App\Services;
use Illuminate\Support\Facades\Http;
class AIService
{
    public function classify(string $text, array $options): array
    {
        try {
            $url = config('services.ai.url') . '/clasificar';
            $response = Http::timeout(10)
                ->post($url, [
                    'text' => $text,
                    'options' => $options
                ]);
            if ($response->successful()) {
                return $response->json();
            }
        } catch (\Exception $e) {
            // IA no disponible, usar fallback
        }
        return [
            'opcion' => array_key_first($options),
            'top' => []
        ];
    }
}
