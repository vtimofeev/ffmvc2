/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.data
{
/**
 * Event caller contains constans of component types.
 *
 * Cодержит константы типов компонентов.
 */
	public class EventCaller
	{
		public static const CALLER_NONE:uint = 0x0;
        public static const CALLER_MODEL:uint = 0x1;
        public static const CALLER_MEDIATOR:uint = 0x2;
        public static const CALLER_CONTROLLER:uint = 0x3;
		public static const CALLER_VIEW:uint = 0x4;
		public static const CALLER_STAGE:uint = 0x5;

	}
}