package egovframework.webco.web;

import java.io.PrintWriter;
import java.security.PrivateKey;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import egovframework.webco.controller.bean.jqgridJason;
import egovframework.webco.service.WebcoService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.RSAEngine;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;
import net.sf.json.JSONObject;

/**
 * @Class Name : IntranetIndexController.java
 * @Description : IntranetIndexController Class
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

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;

@Controller
public class MessageSettingController {

    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

    @Resource(name = "webcoService")
    private WebcoService webcoService;                 
    
    /**
     * 자동 문자발송 설정 목록조회
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/messageSetting/showList.do")
    public String showList(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	EnumValue enumValue = new EnumValue();
    	
    	int limit = 6;    	
		int page = 1;
		
		if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("page")))) {
			page = Integer.parseInt(commandMap.get("page").toString());
		}
		
    	int offset = page > 0 ? (page-1) * limit : 0;
    			    	
    	commandMap.put("offset", offset);
    	commandMap.put("limit", limit);
    	
    	List<Map<String, Object>> message_setting_list = webcoService.list_map("MessageSettingDAO.selectList", commandMap);
    	int total_count = (Integer)webcoService.selectCount("MessageSettingDAO.selectCount", commandMap);
    	
    	for( Map<String, Object> message_setting : message_setting_list ) {
    		message_setting.put("sms_send_state", enumValue.getValue("sms_send_state", message_setting.get("sms_send_state").toString()));
    	}
    	
    	model.addAttribute("message_list", message_setting_list);
    	model.addAttribute("total_count", total_count);
    	    	
    	model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
    	
        return "/messageSetting/messageSettingList";
    }
    
    /**
     * 자동 문자발송 설정 신규등록 화면
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/messageSetting/showCreate.do")
    public String showCreate(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {       
    	
    	EnumValue enumValue = new EnumValue();
    	
    	model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
        return "/messageSetting/messageSettingDetail";
    }
    
    /**
     * 관리자 수정 화면
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/messageSetting/showDetail.do")
    public String showDetail(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
        
    	if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("message_setting_index")))) {
    		return "redirect:/messageSetting/showList.do";
    	}
    	Map<String, Object> message_setting_detail = webcoService.selectByPk("MessageSettingDAO.select", commandMap);    	
    	model.addAttribute("message_setting_detail", message_setting_detail);
    	
    	EnumValue enumValue = new EnumValue();    	
    	model.addAttribute("enum_array", CommonUtil.getObjectToJSONObject(enumValue.getEnumArray()));
    	return "/messageSetting/messageSettingDetail";
    }      
    
    /**
     * 관리자 등록
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/messageSetting/create.do")
    public void create(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	// admin_id, admin_pwd, admin_nick_name, admin_grade, 
    	
    	String msg = "";
    	String return_url = "";
    	response.setContentType("text/html; charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	
    	commandMap.put("arrange_priority", EgovStringUtil.zeroConvert(commandMap.get("arrange_priority").toString()));    	
    	
    	int result = Integer.parseInt(webcoService.insert("MessageSettingDAO.insert", commandMap).toString());
		if(result > 0) {
			msg = "자동 문자발송 설정이 등록되었습니다";
    		return_url = "./showDetail.do?message_setting_index="+result;
    		out.println("<script>alert('"+msg+"'); location.href='"+return_url+"';</script>");
    	} else {
    		msg = "자동 문자발송 설정 등록 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    		out.println("<script>alert('"+msg+"'); history.back();</script>");
    	}    	    	    	        	    	
    	out.flush(); 
    }
    
    /**
     * 관리자 수정
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/messageSetting/update.do")
    public void update(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	// admin_id, admin_pwd, admin_nick_name, admin_grade, 
    	
    	String msg = "";
    	String return_url = "";
    	response.setContentType("text/html; charset=UTF-8");
    	PrintWriter out = response.getWriter();
    	int result = (int) webcoService.update("MessageSettingDAO.update", commandMap);
		if(result > 0) {
    		msg = "자동 문자발송 설정이 수정되었습니다";
    		return_url = "./showDetail.do?message_setting_index="+commandMap.get("message_setting_index");
    		out.println("<script>alert('"+msg+"'); location.href='"+return_url+"';</script>");
    	} else {
    		msg = "자동 문자발송 설정 수정 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    		out.println("<script>alert('"+msg+"'); history.back();</script>");
    	}
    	out.flush(); 
    }     
    
    /**
     * 관리자 삭제
     * @return String
     * @exception Exception
     */
    @RequestMapping(value="/messageSetting/remove.do")
    public void remove(ModelMap model, 	
			@RequestParam Map<String, Object> commandMap, 
			HttpServletRequest request, HttpServletResponse response) 
            throws Exception {
    	
    	int result = 0;
    	String msg = "";
    	if(!EgovStringUtil.isEmpty(commandMap.get("message_setting_index").toString())) {
			result =  webcoService.delete("MessageSettingDAO.delete", commandMap);
    	}
    	if(result > 0) {
    		msg = "자동 문자발송 설정이 삭제되었습니다";
    	} else {
    		msg = "자동 문자발송 설정 삭제 중 오류가 발생하였습니다. 잠시 후 다시 시도해주시기 바랍니다.";
    	}
    	response.setContentType("text/html; charset=UTF-8");    	 
    	PrintWriter out = response.getWriter();    	
    	out.println("<script>alert('"+msg+"'); location.href='./showList.do';</script>");    	 
    	out.flush();    	    
    }     
}

        