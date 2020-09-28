package egovframework.com.utl.slm;

import javax.servlet.http.HttpSessionBindingEvent;
import javax.servlet.http.HttpSessionBindingListener;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
 
public class EgovHttpSessionBindingListener implements HttpSessionBindingListener{
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
    @Override
    public void valueBound(HttpSessionBindingEvent event){
        if (EgovMultiLoginPreventor.findByLoginId(event.getName())){
            EgovMultiLoginPreventor.invalidateByLoginId(event.getName());
        }
        EgovMultiLoginPreventor.loginUsers.put(event.getName(), event.getSession());
        log.info(event.getName()+"님이 로그인 하셨습니다.");
        log.info("현재 접속자 수 : "+EgovMultiLoginPreventor.loginUsers.size());
    }
 
    @Override
    public void valueUnbound(HttpSessionBindingEvent event) {
        EgovMultiLoginPreventor.loginUsers.remove(event.getName(), event.getSession());
        log.info(event.getName()+"님이 로그아웃 하셨습니다.");
        log.info("현재 접속자 수 : "+EgovMultiLoginPreventor.loginUsers.size());
    }
}

