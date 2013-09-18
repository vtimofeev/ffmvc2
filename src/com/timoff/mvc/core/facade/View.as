/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.core.facade {
import com.timoff.mvc.interfaces.IFacade;
import com.timoff.mvc.interfaces.IMediator;
import com.timoff.mvc.interfaces.INotifier;
import com.timoff.mvc.interfaces.IObserver;

import com.timoff.mvc.interfaces.IView;

import flash.utils.Dictionary;

public class View implements IView {
    protected const SINGLETON_MSG:String = "View Singleton already constructed!";
    protected static var instances:Dictionary = new Dictionary();
    protected var objectMap:Dictionary = new Dictionary();
    protected var facade:IFacade;

    public function View(facade:IFacade) {
        this.facade = facade;
        instances[facade] = this;
    }

    // must  be override
    public function initializeView():void {
    }

    public function registerMediator(value:IMediator):void {
        facade.getEventManager().registerObserver(value);
        var name:String = INotifier(value).name;

        objectMap[name] = value;
        value.registerHandler();
    }

    public function hasMediator(value:String):Boolean {
        return !(objectMap[value] == null);
    }

    public function retrieveMediator(value:String):IMediator {
        return objectMap[value];
    }

    public function removeMediator(value:String):IMediator {

        var mediator:IMediator = retrieveMediator(value);
        if (mediator) {
            facade.getEventManager().removeObserver(mediator);
            objectMap[value] = null;
            mediator.removeHandler();
        }
        return mediator;
    }

    //-------------------------------------------------------------------------
    // Static methods
    //-------------------------------------------------------------------------

    /**
     * <code>View</code> Multiton Factory method.
     * @return the Multiton by Facade instance
     */
    public static function getInstance(facade:IFacade):IView {
        if (instances[facade] == null) instances[facade] = new View(facade);
        return instances[facade];
    }

}
}
