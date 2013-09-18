/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
 */
package com.timoff.mvc.core.facade {
import com.timoff.mvc.interfaces.IFacade;
import com.timoff.mvc.interfaces.IController;


import flash.utils.Dictionary;

/**
 * <p>
 * <b>Controller</b> is a command manager. It registers, removes and checks commands existing at system.
 * <br/>
 * <br/>
 * Контроллер - это менеджер комманд, он регистрирует, удаляет, и проверяеи существование комманды.
 * </p>
 *
 */
public class Controller implements IController {
    protected const SINGLETON_MSG:String = "Controller Singleton already constructed!";

    protected static var instances:Dictionary = new Dictionary();
    protected var facade:IFacade;

    public function Controller(facade:IFacade) {
        this.facade = facade;
        instances[facade] = this;
    }

    // we'll register  events-commands map here
    // must  be override
    public function initializeController():void {
    }

    public function registerCommand(type:String, value:Class):void {
        facade.getEventManager().registerCommand(type, value);
    }

    public function hasCommand(value:Class):Boolean {
        return facade.getEventManager().hasCommand(value);
    }

    public function removeCommand(value:Class):void {
        facade.getEventManager().removeCommand(value);
        return;
    }

    //-------------------------------------------------------------------------
    // Static methods
    //-------------------------------------------------------------------------

    /**
     * <code>Controller</code> Multiton Factory method.
     * @return the Multiton by Facade instance
     */
    public static function getInstance(facade:IFacade):IController {
        if (instances[facade] == null) instances[facade] = new Controller(facade);
        return instances[facade];
    }

}
}
