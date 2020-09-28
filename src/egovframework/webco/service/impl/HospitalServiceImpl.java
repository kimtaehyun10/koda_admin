package egovframework.webco.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.HospitalService;

@Service("hospitalService")
public class HospitalServiceImpl implements HospitalService {

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;    	
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());

	@Override
	public List<Map<String, Object>> hospitalList(
			Map<String, Object> commandMap) {

		return webcoDAO.hospitalList("HospitalDAO.hospitalList",commandMap);
	}

	@Override
	public int hospitalListTotCnt(Map<String, Object> commandMap) {
	
		return webcoDAO.hospitalListTotCnt("HospitalDAO.hospitalListTotCnt",commandMap);
	}

	@Override
	public Map<String, Object> selectedHospital(Map<String, Object> commandMap) {

		return webcoDAO.selectedHospital("HospitalDAO.selectedHospital",commandMap);
	}

	@Override
	public void hospitalUpdateEnd(Map<String, Object> commandMap) {
		
		webcoDAO.hospitalUpdateEnd("HospitalDAO.hospitalUpdateEnd",commandMap);
	}

	@Override
	public void hospitalDeleteEnd(Map<String, Object> commandMap) {
		
		webcoDAO.hospitalDeleteEnd("HospitalDAO.hospitalDeleteEnd",commandMap);
	}

	@Override
	public void hospitalWriteEnd(Map<String, Object> commandMap) {

		webcoDAO.hospitalWriteEnd("HospitalDAO.hospitalWriteEnd",commandMap);
	}
    
}
