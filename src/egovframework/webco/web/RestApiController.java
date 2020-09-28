package egovframework.webco.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.com.cmm.EgovMessageSource;
import egovframework.webco.service.UserService;
import egovframework.webco.service.WebcoService;
import egovframework.webco.vo.SyrupRequestVO;
import egovframework.webco.vo.SyrupResponseVO;

@Controller
public class RestApiController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    //@Resource(name = "restApiService")
    //private RestApiService restApiService;    
    
    @Resource(name="egovMessageSource")
    EgovMessageSource egovMessageSource;
    
    @Resource(name = "userService")
    private UserService userService;   
    
    @Resource(name = "webcoService")
    private WebcoService webcoService; 
    
    /**
     * 시럽연동 API
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="syrup/issueMembership.do", method = RequestMethod.POST)
    public @ResponseBody SyrupResponseVO issueMembership(@RequestBody SyrupRequestVO syrupRequestVO, HttpServletRequest request) throws Exception {
    	SyrupResponseVO syrupResponseVO = new SyrupResponseVO();
    	log.info("[REST API] issueMembership start");
    	log.info(syrupRequestVO.toString());
    	
    	syrupResponseVO.setTrNo(syrupRequestVO.getTrNo());
    	syrupResponseVO.setTrDt(syrupRequestVO.getTrDt());
    	
    	try {	    	
	    	String rCode = "0000";
	    	String rMsg = "";
	    	int user_index = 0;
	    	String issueType = "0";
	    	String user_num = "";
	    	String host = request.getScheme()+"://"+request.getServerName();
	    	if(request.getServerPort() != 80) {
	    		host += ":"+request.getServerPort();
	    	}
	    	String callBackUrl = "";
	    	
	    	user_index = userService.checkUserCI(syrupRequestVO.getIpinCi());
	        
	    	if(user_index > 0) {
	    		Map<String, Object> userInfo = userService.selectUserInfo(user_index);
	    		if(userInfo.get("user_recognize_type").equals("2")) {
	    			issueType = "5";
	    			rCode = "2420";	    			
	    		} else {
	    			issueType = "1";
	    		}
	    		user_num = userInfo.get("user_num").toString();
	    		callBackUrl = host+""+request.getContextPath()+"/pledge/checkCardUser.do?paymentTrNo="+syrupRequestVO.getPaymentTrNo();
	    	} else {
	    		issueType = "2";
	    		callBackUrl = host+""+request.getContextPath()+"/pledge/joinCardUser.do?paymentTrNo="+syrupRequestVO.getPaymentTrNo();
	    	}	    	
	    	
	    	rMsg = egovMessageSource.getMessage("SYRUP.ERROR."+rCode);
	    	
	    	syrupResponseVO.setCallBackUrl(callBackUrl);
	    	syrupResponseVO.setIssueType(issueType);
	    	syrupResponseVO.setCardNo(user_num);
	    	syrupResponseVO.setrCode(rCode);
	    	syrupResponseVO.setrMsg(rMsg);
	    	
	    	syrupRequestVO.setIssueType(issueType);
	    	syrupRequestVO.setUser_index(user_index);
	    	syrupRequestVO.setCardNo(user_num);
	    	syrupRequestVO.setrCode(rCode);
	    	syrupRequestVO.setrMsg(rMsg);
	    	
	    	int issue_membership_index = Integer.parseInt(webcoService.insert("IssueMembershipDAO.insert", syrupRequestVO).toString());	    	
	    	if(issue_membership_index <= 0 ) {
	    		syrupResponseVO.setrCode("9901");
	    		syrupResponseVO.setrMsg(egovMessageSource.getMessage("SYRUP.ERROR.9901"));
	    	}
    	} catch (Exception e) {
    		log.error(e.toString());
    		syrupResponseVO.setrCode("9901");
    		syrupResponseVO.setrMsg(egovMessageSource.getMessage("SYRUP.ERROR.9901"));
    	}
    	log.info("[REST API] issueMembership end");
    	return syrupResponseVO;
    }	
}

        