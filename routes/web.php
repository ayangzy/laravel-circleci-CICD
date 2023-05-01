<?php

use Illuminate\Support\Facades\Redis;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return view('welcome');
});

Route::get('/cache/save', function () {
    Redis::set('test_key', 'This is the value of data saved in cache');
    return 'Data saved to cache';
});

Route::get('/cache/retrieve', function () {
    $value = Redis::get('test_key');
    if (!$value) {
        return 'No data found in cache';
    }
    return "Data retrieved from cache: $value";
});
