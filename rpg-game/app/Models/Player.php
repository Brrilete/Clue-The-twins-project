<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Player extends Model
{
    use HasFactory;
    public $timestamps = false;  // ← añade esta línea

    protected $fillable = [
        'name',
        'sanity',
        'suspicion',
        'location_scene_id',
        'email', 
        'token',
    ];

    public function scene()
    {
        return $this->belongsTo(Scene::class, 'location_scene_id');
    }

    public function items()
    {
        return $this->belongsToMany(Item::class, 'player_items');
    }

    public function history()
    {
        return $this->hasMany(History::class);
    }
}