<?php

namespace App\Http\Controllers;

use Laravel\Socialite\Facades\Socialite;
use App\Models\Player;
use Illuminate\Support\Str;
use Illuminate\Http\Request;

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
        return redirect("https://clue-the-twins-project-production.up.railway.app/game?token={$player->token}&player_id={$player->id}");
        //  return redirect("http://localhost:5173/game?token={$player->token}&player_id={$player->id}");
    }

    public function guest2()
    {
        $player = Player::create([
            'name' => 'Invitado_' . Str::random(6),
            'email' => 'guest_' . Str::random(8) . '@guest.com',
            'sanity' => 100,
            'suspicion' => 0,
            'location_scene_id' => 1,
            'token' => Str::random(60),
        ]);
        return redirect("https://clue-the-twins-project-production.up.railway.app/game?token={$player->token}&player_id={$player->id}");
        //return redirect("http://localhost:5173/game?token={$player->token}&player_id={$player->id}");
    }

    public function guest(Request $request)
    {
        $name = $request->query('name', 'Invitado_' . Str::random(6));
        $email = $request->query('email')
            ? $request->query('email')
            : 'guest_' . Str::random(8) . '@guest.com';

        // Si el email ya existe, recupera ese jugador
        $player = Player::firstOrCreate(
            ['email' => $email],
            [
                'name' => $name,
                'sanity' => 100,
                'suspicion' => 0,
                'location_scene_id' => 1,
                'token' => Str::random(60),
            ]
        );

        return redirect("https://clue-the-twins-project-production.up.railway.app/game?token={$player->token}&player_id={$player->id}");
    }


    public function register(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:100',
            'email' => 'required|email|unique:players,email',
            'password' => 'required|min:6|confirmed',
        ]);

        $verifyToken = \Illuminate\Support\Str::random(64);

        $player = Player::create([
            'name' => $request->name,
            'email' => $request->email,
            'password' => bcrypt($request->password),
            'sanity' => 100,
            'suspicion' => 0,
            'location_scene_id' => 1,
            'token' => \Illuminate\Support\Str::random(60),
            'email_verified' => false,
            'verify_token' => $verifyToken,
        ]);

        // Enviar email con Resend
        $resend = \Resend::client(env('RESEND_API_KEY'));
        $verifyUrl = "https://clue-the-twins-project-production.up.railway.app/auth/verify?token={$verifyToken}";

        $resend->emails->send([
            'from' => env('MAIL_FROM_ADDRESS'),
            'to' => $player->email,
            'subject' => 'Verifica tu cuenta — Gemelos',
            'html' => "
            <div style='font-family:monospace;background:#000;color:#fff;padding:40px;'>
                <h1>GEMELOS</h1>
                <p>Hola {$player->name},</p>
                <p>Haz click en el enlace para verificar tu cuenta y comenzar a jugar:</p>
                <a href='{$verifyUrl}' style='color:#fff;background:#333;padding:12px 24px;text-decoration:none;border-radius:8px;display:inline-block;margin:16px 0;'>
                    Verificar cuenta
                </a>
                <p style='color:#666;font-size:12px;'>Si no creaste esta cuenta, ignora este email.</p>
            </div>
        "
        ]);

        // Redirige a página de "revisa tu email"
        return redirect("https://clue-the-twins-project-production.up.railway.app/?verified=pending&email={$player->email}");
    }

    public function verify(Request $request)
    {
        $token = $request->query('token');
        $player = Player::where('verify_token', $token)->first();

        if (!$player) {
            return redirect("https://clue-the-twins-project-production.up.railway.app/?error=invalid_token");
        }

        $player->email_verified = true;
        $player->verify_token = null;
        $player->save();

        return redirect("https://clue-the-twins-project-production.up.railway.app/game?token={$player->token}&player_id={$player->id}");
    }

    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required',
        ]);

        $player = Player::where('email', $request->email)->first();

        if (!$player || !password_verify($request->password, $player->password)) {
            return response()->json(['error' => 'Credenciales incorrectas'], 401);
        }

        if (!$player->email_verified) {
            return response()->json(['error' => 'Verifica tu email antes de entrar.'], 403);
        }

        return response()->json([
            'token' => $player->token,
            'player_id' => $player->id,
        ]);
    }
}
