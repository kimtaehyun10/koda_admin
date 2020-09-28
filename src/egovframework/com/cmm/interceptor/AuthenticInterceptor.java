package egovframework.com.cmm.interceptor;

import java.io.PrintWriter;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import egovframework.webco.util.SessionUtil;
import egovframework.webco.vo.AdminVO;

/**
 * 인증여부 체크 인터셉터
 * @author 공통서비스 개발팀 서준식
 * @since 2011.07.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 *   수정일      수정자          수정내용
 *  -------    --------    ---------------------------
 *  2011.07.01  서준식          최초 생성
 *  2011.09.07  서준식          인증이 필요없는 URL을 패스하는 로직 추가
 *  </pre>
 */


public class AuthenticInterceptor extends HandlerInterceptorAdapter {
	private String[] permittedURL = {"/admin/adminChgPwd.do", "/admin/chgPwd.do", "/admin/adminEdit.do", "/admin/update.do"};
	/**
	 * 세션에 계정정보(AdminVO)가 있는지 여부로 인증 여부를 체크한다.
	 * 계정정보(AdminVO)가 없다면, 로그인 페이지로 이동한다.
	 */
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		String requestURI = request.getRequestURI(); //요청 URI		
		boolean isPermittedURL = false;

		AdminVO adminVO = (AdminVO) SessionUtil.getAuthenticatedUser();
	    
		if(adminVO != null){
			for(int i=0; i<permittedURL.length; i++){
				String urlPattern = request.getContextPath() + permittedURL[i];
				
				if(Pattern.matches(urlPattern, requestURI)){// 정규표현식을 이용해서 요청 URI가 허용된 URL에 맞는지 점검함.
					isPermittedURL = true;
				}							
			}	
			
			if(isPermittedURL){
				return true;
			}
			System.out.println("================================= 비밀번호 교체주기 체크");
			if(adminVO.getAdmin_phone() == null || adminVO.getAdmin_phone().equals("")) {
				System.out.println("================================= 휴대폰 등록");
				ModelAndView modelAndView = new ModelAndView("redirect:/admin/adminEdit.do");
				throw new ModelAndViewDefiningException(modelAndView);
			}
			if(adminVO.getAdmin_chg_pwd() == 1) {
				System.out.println("================================= 비밀번호 교체주기 체크::"+adminVO.getAdmin_chg_pwd());
				ModelAndView modelAndView = new ModelAndView("redirect:/admin/adminChgPwd.do");
				throw new ModelAndViewDefiningException(modelAndView);
			}			
			return true;
		} else {		
			if(request.getSession().getAttribute("dupLogin") != null && request.getSession().getAttribute("dupLogin").toString().equals("true")) {
				response.setContentType("text/html; charset=UTF-8");    	 
		    	PrintWriter out = response.getWriter();    	
		    	out.println("<script>alert('다른 사용자에 의해 로그아웃 되었습니다.'); location.href='"+request.getContextPath()+"/login.do';</script>");    	 
		    	out.flush();
		    	request.getSession().invalidate();
		    	return false;
			} else {
				 
				ModelAndView modelAndView = new ModelAndView("redirect:/login.do");
				throw new ModelAndViewDefiningException(modelAndView);
				/*if("http://www.juso.go.kr/".equals(request.getHeader("REFERER"))){
					return true;
				}else{
					
				}*/
				
								
			}			
		}
	}

}
