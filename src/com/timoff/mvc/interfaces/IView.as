/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces {
public interface IView {
		function registerMediator( value:IMediator ) : void;
		function retrieveMediator( value:String ) : IMediator;
		function removeMediator( value:String ) : IMediator;
		function hasMediator( value:String ) : Boolean;
        function initializeView():void;
}
}
