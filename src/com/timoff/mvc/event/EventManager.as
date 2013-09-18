/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.event {
import com.timoff.mvc.core.Base;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import flash.utils.Dictionary;

import com.timoff.mvc.interfaces.ICommand;
import com.timoff.mvc.interfaces.IFacade;
import com.timoff.mvc.interfaces.IObserver;

/**
 * EventManager receives events from notifiers ( mediators, proxies )
 * correlates them to event interests receivers ( mediators, commands )
 * executes commands.
 * Also it manages observers (mediators, implements IObserver) and commands with
 * hasObserver, hasCommand, removeObserver, removeCommand, registerObserver, registerCommand methods.
 *
 *
 * Обработчик событий, принимает события от отправителей ( медиаторов, прокси )
 * соотносит их с интересами получателей ( медиаторов, комманд ),
 * запускает комманды.
 * В дополнении к этому осуществляет простейший менеджмент,
 * содержа методы hasObserver, hasCommand, removeObserver, removeCommand, registerOvserver, registerCommand.
 */
public class EventManager extends EventDispatcher {
    private static var _instances:Dictionary = new Dictionary();

    private var _observers:Vector.<IObserver> = new Vector.<IObserver>();
    private var _observerRelations:Object = {};
    private var _commandsRelations:Dictionary = new Dictionary();
    private var _facade:IFacade;

    public function EventManager(target:IEventDispatcher = null) {
        super(target);
    }

    public function set facade(value:IFacade):void {
        _facade = value;
    }

    public function get facade():IFacade {
        return _facade;
    }

    /**
     * Handles facade event that happens in this system ( in Mediator/Proxy or Command)
     *
     * Обработка события возникшего в какой либо части системы ( медиатор или прокси или комманда )
     *
     * @param event
     */
    public function executeEvent(event:FacadeEvent):void {
        var type:String = event.type;

        if (!_commandsRelations[type])
            _commandsRelations[type] = [];

        if (!_observerRelations[type])
            _observerRelations[type] = [];

        // execute commands related with event
        if (_commandsRelations[type]) {
            for each (var Command:Class in _commandsRelations[type]) {
                var instance:ICommand = new Command();
                instance.facade = facade;
                instance.execute(event);
            }
        }

        // execute observers related with event
        for each (var observer:IObserver in _observerRelations[type]) {
            observer.handleEvent(event);
        }

        // send event to global dispatcher
        dispatchEvent(event);
    }

    /**
     * Register command, internal maintaining method
     *
     * Регистрация комманды, связанной с событием type
     *
     * @param type
     * @param object
     * @return
     */
    public function registerCommand(type:String, object:Class):Boolean {
        if (!_commandsRelations[type]) {
            _commandsRelations[type] = [];
        }
        _commandsRelations[type].push(object);
        return true;
    }


    /**
     * Remove command method
     *
     * Удаление комманды из системы
     *
     * @param object
     * @return
     */
    public function removeCommand(object:Class):Boolean {
        var length:int;
        var commands:Array;
        var i:int;

        for each (commands in _commandsRelations) {
            length = commands.length;
            for (i = 0; i < length; i++)
                if (commands[i] == object) {
                    commands = commands.splice(i, 1);
                    return true;
                }
        }
        return false;
    }

    /**
     * Checks command existing.
     *
     * Проверка наличия комманды в системе
     *
     * @param object
     * @return
     */
    public function hasCommand(object:Class):Boolean {
        var length:int;
        var commands:Array;
        var i:int;

        for each (commands in _commandsRelations) {
            length = commands.length;
            for (i = 0; i < length; i++)
                if (commands[i] == object) {
                    return true;
                }
        }
        return false;
    }


    /**
     * Registers IObserver.
     * Observers may be Mediators and Proxies(Models) or something which implements IObserver.
     *
     * Регистрация обозревателя.
     *
     * @param object
     * @return
     *
     */
    public function registerObserver(object:IObserver):Boolean {
        if (hasObserver(object))
            return false;
        //trace ("register observer " + (object as IMediator).name );

        for each (var event:String in object.eventInterests) {
            if (!_observerRelations[event]) {
                _observerRelations[event] = [];
            }
            _observerRelations[event].push(object);
        }

        _observers.push(object);
        return true;
    }

    /**
     * Remove Observer.
     *
     * Удаление обозревателя.
     *
     * @param object
     * @return
     */
    public function removeObserver(object:IObserver):Boolean {
        var observersLength:int = _observers.length;
        var i:int;
        var c:int;
        var relLength:int;
        var orelLenght:int = _observerRelations.length;

        var _relations:Array;

        // remove event relations
        for (c = 0; c < orelLenght; _relations = _observerRelations[c],c++) {
            relLength = _relations.length;
            for (i = 0; i < relLength; i++) {
                if (object == _relations[i]) {
                    _relations = _relations.splice(i, 1);
                    break;
                }
            }
        }

        // remove object
        for (i = 0; i < observersLength; i++) {
            if (object == _observers[i]) {
                _observers = _observers.splice(i, 1);
                return true;
            }
        }
        return false;
    }

    /**
     * Checks an observer existing.
     *
     * Проверка наличия
     *
     * @param object
     * @return
     */
    private function hasObserver(object:IObserver):Boolean {
        for each (var observer:IObserver in _observers)
            if (object == observer) return true;
        return false;
    }

    //--------------------------------------------
    // Static methods
    //--------------------------------------------

    public static function getInstance(facade:IFacade):EventManager {
        return _instances[facade] = (!_instances[facade]) ? new EventManager() : _instances[facade];
    }

}
}