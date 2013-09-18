/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.core {
import com.timoff.mvc.event.FacadeEvent;
import com.timoff.mvc.interfaces.IBase;
import com.timoff.mvc.interfaces.IFacade;
import com.timoff.mvc.interfaces.ILogTarget;

/**
 * Базовый компонент для классов Mediator, Notifier, Proxy
 */
public class Base implements IBase {

    protected var _facade:IFacade;
    protected var _name:String;
    protected var _logger:ILogTarget;

    public function Base() {
    }

    /**
     * Get name of a component.
     *
     * Получить имя компонента.
     */
    public function get name():String {
        return this._name;
    }

    /**
     * Get facade link, IFacade
     *
     * Ссылка на фасад, IFacade
     */
    public function get facade():IFacade {
        return _facade;
    }

    /**
     * Sends an <code>event</code> to facade dispatcher.
     *
     * Отправляет событие обработчику фасада, далее eventManager обрабатывает,
     * и отправляет событие обработчикам медиаторов и комманд.
     *
     * @param event FacadeEvent
     */
    public function dispatchEvent(event:FacadeEvent):void {
        event.facadeTarget = this;
        facade.dispatchFacadeEvent(event);
    }

    /**
     * Creates facadeEvent by name and sends to facade dispatcher.
     *
     * Создает событие фасада по имени, указанном в параметре и отправляет обработчику фасада.
     *
     * @param eventName
     */
    public function dispatchSimpleEvent(eventName:String):void {
        var event:FacadeEvent = new FacadeEvent(eventName);
        event.facadeTarget = this;
        facade.dispatchFacadeEvent(event);
    }


    public function get logger():ILogTarget {
        return _logger;
    }
}
}
