/**
 * Author: Vasily
 * Web: http://timoff.com
 * Date: 25.05.11
 * Time: 11:56
 */
package com.timoff.mvc.core.facade {
import com.timoff.mvc.event.EventManager;
import com.timoff.mvc.event.FacadeEvent;
import com.timoff.mvc.interfaces.IController;
import com.timoff.mvc.interfaces.IFacade;
import com.timoff.mvc.interfaces.ILogger;

import com.timoff.mvc.interfaces.IMediator;
import com.timoff.mvc.interfaces.IModel;

import com.timoff.mvc.interfaces.IProxy;
import com.timoff.mvc.interfaces.IView;

import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
/*

SpriteFacade - реализация фасада через наследование спрайт.
Есть случаи когда удобнее реализовывать фасад через наследование спрайта, в противовес композиции.
Но не забывайте про метоод initializeFacade, где можно переопределить ссылку на
базовый контейнер вью.

 */

public class SpriteFacade extends Sprite implements IFacade {

    public static const NAME:String = "com.timoff.mvc.core.facade.SpriteFacade";

    protected var model:IModel;
    protected var view:IView;
    protected var controllers:Vector.<IController> = new Vector.<IController>();
    protected var _name:String = NAME;

    private var _viewReference:DisplayObjectContainer;
    protected var _eventManager:EventManager;

    public function SpriteFacade() {
        Facade.setInstance(_name = (name)?name:NAME, this );
        this.viewReference = this;
        //initializeFacade();
    }

    protected function initializeFacade(updatedViewReference:DisplayObjectContainer = null):void {
        if(updatedViewReference) viewReference = updatedViewReference;

    }

    protected function initializeEventManager():void
    {
        _eventManager = EventManager.getInstance(this);
        _eventManager.facade = this;
    }

    //------------------------------------
    //
    //------------------------------------
    /**
     * Must be overrided in implementation of facade
     */

    protected function initializeModel():void {

        throw new Error("Facade method initializeModel() must be overrided" );
    }

    protected function initializeController():void {
        throw new Error("Facade method initializeController() must be overrided" );
    }

    protected function initializeView():void {
        throw new Error("Facade method initializeView() must be overrided" );
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

        if (event.isInternal)
        {
            _eventManager.executeEvent(event);
        }
        if (event.isExternal)
        {
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

    override public function get name():String {
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
        for each (var object:IProxy in model.retrieveProxy(name)) {
            if (object.name == name)
                return object;
        }
        return null;
    }

    public function initFacade(updatedViewReference:DisplayObjectContainer = null):void {
        if (updatedViewReference) viewReference = updatedViewReference;
        initializeEventManager();
        initializeModel();
        initializeController();
        initializeView();
    }

    public function getLogger():ILogger {
        throw new Error("Facade method 'getLogger' must be overrided in childs.");
        return null;
    }
}
}
