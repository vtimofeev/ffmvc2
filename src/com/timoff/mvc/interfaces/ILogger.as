/**
 * Author: Vasily Timofeev
 * Web: http://timoff.com
 */
package com.timoff.mvc.interfaces {
public interface ILogger {

    function get isDebug():Boolean;
    function get isInfo():Boolean;
    function get isError():Boolean;

    function debug(value:String, name:String):void;
    function info(value:String, name:String):void;
    function error(value:String, name:String):void;
    function fatal(value:String, name:String):void

}
}
