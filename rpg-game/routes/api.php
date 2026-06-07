<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GameController;
use App\Http\Controllers\AuthController;


Route::post('/auth/login', [AuthController::class, 'login']);
Route::post('/game/play', [GameController::class, 'play']);
Route::get('/scene/{sceneId}/text/{playerId}', [GameController::class, 'sceneText']);


Route::get('/prison/status/{playerId}', [GameController::class, 'prisonStatus']);
Route::get('/player/{playerId}/history', [GameController::class, 'playerHistory']);

Route::get('/player/{playerId}/inventory', [GameController::class, 'inventory']);
Route::post('/player/{playerId}/reset', [GameController::class, 'resetPlayer']);


Route::post('/player/{playerId}/reset', [GameController::class, 'resetPlayer']);


Route::post('/game/minigame/result', [GameController::class, 'minigameResult']);

Route::get('/characters', [GameController::class, 'characters']);


Route::get('/test', function () {
    return "OK";
});
