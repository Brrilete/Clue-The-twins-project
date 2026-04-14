<?php


namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ActionRule extends Model
{
    protected $fillable = [
        'action',
        'count',
        'effect',
        'message'
    ];
}