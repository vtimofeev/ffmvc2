/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
 */
package com.timoff.mvc.core {
import com.timoff.mvc.data.EventCaller;
import com.timoff.mvc.event.FacadeEvent;
import com.timoff.mvc.interfaces.*;

import flash.display.DisplayObject;

/**
 * A base <code>IMediator</code> implementation.
 *
 * <P>
 * Typically, a <code>Mediator</code> will be written to serve
 * one specific control or group controls and so,
 * will not have a need to be dynamically named.</P>
 *
 * Основа имплементации IMediator.
 * Медиатор - компонент, необходимый для управления одним,
 * или несколькими визуальными компонентами (группами).
 *
 */
public class Mediator extends Notifier implements IMediator, INotifier {
    public static const NAME:String = 'com.timoff.mvc.core.Mediator';
    protected var _view:DisplayObject;

    /**
     * Constructor, we pass a link to facade, name of mediator component, link to view (DisplayObject),
     *
     * If view implements IMVCDisplayObject, it can dispatch facade events directly to facade.
     * Otherwise all view events should be redispatched by Mediator.
     *
     * В конструкторе медиатора мы передаем ссылку на фасад (ранняя инициализация свойства),
     * имя медиатора, иначе будет установлено имя по умолчанию, ссылку на визуальный компонент,
     * с которым медиатор будет работать.
     *
     * Если view реализует IMVCDisplayObject, то сможет отправлять сообщения напрямую
     * в Facade через notifier.dispatchEvent();
     *
     * @param facade
     * @param name
     * @param view
     */
    public function Mediator(facade:IFacade, name:String = null, view:DisplayObject = null) {
        super(facade, (name != null) ? name : NAME);
        registerHandler();

        this.view = view;

        initializeView();
        setViewNotifier();
        addListeners();
    }

    /*
     * If view implements IMVCDisplayObject, it can dispatch facade events directly to facade.
     * Otherwise all view events should be redispatched by Mediator.
     *
     * Если view реализует IMVCDisplayObject, то сможет отправлять сообщения напрямую
     * в Facade через notifier.dispatchEvent();*
     *
     */
    public function setViewNotifier():void {
        if (this.view is IMVCDisplayObjectView) {
            IMVCDisplayObjectView(this.view).notifier = this;
        }
    }

    //----------------------------------------
    // Initialize overrides
    //----------------------------------------

    /**
     * To override, code to setup view
     *
     * Для переопределения, код для настройки view
     */
    protected function initializeView():void {
    }

    /**
     * To override, code to add listeners to view
     *
     * Для переопределения, код для добавления слушателей
     */
    protected function addListeners():void {
    }

    //----------------------------------------
    // EventModel
    //----------------------------------------

    /**
     * To override, array of names events should be handled by mediator
     *
     * Для переопределения, массив имен событий, которые медиатор должен обрабатывать
     */
    public function get eventInterests():Array {
        return [];
    }

    /**
     * Handles events from facade
     *
     * Обработка событий от фасада
     *
     * @param event
     */
    public function handleEvent(event:FacadeEvent):void {
        switch (event.caller) {
            case EventCaller.CALLER_MODEL:
                handleModelEvent(event);
                break;
            case EventCaller.CALLER_CONTROLLER:
                handleControllerEvent(event);
                break;
            case EventCaller.CALLER_MEDIATOR:
            case EventCaller.CALLER_VIEW:
                handleViewEvent(event);
                break;
            case EventCaller.CALLER_STAGE:
                handleStageEvent(event);
                break;
        }
    }

    /**
     * To override, handles stage events
     *
     * Для переопределения, обработка stage событий
     *
     * @param event
     */
    protected function handleStageEvent(event:FacadeEvent):void {
    }

    /**
     * To override, handles controller events
     *
     * Для переопределения, обработка controller событий
     *
     * @param event
     */
    protected function handleControllerEvent(event:FacadeEvent):void {
    }

    /**
     * To override, handles view events
     *
     * Для переопределения, обработка view событий
     *
     * @param event
     */
    protected function handleViewEvent(event:FacadeEvent):void {
    }

    /**
     * To override, handles model events
     *
     * Для переопределения, обработка model событий
     *
     * @param event
     */
    protected function handleModelEvent(event:FacadeEvent):void {
    }

    /**
     * Redispatches view events to facade.
     *
     * Переотправка событий в фасад от view.
     *
     * @param event
     */
    protected function redispatchEvent(event:FacadeEvent):void {
        dispatchEvent(event);
    }

    //----------------------------------------
    // View methods
    //----------------------------------------

    /**
     * Set view component
     *
     * Установка вью компонента
     *
     * @param view
     */
    public function set view(view:DisplayObject):void {
        this._view = view;
    }

    /**
     * Get view component
     *
     * Получение вью компонента
     *
     * @param view
     */
    public function get view():DisplayObject {
        return _view;
    }

    //----------------------------------------
    // LifeCycle handlers
    //----------------------------------------

    /**
     * Code should be executed in registration phase.
     *
     * Код, который должен выполнятся при регистрации компонента
     */
    public function registerHandler():void {
    }

    /**
     * Code should be executed in remove phase.
     *
     * Код, который должен выполнятся при удалении компонента
     */
    public function removeHandler():void {
    }
}
}