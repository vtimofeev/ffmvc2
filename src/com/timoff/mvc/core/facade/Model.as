/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
 */
package com.timoff.mvc.core.facade {
import flash.utils.Dictionary;

import com.timoff.mvc.interfaces.*;

/**
 *
 * Модель, мультитон, менеджер для объектов бизнес логики ( Proxy ),
 * модель регистрирует новые объекты, отдает ссылки по их имени,
 * удаляет объекты.
 *
 * У каждого фасада своя модель ( набор объектов бизнес логики).
 *
 * Чтоже может быть объектом модели:
 * любые RPC, любые хранилища данных, любые стримовые объекты.
 *
 * Регистрировать прокси нужно в мет initModel или внутри комманд.
 *
 */
public class Model implements IModel {
    /**
     * Constructor.
     *
     * @throws Error Error if Singleton instance has already been constructed
     *
     */
    // Mapping of proxyNames to IProxy instances
    protected var proxyMap:Array;

    // Multiton instances
    protected static var instances:Dictionary = new Dictionary();

    protected var facade:IFacade;

    // Message Constants
    protected const SINGLETON_MSG:String = "Model Singleton already constructed!";

    public function Model(facade:IFacade) {
        proxyMap = new Array();
        this.facade = facade;
        instances[facade] = this;

    }

    // must be override
    public function initializeModel():void {
        throw new Error("Facade method initializeModel() must be overrided");
    }

    public function registerProxy(proxy:IProxy):void {
        proxyMap[ proxy.name ] = proxy;
        proxy.registerHandler();
    }

    public function retrieveProxy(proxyName:String):IProxy {
        return proxyMap[ proxyName ];
    }

    public function hasProxy(proxyName:String):Boolean {
        return (proxyMap[ proxyName ] != null);
    }

    public function removeProxy(proxyName:String):IProxy {
        var proxy:IProxy = proxyMap [ proxyName ] as IProxy;
        if (proxy) {
            proxyMap[ proxyName ] = null;
            proxy.removeHandler();
        }
        return proxy;
    }

    //-------------------------------------------------------------------------
    // Static methods
    //-------------------------------------------------------------------------

    /**
     * <code>Model</code> Multiton Factory method.
     *
     * @return the Multiton by Facade instance
     */
    public static function getInstance(facade:IFacade):IModel {
        if (instances[facade] == null) instances[facade] = new Model(facade);
        return instances[facade];
    }


}
}