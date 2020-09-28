package egovframework.webco.vo;

import java.io.Serializable;

/**
 * @Class Name : CommonVO.java
 * @Description : CommonVO Class
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
 * 
 */

public class CommonVO extends JQueryGridVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/** 메시지 코드 */
	private String msg_code = ""; 
	
	/** 메시지 코드 */
	private String msg = ""; // 메시지
		
    
    public String getMsg_code() {
        return msg_code;
    }
    public void setMsg_code(String msg_code) {
        this.msg_code = msg_code;
    }
    public String getMsg() {
        return msg;
    }
    public void setMsg(String msg) {
        this.msg = msg;
    }	
}
