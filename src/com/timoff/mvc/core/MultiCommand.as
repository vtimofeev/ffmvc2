/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.core {
import com.timoff.mvc.event.FacadeEvent;
import com.timoff.mvc.interfaces.ICommand;
import com.timoff.mvc.interfaces.IMultiCommand;

/**
 * MultiCommand, command contains code to execute some simple commands.
 * To add new command, please, add to constructor of your multicommand addSubCommand methods.
 *
 * Мультикомманда - это набор простых комманд, которые выполняются одновременно и последовательно,
 * согласно добавлению в контсрукторе.
 */
public class MultiCommand extends Command implements IMultiCommand {

    private var commands:Vector.<ICommand>;

    public function MultiCommand() {
        commands = new Vector.<ICommand>();
        // addSubCommand(new Command()); - add first subcommand
        // addSubCommand(new Command()); - add second subcommand
        // addSubCommand(new Command()); - ...
    }

    /**
     * Adds simple command to command list.
     *
     * Добавляет простую комманду к листу комманд.
     *
     * @param value
     */
    public function addSubCommand(value:ICommand):void {
        commands.push(value);
    }

    /**
     *
     *
     * @param event
     */
    override public function execute(event:FacadeEvent):void {
        for each(var command:ICommand in commands) {
            command.facade = facade;
            command.execute(event);
        }
    }
}
}
