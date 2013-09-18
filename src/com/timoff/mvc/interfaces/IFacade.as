/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces
{
	
	import flash.display.DisplayObject;
	
	import com.timoff.mvc.event.FacadeEvent;
	import com.timoff.mvc.event.EventManager;

import flash.display.DisplayObjectContainer;

public interface IFacade
	{
        function getModel():IModel;
        function getControllers():Vector.<IController>;
        function getView():IView;

        function getMediator(name:String):IMediator;
        function getProxy(name:String):IProxy;
        function getEventManager():EventManager;

        function getLogger():ILogger;

        function get viewReference():DisplayObjectContainer;
        function set viewReference(value:DisplayObjectContainer):void;

        function dispatchFacadeEvent( event:FacadeEvent ):void;
        function dispatchExternalEvent( event:FacadeEvent ):void;

        function initFacade(updatedViewReference:DisplayObjectContainer = null):void;

        function get name():String;
    }
}