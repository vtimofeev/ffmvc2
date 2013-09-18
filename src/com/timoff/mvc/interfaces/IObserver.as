/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces
{
	import com.timoff.mvc.event.FacadeEvent;
	
	public interface IObserver
	{
        function get eventInterests():Array;
        function handleEvent(event:FacadeEvent):void;
		/*
		function setNotifyContext( notifyContext:Object ):void;
		function notifyObserver( notification:INotification ):void;
		function compareNotifyContext( object:Object ):Boolean;
		*/
	}
}