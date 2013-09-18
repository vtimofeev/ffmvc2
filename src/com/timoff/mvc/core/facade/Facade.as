/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
 */
package com.timoff.mvc.core.facade {
import com.timoff.mvc.core.*;

import com.timoff.mvc.interfaces.IFacade;

import flash.display.DisplayObjectContainer;
import flash.utils.Dictionary;

import com.timoff.mvc.event.FacadeEvent;
import com.timoff.mvc.event.EventManager;
import com.timoff.mvc.interfaces.*;

/*

Facade - мультитон, основной компонент системы, содержащий ссылки на все остальные члены MVC.
Основная задача фасада отправлять события во внутренний EventManager, получать события возможно от внешних фасадов или от внутренних индукторов (INotifier, IProxy, IMediator).
Также, через фасад мы можем получить ссылку на экземпляры медиаторов, прокси, менеджер событий.

Основные методы:

конструктор( имя, ссылка на view);
initFacade(ссылка на view, который будет родителем для элементов приложения).

Методы необходимые к переопределению:
initModel();
initController();
initView();

*/
public class Facade implements IFacade {
    public static const NAME:String = "com.timoff.mvc.core.facade.Facade"

    protected static var facades:Dictionary = new Dictionary();

    protected var model:IModel;
    protected var view:IView;
    protected var controllers:Vector.<IController> = new Vector.<IController>();

    protected var _name:String = NAME;

    private var _viewReference:DisplayObjectContainer;
    protected var _eventManager:EventManager;

    public function Facade(name:String = null, viewInstance:DisplayObjectContainer = null) {
        facades[_name = (name) ? name : NAME] = this;
        this.viewReference = viewInstance;
    }

    public function initFacade(updatedViewReference:DisplayObjectContainer = null):void {
        if (updatedViewReference) viewReference = updatedViewReference;
        initEventManager();
        initModel();
        initController();
        initView();
    }

    protected function initEventManager():void {
        _eventManager = EventManager.getInstance(this);
        _eventManager.facade = this;
    }

    //------------------------------------
    //
    //------------------------------------
    /**
     * Must be overrided in implementation of facade
     */

    protected function initModel():void {

        throw new Error("Facade method initializeModel() must be overrided");
        // model = Model.getInstance(this);
    }

    protected function initController():void {
        throw new Error("Facade method initializeController() must be overrided");
        //controllers.push(Controller.getInstance(this));
    }

    protected function initView():void {
        throw new Error("Facade method initializeView() must be overrided");
        // view = View.getInstance(this);
    }

    //------------------------------------
    // Event controllers
    //------------------------------------

    public function getEventManager():EventManager {
        return _eventManager;
    }

    public function dispatchExternalEvent(event:FacadeEvent):void {
        if (!event.facade) event.facade = this;
        _eventManager.executeEvent(event);
        return;
    }


    public function dispatchFacadeEvent(event:FacadeEvent):void {
        event.facade = event.facade ? event.facade : this;

        if (event.isInternal) {
            _eventManager.executeEvent(event);
        }
        if (event.isExternal) {
            for each (var name:String in event.destinationFacadesNames) {
                var facade:IFacade = Facade.getInstance(name);
                if (facade) {
                    if (facade != this) facade.dispatchExternalEvent(event);
                }
                else {
                    // todo throw warning - facade not found
                }
            }
        }
        return;
    }

    //---------------------------------------
    // method to work with incapsulated properties
    //---------------------------------------

    public function set viewReference(value:DisplayObjectContainer):void {
        _viewReference = value;
    }

    public function get viewReference():DisplayObjectContainer {
        return _viewReference;
    }

    public function get name():String {
        return _name;
    }

    public function getModel():IModel {
        return model;
    }

    public function getView():IView {
        return view;
    }

    public function getControllers():Vector.<IController> {
        return controllers;
    }

    public function getMediator(name:String):IMediator {
        return view.retrieveMediator(name);
    }

    public function getProxy(name:String):IProxy {
        return model.retrieveProxy(name);
    }

    public function getLogger():ILogger {
        throw new Error("Facade method 'getLogger' must be overrided in childs.");
        return null;
    }

    //----------------------------------------------------------------
    // Static methods
    //----------------------------------------------------------------

    public static function getInstance(name:String):IFacade {
        for (var currentName:String in facades) {
            if (currentName == name)
                return facades[name] as IFacade;
        }
        return null;
    }

    public static function setInstance(name:String, facade:IFacade):void {
        if (facades[name]) throw new Error("Cant set facade with " + name + ". Facade already exists.");
        facades[name] = facade;
    }

}
}

