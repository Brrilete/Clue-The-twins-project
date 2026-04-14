<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Scene extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'description'
    ];

    public function actions()
    {
        return $this->hasMany(Action::class);
    }

    public function transitions()
    {
        return $this->hasMany(Transition::class, 'from_scene_id');
    }
}