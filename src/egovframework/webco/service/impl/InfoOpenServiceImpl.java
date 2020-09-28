package egovframework.webco.service.impl;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Service;

import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.InfoOpenService;

@Service("infoOpenService")
public class InfoOpenServiceImpl implements InfoOpenService {

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;    	
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
}
