/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces {
import com.timoff.mvc.event.FacadeEvent;

public interface IMVCDisplayObjectView {
    function set notifier(value:INotifier):void;
    function get notifier():INotifier;
    function dispatchSimpleFacadeEvent(eventName:String):void;
    function dispatchFacadeEvent(event:FacadeEvent):void;
}
}
