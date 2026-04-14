<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Npc extends Model
{
    protected $fillable = [
        'name',
        'scene_id',
        'personality_json',
        'memory_json'
    ];
}