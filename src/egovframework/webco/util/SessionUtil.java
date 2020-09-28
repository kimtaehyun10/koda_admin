/**
 *
 */
package egovframework.webco.util;

import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;

import egovframework.webco.vo.AdminVO;

/**
 * @Class Name  : SessionUtil.java
 * @Description : SessionUtil Class
 * @Modification Information
 *
*   수정일      수정자    수정내용 
 * ----------  -------- ---------------------------
 * 2019.04.08    novam    최초 생성
 * 
 * @author webco
 * @since 2019.04.08
 * @version 1.0
 * @see
 */
public class SessionUtil {

    /**
     * session 값 전달
     *
     * @return
     *
     */
	
    public static boolean isLoginChk() {
        String adminId   = getAdminId();
        
        if (adminId != null && !adminId.equals("")){
            return true;
        } else {
            return false;
        }
    }
    
    public static String getAdminId() {
        try{
            return ((AdminVO)SessionUtil.getAuthenticatedUser()).getAdmin_id();
        } catch(NullPointerException e){
            return "";
        }
    }   
    
    public static String getAdminNickName() {
        try{
            return ((AdminVO)SessionUtil.getAuthenticatedUser()).getAdmin_nick_name();
        } catch(NullPointerException e){
            return "";
        }
    }  
    
    public static String getAdminGrade() {
        try{
            return ((AdminVO)SessionUtil.getAuthenticatedUser()).getAdmin_grade();
        } catch(NullPointerException e){
            return "";
        }
    }  
    
    public static AdminVO getAuthenticatedUser() {
    	return (AdminVO) RequestContextHolder.getRequestAttributes().getAttribute("adminVO", RequestAttributes.SCOPE_SESSION);
    }
    
    public static Boolean isAuthenticated() {
    	if (RequestContextHolder.getRequestAttributes() == null) {
    		return false;
    	} else {
    		if (RequestContextHolder.getRequestAttributes().getAttribute("adminVO", RequestAttributes.SCOPE_SESSION) == null) {
    			return false;
    		} else {
    			return true;
    		}
    	}
    }
}
