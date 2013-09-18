/**
 * Author: Vasily Timofeev
 * web: http://timoff.com/projects/ffmvc2/
*/
package com.timoff.mvc.core {
import com.timoff.mvc.event.FacadeEvent;
import com.timoff.mvc.interfaces.*;

/**
 * <P>
 * The <code>INotifier</code> interface provides a common method called
 * <code>dispatchEvent</code> that relieves implementation code of
 * the necessity to actually construct <code>Event</code>.
 * It's extended Mediator and Proxy classes.
 * Registers a newly created component in a system.</P>
 *
 * Базовый класс, наследующийся объектами которые могут рассылать события в фасад.
 * Происзводные - медиатором и прокси.
 * Содержит ссылку на фасад, имеет имя, расширяет Base класс,
 * Регистрирует созданный компонент в системе.
 *
 *
 */
public class Notifier extends Base implements INotifier {
    public function Notifier(facade:IFacade, name:String = '') {
        this._facade = facade;
        this._name = name;
        this._logger = new LocalLogger(_facade, _name);

        if ((this is ICommand)) return;

        if (this is IProxy) {
            facade.getModel().registerProxy(this as IProxy);
            return;
        }
        else
        if (this is IMediator) {
            facade.getView().registerMediator(this as IMediator);
            return;
        }
        else
        if (this is IObserver) {
            facade.getEventManager().registerObserver(this as IObserver);
            return;
        }
        return;
    }
}
}