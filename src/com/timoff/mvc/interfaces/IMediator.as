/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces
{
import flash.display.DisplayObject;

public interface IMediator extends INotifier, IObserver, IBase {

    function get view():DisplayObject;
    function set view(view:DisplayObject):void;

    function registerHandler():void;
    function removeHandler():void;
}
}