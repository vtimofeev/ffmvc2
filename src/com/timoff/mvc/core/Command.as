/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
 */
package com.timoff.mvc.core {
import com.timoff.mvc.event.FacadeEvent;
import com.timoff.mvc.interfaces.*;

import flash.utils.getQualifiedClassName;

/**
 * A base <code>ICommand</code> implementation.
 *
 * <P>
 * Your subclass should override the <code>execute</code>
 * method where your business logic.</P>
 *
 * Содержит код комманды, который пишется в методе execute,
 * необходимый для переопределения.
 *
 *
 */
public class Command implements ICommand {
    private var _facade:IFacade;
    protected var _logger:LocalLogger;

    public function Command() {
    }

    public function execute(event:FacadeEvent):void {
        // must be overrided
    }

    /**
     * Dispatches an event to facade dispatcher.
     *
     * Отправляет событие в фасад
     *
     * @param event
     */
    public function dispatchEvent(event:FacadeEvent):void {
        if (facade) facade.dispatchFacadeEvent(event);
    }

    /**
     * Sets link to facade, IFacade
     *
     * Устанавливает ссылку на фасад
     *
     * @param value
     */
    public function set facade(value:IFacade):void {
        _facade = value;
        _logger = new LocalLogger(_facade, getQualifiedClassName(this));
    }

    /**
     * Gets link to facade, IFacade
     *
     * Устанавливает ссылку на фасал
     *
     */
    public function get facade():IFacade {
        return _facade;
    }

    public function get logger():ILogTarget {
        return _logger;
    }
}
}