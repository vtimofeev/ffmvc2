/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces
{
	import com.timoff.mvc.event.FacadeEvent;

	public interface ICommand
	{
		/**
		 * Execute the <code>ICommand</code>'s logic to handle a given <code>INotification</code>.
		 * 
		 * @param note an <code>INotification</code> to handle.
		 */

        function set facade(value:IFacade):void;
        function get facade():IFacade;
        function get logger():ILogTarget;

		function execute( event:FacadeEvent ) : void;
	}
}