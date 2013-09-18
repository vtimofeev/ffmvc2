/**
 * Author: Vasily Timofeev
 * Web: http://timoff.com
 */
package com.timoff.mvc.interfaces {
public interface ILogTarget {

    function get isDebug():Boolean;
    function get isInfo():Boolean;
    function get isError():Boolean;

    function debug(value:String):void;
    function info(value:String):void;
    function error(value:String):void;
    function fatal(value:String):void;

}
}
