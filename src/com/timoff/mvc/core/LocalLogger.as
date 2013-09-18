/**
 * Author: Vasily Timofeev
 * Web: http://timoff.com
 */
package com.timoff.mvc.core {
import com.timoff.mvc.interfaces.IFacade;
import com.timoff.mvc.interfaces.ILogTarget;

public class LocalLogger implements ILogTarget {
    private var facade:IFacade;
    private var name:String;

    public function LocalLogger(facade:IFacade, name:String) {
        this.facade = facade;
        this.name = name;
    }

    public function get isDebug():Boolean {
        return facade.getLogger().isDebug;
    }

    public function get isInfo():Boolean {
        return facade.getLogger().isInfo;
    }

    public function get isError():Boolean {
        return facade.getLogger().isError;
    }

    public function debug(value:String):void {
        facade.getLogger().debug(value, name);
    }

    public function info(value:String):void {
        facade.getLogger().info(value, name);
    }

    public function error(value:String):void {
        facade.getLogger().error(value, name);
    }

    public function fatal(value:String):void {
        facade.getLogger().fatal(value, name);
    }
}
}
