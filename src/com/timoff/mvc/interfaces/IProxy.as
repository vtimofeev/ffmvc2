package com.timoff.mvc.interfaces
{
	public interface IProxy extends INotifier
	{
		
		/**
		 * Set the data object
		 * @param data a data object
		 */
		function setData( data:Object ):void;
		
		/**
		 * Get the data object
		 * @return the data as type Object
		 */
		function getData():Object; 
		
		/**
		 * Called by Model when a proxy is created
		 */ 
		function registerHandler( ):void;

		/**
		 * Called by Model when a proxy is removed
		 */ 
		function removeHandler( ):void;
	}
}