<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class NpcDialogue extends Model
{
    use HasFactory;

    protected $fillable = [
        'npc_id',
        'scene_id',
        'trigger',
        'response'
    ];

    public function npc()
    {
        return $this->belongsTo(Npc::class);
    }

    public function scene()
    {
        return $this->belongsTo(Scene::class);
    }
}