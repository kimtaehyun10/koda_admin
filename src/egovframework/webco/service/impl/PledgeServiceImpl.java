package egovframework.webco.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import egovframework.com.utl.sim.service.EgovClntInfo;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.PledgeService;

@Service("pledgeService")
public class PledgeServiceImpl extends EgovAbstractServiceImpl implements PledgeService{
	@Autowired(required=true) 
	private HttpServletRequest request;		
	
	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;
    
	@Override
	public int saveVisit() throws Exception {
		// TODO Auto-generated method stub
		String remote_addr = EgovClntInfo.getClntIP(request);
		String http_user_agent = request.getHeader("user-agent");
		String http_referer = request.getHeader("referer");
		
		Map<String, Object> paramMap = new HashMap<String, Object>();		
		paramMap.put("remote_addr", remote_addr);
		paramMap.put("http_user_agent", http_user_agent);
		paramMap.put("http_referer", http_referer);
		
		int result = Integer.parseInt(webcoDAO.insert("VisitDAO.insert", paramMap).toString());		
		
		return result;
	}
	
}
