package egovframework.webco.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.AdminService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminActHistVO;
import egovframework.webco.vo.AdminVO;

@Service("adminService")
public class AdminServiceImpl extends EgovAbstractServiceImpl implements AdminService{
	@Autowired(required=true) 
	private HttpServletRequest request;	
	
	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;
    
    /** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());  
    
	@Override
	public Object insert(Map commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		return webcoDAO.insert("AdminDAO.insert", commandMap);
	}
	
	@Override
	public int update(Map commandMap) throws Exception {
		// TODO Auto-generated method stub
		return webcoDAO.update("AdminDAO.update", commandMap);
	}
		 

	@Override
	public int delete(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return webcoDAO.delete("AdminDAO.delete", commandMap);
	}
	
	@Override
	public Map<String, Object> selectAdminInfo(Map<String, Object> commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> adminInfo = (Map<String, Object>) webcoDAO.selectByPk("AdminDAO.select", commandMap);		
		
		// Date Parsing
		adminInfo.put("admin_create_time", CommonUtil.DateFormat(adminInfo.get("admin_create_time").toString(), "yyyy.MM.dd"));
		adminInfo.put("last_login_time", CommonUtil.DateFormat(adminInfo.get("last_login_time").toString(), "yyyy.MM.dd"));
		adminInfo.put("admin_pwd_chg_time", CommonUtil.DateFormat(adminInfo.get("admin_pwd_chg_time").toString(), "yyyy.MM.dd"));		
		
		return adminInfo;
	}
	
	@Override
	public Map<String, Object> selectAdminList(Map<String, Object> commandMap)
			throws Exception {
		// TODO Auto-generated method stub		
    	    	
		List<Map<String, Object>> adminList = webcoDAO.list("AdminDAO.selectList", commandMap);
		EnumValue enumValue = new EnumValue();
		for( Map<String, Object> adminInfo : adminList ) {
			
			// Date Parsing
			adminInfo.put("admin_create_time", CommonUtil.DateFormat(adminInfo.get("admin_create_time").toString(), "yyyy.MM.dd"));
			adminInfo.put("last_login_time", CommonUtil.DateFormat(adminInfo.get("last_login_time").toString(), "yyyy.MM.dd"));
			adminInfo.put("admin_pwd_chg_time", CommonUtil.DateFormat(adminInfo.get("admin_pwd_chg_time").toString(), "yyyy.MM.dd"));
        }
		
		int totCnt = (Integer)webcoDAO.selectByPk("UserDAO.selectCount", commandMap);
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("admin_list", adminList);
		rtnMap.put("total_count", totCnt);

        return rtnMap;
	}
	

	@Override
	public Map<String, Object> selectAdminInfo(int admin_index) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> commandMap = new HashMap<String, Object>();
		commandMap.put("admin_index", admin_index);
		Map<String, Object> adminInfo = this.selectAdminInfo(commandMap);
		return adminInfo;
	}
	
	@Override
	public Object insertActHist(AdminActHistVO adminActHistVO)
			throws Exception {
		// TODO Auto-generated method stub
		return webcoDAO.insert("AdminDAO.insertActHist", adminActHistVO);
	}
	
	@Override
	public Object insertActHist(String act_type, String act_detail)
			throws Exception {
		AdminActHistVO adminActHistVO = new AdminActHistVO();
		String act_ip = EgovClntInfo.getClntIP(request);
		String act_url = request.getRequestURI();
		AdminVO adminVO = SessionUtil.getAuthenticatedUser();
		
		adminActHistVO.setAct_type(act_type);
		adminActHistVO.setAct_detail(act_detail);
		adminActHistVO.setAct_url(act_url);
		adminActHistVO.setAct_ip(act_ip);
		adminActHistVO.setAdmin_index(adminVO.getAdmin_index());
		// TODO Auto-generated method stub
		return webcoDAO.insert("AdminDAO.insertActHist", adminActHistVO);
	}

	@Override
	public int endIdx(Map<String, Object> commandMap) {
		
		return webcoDAO.endIdx("AdminDAO.endIdx",commandMap);
	}

	@Override
	public Map<String, Object> selectedFile(Map<String, Object> commandMap) {
		
		return webcoDAO.selectedFile("AdminDAO.selectedFile",commandMap);
	}

	@Override
	public void fileUpload(Map<String, Object> commandMap) {

		webcoDAO.fileUpload("AdminDAO.fileUpload",commandMap);
	}

	@Override
	public List<Map<String, Object>> adminMenuList(Map<String, Object> commandMap) {

		return webcoDAO.adminMenuList("AdminDAO.adminMenuList",commandMap);
	}

	@Override
	public void adminMenuDelete(Map<String, Object> commandMap) {

		webcoDAO.adminMenuDelete("AdminDAO.adminMenuDelete",commandMap);
	}

	@Override
	public void adminMenuChange(Map<String, Object> commandMap) {

		webcoDAO.adminMenuChange("AdminDAO.adminMenuChange",commandMap);
	}
}
