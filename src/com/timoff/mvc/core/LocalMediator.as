/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.core
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;

	public class LocalMediator extends EventDispatcher
	{
		protected var _view:DisplayObject;
		protected var _mediators:Array = [];

		public function LocalMediator(view:DisplayObject)
		{
            super();

			if (!view)
				throw new Error("View isn't found at " + this);

			this.view = view;
			initView();
            addListeners();
		}

		protected function initView():void
		{
		}

        protected function addListeners():void
        {
        }

        public function redispatchEvent(event:Event):void
        {
            dispatchEvent(event);
        }

		public function get view():DisplayObject
		{
			return _view;
		}

		public function set view(value:DisplayObject):void
		{
			_view = value;
			return;
		}

		protected function addMediator(mediator:LocalMediator):void
		{
			_mediators.push(mediator);
		}
	}
}