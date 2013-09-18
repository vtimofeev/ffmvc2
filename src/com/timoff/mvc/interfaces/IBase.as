/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.interfaces {
public interface IBase {
    function get name():String;
    function get facade():IFacade;
    function get logger():ILogTarget;
}
}
