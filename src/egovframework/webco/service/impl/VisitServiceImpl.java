package egovframework.webco.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.VisitService;

@Service("visitService")
public class VisitServiceImpl extends EgovAbstractServiceImpl implements VisitService{
	@Autowired(required=true) 
	private HttpServletRequest request;		
	
	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;
    
	@Override
	public int saveVisit() throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		String remote_addr = EgovClntInfo.getClntIP(request);
		String http_user_agent = request.getHeader("user-agent");
		String http_referer = EgovStringUtil.isNullToString(request.getHeader("referer"));
		HttpSession session = request.getSession();
		
		if(!EgovStringUtil.isNullToString(session.getAttribute("visit_id")).equals("1")) {
			session.setMaxInactiveInterval(60*60*2); // 세션 유지시간 2시간
			session.setAttribute("visit_id", "1"); // 세션저장
			        
			Map<String, Object> paramMap = new HashMap<String, Object>();		
			paramMap.put("remote_addr", remote_addr);
			paramMap.put("http_user_agent", http_user_agent);
			paramMap.put("http_referer", http_referer);			
			
			result = Integer.parseInt(webcoDAO.insert("VisitDAO.insert", paramMap).toString());	
		}
		
		return result;
	}
	
}
