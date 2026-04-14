<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerAction extends Model
{
    protected $fillable = [
        'player_id',
        'action'
    ];
}