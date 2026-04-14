<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\GameController;

Route::post('/game/play', [GameController::class, 'play']);

Route::get('/test', function () {
    return "OK";
});