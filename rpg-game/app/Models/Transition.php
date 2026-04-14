<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Transition extends Model
{
    use HasFactory;

    protected $fillable = [
        'action_key',
        'from_scene_id',
        'to_scene_id'
    ];

    public function fromScene()
    {
        return $this->belongsTo(Scene::class, 'from_scene_id');
    }

    public function toScene()
    {
        return $this->belongsTo(Scene::class, 'to_scene_id');
    }
}