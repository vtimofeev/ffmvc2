/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces {
public interface IController {
    function registerCommand(type:String, value:Class):void;
    function removeCommand(value:Class):void;
    function hasCommand(value:Class):Boolean;
    function initializeController():void;
}
}
