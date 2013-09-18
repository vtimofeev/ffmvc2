/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.event {

import com.timoff.mvc.data.EventCaller;
import com.timoff.mvc.interfaces.ICommand;
import com.timoff.mvc.interfaces.IFacadeEvent;
import com.timoff.mvc.interfaces.IFacade;
import com.timoff.mvc.interfaces.IMediator;
import com.timoff.mvc.interfaces.IProxy;

import flash.display.DisplayObject;
import flash.display.Stage;
import flash.events.Event;

/**
 * FacadeEvent, common event's passed by Notifier to Observer.
 * Contains link to facade, link to a parent event, data object.
 * Has methods to provide passing an event to external facades.
 *
 * FacadeEvent, событие фасада, универсальное событие передающееся от Notifier-Observer.
 * Содержит ссылку на фасад в котором оно произошло.
 * Ссылку на родительское событие, если оно присутсвует.
 * Универсальный объект данных data.
 * Так же методы для передачи во внешние фасады, имена фасадов которым будет рассылаться событие.
 */
public class FacadeEvent extends Event implements IFacadeEvent {

    public var facade:IFacade;
    public var facadeTarget:Object;

    private var _data:Object;
    private var _parentEvent:Event;

    private var _external:Boolean = false;
    private var _internal:Boolean = true;
    private var _desitinationFacadesNames:Array;


    public function FacadeEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = true, data:Object = null) {
        super(type, bubbles, cancelable);
        this.data = data;
    }

    /**
     * Set an data object
     */
    public function get data():Object {
        return _data;
    }

    public function set data(value:Object):void {
        _data = value;
    }

    /**
     * Get link to a gived birth event
     */
    public function get parentEvent():Event {
        return _parentEvent;
    }

    /**
     * Set link to a gived birth event
     */
    public function set parentEvent(value:Event):void {
        _parentEvent = value;
    }

    /////////////////////////////////////////////////////
    // External Data
    /////////////////////////////////////////////////////

    /**
     * Sets an event as an external event, sets passing to internal facade, sets destination facades names.
     *
     * Установка параметров передачи события во внешние фасады, передавать ли событие во внутренний фасад.
     * Параметр destinationFacadesNames - массив или одно имя ( Array/String ) внешних фасадов, которые должны получать это событие.
     *
     * @param external
     * @param internal
     * @param destinationFacadeNames
     */
    public function setExternal(external:String, internal:Boolean = true, destinationFacadeNames:Object = null):void {
        _external = external ? true : false;
        _internal = internal;

        if (destinationFacadeNames is Array) {
            _desitinationFacadesNames = destinationFacadeNames as Array;
        }
        else {
            _desitinationFacadesNames = [destinationFacadeNames];
        }
    }

    /**
     * External facades names
     *
     * Имена внешних фасадов
     */
    public function get destinationFacadesNames():Array {
        return _desitinationFacadesNames;
    }

    /**
     * Get external flag
     */
    public function get isExternal():Boolean {
        return _external;
    }

    /**
     * Get internal flag
     */
    public function get isInternal():Boolean {
        return _internal;
    }
    

    /////////////////////////////////////////////////////
    // Caller
    /////////////////////////////////////////////////////

    /**
     * Get caller type
     *
     * Получение типа продюсера событий MODEL/MEDIATOR/VIEW/STAGE/CONTROLLER/NONE(UNKNOW)
     */
    public function get caller():int {
        return FacadeEvent.getCaller(this);
    }

    /////////////////////////////////////////////////////
    // Static
    /////////////////////////////////////////////////////

    private static function getCaller(event:FacadeEvent):int {
        var target:Object = event.target?event.target:event.facadeTarget;

        if (target is IProxy || target is IFacade) {
            return EventCaller.CALLER_MODEL;
        }

        if (target is IMediator) {
            return EventCaller.CALLER_MEDIATOR;
        }

        if (target is DisplayObject) {
            return EventCaller.CALLER_VIEW;
        }

        if (target is Stage) {
            return EventCaller.CALLER_STAGE;
        }

        if (target is ICommand) {
            return EventCaller.CALLER_CONTROLLER;
        }

        return EventCaller.CALLER_NONE;
    }

}
}