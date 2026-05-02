<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class History extends Model
{
    use HasFactory;
    protected $table = 'history';

    public $timestamps = false;
    protected $fillable = [
        'player_id',
        'scene_id',
        'action_key',
        'message',
        'is_player',
    ];

    public function player()
    {
        return $this->belongsTo(Player::class);
    }

    public function scene()
    {
        return $this->belongsTo(Scene::class);
    }
}