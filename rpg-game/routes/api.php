<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GameController;


Route::post('/game/play', [GameController::class, 'play']);
Route::get('/scene/{sceneId}/text/{playerId}', [GameController::class, 'sceneText']);


Route::get('/prison/status/{playerId}', [GameController::class, 'prisonStatus']);

Route::get('/player/{playerId}/history', [GameController::class, 'playerHistory']);
Route::post('/player/{playerId}/reset', [GameController::class, 'resetPlayer']);
Route::get('/test', function () {
    return "OK";
});