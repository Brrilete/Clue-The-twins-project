<?php

namespace App\Http\Controllers;

use Laravel\Socialite\Facades\Socialite;
use App\Models\Player;
use Illuminate\Support\Str;

class AuthController extends Controller
{
    public function redirectToGoogle()
    {
        return Socialite::driver('google')->stateless()->redirect();
    }

    public function handleGoogleCallback()
    {
        $socialUser = Socialite::driver('google')->stateless()->user();
        return $this->handleSocialLogin($socialUser);
    }

    public function redirectToGithub()
    {
        return Socialite::driver('github')->stateless()->redirect();
    }

    public function handleGithubCallback()
    {
        $socialUser = Socialite::driver('github')->stateless()->user();
        return $this->handleSocialLogin($socialUser);
    }

    private function handleSocialLogin($socialUser)
    {
        $player = Player::firstOrCreate(
            ['email' => $socialUser->getEmail()],
            [
                'name' => $socialUser->getName() ?? $socialUser->getNickname(),
                'sanity' => 100,
                'suspicion' => 0,
                'location_scene_id' => 1,
                'token' => Str::random(60),
            ]
        );

        // Redirige al frontend con el token y player_id
        return redirect("https://petroleum-blah-dinner.ngrok-free.dev/game?token={$player->token}&player_id={$player->id}");
      //  return redirect("http://localhost:5173/game?token={$player->token}&player_id={$player->id}");
    }

    public function guest()
    {
        $player = Player::create([
            'name' => 'Invitado_' . Str::random(6),
            'email' => 'guest_' . Str::random(8) . '@guest.com',
            'sanity' => 100,
            'suspicion' => 0,
            'location_scene_id' => 1,
            'token' => Str::random(60),
        ]);
        return redirect("https://petroleum-blah-dinner.ngrok-free.dev/game?token={$player->token}&player_id={$player->id}");
        //return redirect("http://localhost:5173/game?token={$player->token}&player_id={$player->id}");
    }
}
