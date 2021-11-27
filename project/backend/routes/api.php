<?php
use App\Providers\RouteServiceProvider;
use Illuminate\Http\Request;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/
// Route::group(['middleware' => 'auth:api'], function () {
    /* ルーティングリソース配置　メソッド個別指定 */
    
    Route::apiResources([
        /* ルーティングリソース配置 */
        // 'v1/Sample' => 'SampleController',
        'v1/Test' => 'Api\TestController'
    ]);
// });
