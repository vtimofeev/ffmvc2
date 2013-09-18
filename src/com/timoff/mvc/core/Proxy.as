/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.core
{
	import com.timoff.mvc.interfaces.*;
	
	/**
	 * In PureMVC, <code>Proxy</code> classes are used to manage parts of the
	 * application's data model.
	 * 
	 * <P>
	 * A <code>Proxy</code> might simply manage a reference to a local data object, 
	 * in which case interacting with it might involve setting and 
	 * getting of its data in synchronous fashion.</P>
	 * 
	 * <P>
	 * <code>Proxy</code> classes are also used to encapsulate the application's 
	 * interaction with remote services to save or retrieve data, in which case, 
	 * we adopt an asyncronous idiom; setting data (or calling a method) on the 
	 * <code>Proxy</code> and listening for a <code>Notification</code> to be sent 
	 * when the <code>Proxy</code> has retrieved the data from the service. </P>
	 *
     * Прокси - базовый класс, служит для работы с данными - хранение/получение произвольных данных,
     * работа с http дата сервисами, работа с потоками и т.п.
     *
     * В случае работы с http ds мы используем async модель работы с данными.
     * Вызываем метод для отправки запроса, прокси получает ответ и шлет соотвественное событие с данными ответа.
     *
	 */
	public class Proxy extends Notifier implements IProxy
	{

		public static var NAME:String = 'com.timoff.mvc.core.Proxy';
		
		/**
		 * Constructor
         *
         * В конструкторе прокси мы передаем ссылку на фасад, имя прокси - иначе используется имя по умолчанию,
         * объект с данными.
         *
		 */
		public function Proxy(facade:IFacade, proxyName:String=null, data:Object=null ) 
		{
			if (data != null) setData(data);
			super(facade,proxyName?proxyName:NAME);
		}

		/**
		 * Set the data object
         *
         * Установка данных
		 */
		public function setData( data:Object ):void 
		{
			this.data = data;
		}
		
		/**
		 * Get the data object
         *
         * Получение данных
		 */
		public function getData():Object 
		{
			return data;
		}		

		/**
		 * To override, called by the Model when the Proxy is registered
         *
         * Для переопределения, произвольный код, вызывается моделью при создании и регистрации прокси
		 */ 
		public function registerHandler():void {}

		/**
		 * To override, called by the Model when the Proxy is removed
         *
         * Для переопределения, произвольный код, вызывается моделью при удалении прокси
		 */ 
		public function removeHandler():void {}

		// the data object
		protected var data:Object;

    }
}