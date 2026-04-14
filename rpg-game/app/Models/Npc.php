<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Npc extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'personality'
    ];

    public function dialogues()
    {
        return $this->hasMany(NpcDialogue::class);
    }
}