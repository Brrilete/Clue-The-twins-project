<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Player extends Model
{
    protected $fillable = [
        'name',
        'current_scene_id',
        'fatigue',
        'suspicion',
        'intelligence'
    ];
}