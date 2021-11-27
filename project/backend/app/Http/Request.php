<?php
/**
 * always json
 * - public/index.phpでRequestクラスを直接書き換え
 * - 以下は入れ替わってるのを確認
 *    - `request()`
 *    - `\Illuminate\Support\Facades\Request::getFacadeRoot()`
 *    - DI: `function hoge(Request $req) {}`
 * ほかになにか使われ方あったっけ..
 */
namespace App\Http;

class Request extends \Illuminate\Http\Request
{
    /**
     * override
     */
    public function expectsJson()
    {
        return true;
    }

    /**
     * override
     */
    public function wantsJson()
    {
        return true;
    }
}