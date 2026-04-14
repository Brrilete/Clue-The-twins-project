<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\Factories\HasFactory;

class Action extends Model
{
    use HasFactory;

    protected $fillable = [
        'scene_id',
        'key_name',
        'label'
    ];

    public function scene()
    {
        return $this->belongsTo(Scene::class);
    }
}