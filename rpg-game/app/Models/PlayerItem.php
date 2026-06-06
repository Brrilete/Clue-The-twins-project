<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class PlayerItem extends Model
{
    protected $table = 'player_items';
    public $timestamps = false;
    protected $fillable = [
        'player_id',
        'item_id'
    ];
    public function item()
    {
        return $this->belongsTo(Item::class);
    }
}
