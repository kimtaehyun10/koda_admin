package egovframework.webco.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.webco.dao.WebcoDefaultDAO;
import egovframework.webco.service.UserService;
import egovframework.webco.util.CommonUtil;
import egovframework.webco.util.EnumValue;
import egovframework.webco.util.SMSManager;

@Service("userService")
public class UserServiceImpl extends EgovAbstractServiceImpl implements UserService{

	/** webcoDAO */
    @Resource(name="webcoDAO")
    private WebcoDefaultDAO webcoDAO;
    
	@Override
	public Object insert(Map commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		return webcoDAO.insert("UserDAO.insert", commandMap);
	}
	
	@Override
	public int update(Map param) throws Exception {
		// TODO Auto-generated method stub
		return webcoDAO.update("UserDAO.update", param);
	}
	
	/** Log 클래스의 인스턴스를 받아온다. */
    private final Log log = LogFactory.getLog(this.getClass());
    
    @Override
	public int saveUserInfo(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		//try {
			String user_social_security_num = "";
			String user_mobile = "";
			String user_phone = "";
			String user_email = "";
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_social_security_num_0")))
				&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_social_security_num_1")))) {
				user_social_security_num = commandMap.get("user_social_security_num_0").toString() + "-" + commandMap.get("user_social_security_num_1").toString();				
				// 주민번호 암호화
			}
			commandMap.put("user_social_security_num", user_social_security_num);
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_mobile_0")))
				&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_mobile_1")))
				&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_mobile_2")))) {
				user_mobile = commandMap.get("user_mobile_0").toString() + "-" + commandMap.get("user_mobile_1").toString() + "-" + commandMap.get("user_mobile_2").toString();
			}
			commandMap.put("user_mobile", user_mobile);
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_phone_0")))
				&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_phone_1")))
				&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_phone_2")))) {
				user_phone = commandMap.get("user_phone_0").toString() + "-" + commandMap.get("user_phone_1").toString() + "-" + commandMap.get("user_phone_2").toString();
			}
			commandMap.put("user_phone", user_phone);
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_email_1")))				
				&& !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_email_2")))) {
				user_email = commandMap.get("user_email_1").toString() + "@" + commandMap.get("user_email_2").toString();
			}
			commandMap.put("user_email", user_email);
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_birthday")))) {
				commandMap.put("user_birthday", CommonUtil.DateFormatChg(commandMap.get("user_birthday").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));								
			} else {
				commandMap.put("user_birthday", "");
			}
			
			if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_donation_type_body")))) {
				commandMap.put("user_donation_type_body", 0);
			}
			
			if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_donation_type_organ")))) {
				commandMap.put("user_donation_type_organ", 0);
			}
			
			if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_donation_type_comea")))) {
				commandMap.put("user_donation_type_comea", 0);
			}	
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_pledge_date")))) {
				commandMap.put("user_pledge_date", CommonUtil.DateFormatChg(commandMap.get("user_pledge_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
			} else {
				commandMap.put("user_pledge_date", "");
			}
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_registration_date")))) {
				commandMap.put("user_registration_date", CommonUtil.DateFormatChg(commandMap.get("user_registration_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
			} else {
				commandMap.put("user_registration_date", "");
			}
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_konos_registration_date")))) {
				commandMap.put("user_konos_registration_date", CommonUtil.DateFormatChg(commandMap.get("user_konos_registration_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
			} else {
				commandMap.put("user_konos_registration_date", "");
			}
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_withdraw_date")))) {
				commandMap.put("user_withdraw_date", CommonUtil.DateFormatChg(commandMap.get("user_withdraw_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
			} else {
				commandMap.put("user_withdraw_date", "");
			}
			
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_konos_withdraw_date")))) {
				commandMap.put("user_konos_withdraw_date", CommonUtil.DateFormatChg(commandMap.get("user_konos_withdraw_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
			} else {
				commandMap.put("user_konos_withdraw_date", "");
			}
			
			if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_is_legal_representative_text")))) {
				commandMap.put("user_is_legal_representative_text", 0);
			}
			
			if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_age")))) {
				commandMap.put("user_age", 0);
			}
			
			if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_sex")))) {
				commandMap.put("user_sex", 0);
			}
			
			Map<String, Object> prevUserInfo = (Map<String, Object>) webcoDAO.selectByPk("UserDAO.select", commandMap);
			
			commandMap.put("ipin_vno", "");
			commandMap.put("ipin_ci", "");
			commandMap.put("ipin_dup_info", "");
			commandMap.put("ipin_result_index", 0);
			commandMap.put("checkplus_dupinfo", "");
			commandMap.put("checkplus_conninfo", "");
			commandMap.put("checkplus_result_index", 0);
			commandMap.put("syrup_ci", "");	
			
			String flag = "";
			if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_index")))) {
				flag = "I";
				result = Integer.parseInt(webcoDAO.insert("UserDAO.insert", commandMap).toString());
				commandMap.put("user_index", result);

				if(EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("admin_num")))) {
					//commandMap.put("user_num", CommonUtil.currentDate("yyyyMMdd").substring(2, 4) + String.format("%7d", result));
					commandMap.put("user_num", String.format("%08d", result));
					result = webcoDAO.update("UserDAO.update", commandMap);
				}
				log.debug("===============서약자 등록완료");
			} else {
				flag = "U";
	            result = webcoDAO.update("UserDAO.update", commandMap);
	            
	            log.debug("===============서약자 수정완료");
			}		
			if(result > 0) {				
				if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("consult_date")))) {
		    		commandMap.put("consult_date", CommonUtil.DateFormatChg(commandMap.get("consult_date").toString(), "yyyy.MM.dd", "yyyy-MM-dd"));
		    	}
		    	
		    	if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("consult_memo"))) 
		    			|| !EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("consult_result")))) {
		    		//commandMap.put("consult_date", CommonUtil.dateToLong(CommonUtil.currentDate("yyyy.MM.dd"), "yyyy.MM.dd"));
		    		commandMap.put("consult_date", CommonUtil.currentDate("yyyy-MM-dd"));
		    		SimpleDateFormat format1 = new SimpleDateFormat ("HH:mm");
		    		Date time = new Date();
		    		commandMap.put("consult_time", format1.format(time));
		    	
		    			
					// 서약자 index가 존재하는 경우에만 insert/update 실행
					if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("user_index")))) {
						// consult_index가 있는 경우 업데이트 수행
						
						if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(commandMap.get("consult_index")))) {					
							result =  webcoDAO.update("ConsultDAO.update", commandMap);								
						} else {
							result =  Integer.parseInt(webcoDAO.insert("ConsultDAO.insert", commandMap).toString());				
							commandMap.put("consult_index", result);
						}					
					}
		    	}
			
	            EnumValue enumValue = new EnumValue();
	            String withdraw_key = enumValue.getKey("user_recognize_type", "탈퇴자");
	            if(flag.equals("I")) {
	            	 // Send SMS for greeting pledge
	                //$this->sendAutoSMS('greet_pledge', $user_mobile, $data_post['user_is_sms_agree']);
	            	sendAutoSMS("greet_pledge", user_mobile, commandMap.get("user_is_sms_agree").toString());
	                
	            } else if(prevUserInfo != null && EgovStringUtil.isNullToString(prevUserInfo.get("user_recognize_type")).equals(withdraw_key)
	            	&& EgovStringUtil.isNullToString(commandMap.get("user_recognize_type")).equals(withdraw_key)) {
	            	// Send SMS for sending withdraw info
	            	sendAutoSMS("withdraw_info", user_mobile, commandMap.get("user_is_sms_agree").toString());                       
	            } else {	                
	                // send sms only when basic user info is changed
	                /*foreach($previous_data as $i => $v) {
	                    if(empty($v))
	                        $previous_data->$i = '';
	                }
	                
	                if($previous_data->user_name != $data_array['user_name'] || $previous_data->user_social_security_num != $data_array['user_social_security_num'] ||
	                $previous_data->user_birthday != $data_array['user_birthday'] || $previous_data->user_sex != $data_array['user_sex'] ||
	                $previous_data->user_email != $data_array['user_email'] || $previous_data->user_post != $data_array['user_post'] ||
	                $previous_data->user_address != $data_array['user_address'] || $previous_data->user_address_detail != $data_array['user_address_detail'] ||
	                $previous_data->user_send_post != $data_array['user_send_post'] || $previous_data->user_send_address != $data_array['user_send_address'] ||
	                $previous_data->user_send_address_detail != $data_array['user_send_address_detail'] || $previous_data->user_mobile != $data_array['user_mobile'] ||
	                $previous_data->user_phone != $data_array['user_phone'] || $previous_data->user_legal_representative_info != $data_array['user_legal_representative_info']) {
	                    //echo "changed";
	                    //exit;
	                    $this->sendAutoSMS('change_user_info', $user_mobile, $data_post['user_is_sms_agree']);
	                }*/
	            	if(prevUserInfo != null && flag.equals("U") &&
	            			(EgovStringUtil.isNullToString(prevUserInfo.get("user_recognize_type")).equals(EgovStringUtil.isNullToString(commandMap.get("user_recognize_type"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_birthday")).equals(EgovStringUtil.isNullToString(commandMap.get("user_birthday"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_sex")).equals(EgovStringUtil.isNullToString(commandMap.get("user_sex"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_email")).equals(EgovStringUtil.isNullToString(commandMap.get("user_email"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_post")).equals(EgovStringUtil.isNullToString(commandMap.get("user_post"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_address")).equals(EgovStringUtil.isNullToString(commandMap.get("user_address"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_address_detail")).equals(EgovStringUtil.isNullToString(commandMap.get("user_address_detail"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_send_post")).equals(EgovStringUtil.isNullToString(commandMap.get("user_send_post"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_send_address")).equals(EgovStringUtil.isNullToString(commandMap.get("user_send_address"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_send_address_detail")).equals(EgovStringUtil.isNullToString(commandMap.get("user_send_address_detail"))) ||
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_mobile")).equals(EgovStringUtil.isNullToString(commandMap.get("user_mobile"))) || 
	            			EgovStringUtil.isNullToString(prevUserInfo.get("user_legal_representative_info")).equals(EgovStringUtil.isNullToString(commandMap.get("user_legal_representative_info"))))) {
	            		// Send SMS for changing user info
	            		sendAutoSMS("change_user_info", user_mobile, commandMap.get("user_is_sms_agree").toString());
	            	}	            	
	            }
			}
						
			/*$status = $this->input->post('status');
	        if($status == 1){
	            // add user
	            $data_post = $this->input->post();
	            $user_social_security_num = "";
	            $user_mobile = "";
	            $user_phone = "";
	            $user_email = "";
	            if(!empty($data_post['user_social_security_num_0']) && !empty($data_post['user_social_security_num_1'])) {
	                $user_social_security_num = $data_post['user_social_security_num_0'].'-'.$data_post['user_social_security_num_1'];
	                $user_social_security_num = $this->encryption->encrypt($user_social_security_num);
	            }
	            if(!empty($data_post['user_mobile_0']) && !empty($data_post['user_mobile_1']) && !empty($data_post['user_mobile_2']))
	                $user_mobile = $data_post['user_mobile_0'].'-'.$data_post['user_mobile_1'].'-'.$data_post['user_mobile_2'];
	            if(!empty($data_post['user_phone_0']) && !empty($data_post['user_phone_1']) && !empty($data_post['user_phone_2']))
	                $user_phone = $data_post['user_phone_0'].'-'.$data_post['user_phone_1'].'-'.$data_post['user_phone_2'];
	            if(!empty($data_post['user_email_1']) && !empty($data_post['user_email_2'])) {
	                $user_email = $data_post['user_email_1']."@".$data_post['user_email_2'];
	            }
	            $data_array = array(
	                'user_num'  => $data_post['user_num'],
	                'user_name' => $data_post['user_name'],
	                'user_social_security_num' => $user_social_security_num,
	                'user_birthday' => strtotimeKo($data_post['user_birthday']),
	                'user_sex' => !empty($data_post['user_sex'])?$data_post['user_sex']:'',
	                'user_email' => $user_email,
	                'user_post' => $data_post['user_post'],
	                'user_address' => $data_post['user_address'],
	                'user_address_detail' => $data_post['user_address_detail'],
	                'user_send_post' => $data_post['user_send_post'],
	                'user_send_address' => $data_post['user_send_address'],
	                'user_send_address_detail' => $data_post['user_send_address_detail'],
	                'user_age' => $data_post['user_age'],
	                'user_mobile' => $user_mobile,
	                'user_phone' => $user_phone,
	                'user_recognize_type' => $data_post['user_recognize_type'],
	                'user_donation_type_body' => !empty($data_post['user_donation_type_body']) ? $data_post['user_donation_type_body'] : 0,
	                'user_donation_type_organ' => !empty($data_post['user_donation_type_organ']) ? $data_post['user_donation_type_organ'] : 0,
	                'user_donation_type_comea' => !empty($data_post['user_donation_type_comea']) ? $data_post['user_donation_type_comea'] : 0,
	                'user_is_driving_license' => $data_post['user_is_driving_license'],
	                'user_konos_register_state' => $data_post['user_konos_register_state'],
	                'user_pledge_date' => strtotimeKo($data_post['user_pledge_date']),
	                'user_registration_date' => strtotimeKo($data_post['user_registration_date']),
	                'user_konos_registration_date' => strtotimeKo($data_post['user_konos_registration_date']),
	                'user_register' => $data_post['user_register'],
	                'user_register_channel' => $data_post['user_register_channel'],
	                'user_withdraw_date' => strtotimeKo($data_post['user_withdraw_date']),
	                'user_withdraw_reason' => $data_post['user_withdraw_reason'],
	                'user_withdraw_way' => $data_post['user_withdraw_way'],
	                'user_konos_withdraw_date' => strtotimeKo($data_post['user_konos_withdraw_date']),
	                'user_is_email_agree' => $data_post['user_is_email_agree'],
	                'user_is_sms_agree' => $data_post['user_is_sms_agree'],
	                'user_is_mail_agree' => $data_post['user_is_mail_agree'],
	                'user_pledge_card_state' => $data_post['user_pledge_card_state'],
	                'user_legal_representative_info' => $data_post['user_legal_representative_info'],
	                'user_is_legal_representative_text' => !empty($data_post['user_is_legal_representative_text']) ? $data_post['user_is_legal_representative_text'] : 0,
	                'update_time' => strtotime(date("Y-m-d H:i:s"))
	            );
	            $user_index = $data_post['user_index'];
	            $previous_data = $this->user->getUserDetails($user_index);
	            $this->user->edit($user_index, $data_array);
	            $this->saveConsult($user_index);

	            // Send SMS for withdraw

	            $withdraw_key = $this->enumvalue->getKey('user_recognize_type', '탈퇴자');
	            if($previous_data->user_recognize_type != $withdraw_key && $data_array['user_recognize_type'] == $withdraw_key) {
	                // Send SMS for sending withdraw info
	                //echo "withdraw";
	                //exit;
	                $this->sendAutoSMS('withdraw_info', $user_mobile, $data_post['user_is_sms_agree']);
	            } else {
	                // Send SMS for changing user info
	                // send sms only when basic user info is changed
	                foreach($previous_data as $i => $v) {
	                    if(empty($v))
	                        $previous_data->$i = '';
	                }
	                if($previous_data->user_name != $data_array['user_name'] || $previous_data->user_social_security_num != $data_array['user_social_security_num'] ||
	                $previous_data->user_birthday != $data_array['user_birthday'] || $previous_data->user_sex != $data_array['user_sex'] ||
	                $previous_data->user_email != $data_array['user_email'] || $previous_data->user_post != $data_array['user_post'] ||
	                $previous_data->user_address != $data_array['user_address'] || $previous_data->user_address_detail != $data_array['user_address_detail'] ||
	                $previous_data->user_send_post != $data_array['user_send_post'] || $previous_data->user_send_address != $data_array['user_send_address'] ||
	                $previous_data->user_send_address_detail != $data_array['user_send_address_detail'] || $previous_data->user_mobile != $data_array['user_mobile'] ||
	                $previous_data->user_phone != $data_array['user_phone'] || $previous_data->user_legal_representative_info != $data_array['user_legal_representative_info']) {
	                    //echo "changed";
	                    //exit;
	                    $this->sendAutoSMS('change_user_info', $user_mobile, $data_post['user_is_sms_agree']);
	                }
	            }
	            success('User/details/'.$user_index,'저장되었습니다.');
	        }else{
	            $this->load->view('main/index', $this->data);
	        }*/
		//} catch (Exception e) {
		//	result = -1;
		//	log.error(e);
		//}
		//return result;
		return Integer.parseInt(commandMap.get("user_index").toString());
	}

	@Override
	public int delete(Map<String, Object> commandMap) throws Exception {
		// TODO Auto-generated method stub
		return webcoDAO.delete("UserDAO.delete", commandMap);
	}
	
	@Override
	public Map<String, Object> selectUserInfo(Map<String, Object> commandMap)
			throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> userInfo = (Map<String, Object>) webcoDAO.selectByPk("UserDAO.select", commandMap);
		EnumValue enumValue = new EnumValue();
		
		/*
   	 // Calculate Age
           $user_detail->user_age = $this->getKoreaAge($user_detail->user_birthday);
           // Date Parsing
           $user_detail->user_birthday = dateNoZero("Y.m.d", $user_detail->user_birthday);
           $user_detail->user_pledge_date = dateNoZero("Y.m.d", $user_detail->user_pledge_date);
           $user_detail->user_registration_date = dateNoZero("Y.m.d", $user_detail->user_registration_date);
           $user_detail->user_withdraw_date = dateNoZero("Y.m.d", $user_detail->user_withdraw_date);
           $user_detail->user_konos_registration_date = dateNoZero("Y.m.d", $user_detail->user_konos_registration_date);
           $user_detail->user_konos_withdraw_date = dateNoZero("Y.m.d", $user_detail->user_konos_withdraw_date);
           // Social Security Number Parsing
           $user_social_security_num = $this->encryption->decrypt($user_detail->user_social_security_num);
           $user_detail->user_social_security_num = explode('-', $user_social_security_num);
           // Mobile/Phone Number Parsing
           $user_detail->user_mobile = explode('-', $user_detail->user_mobile);
           $user_detail->user_phone = explode('-', $user_detail->user_phone);
           // Email Parsing
           $user_detail->user_email = explode('@', $user_detail->user_email);
           // User Detail
           $this->data['user_detail'] = $user_detail;
           // User Consult
           $consult_list = $this->user->getConsultList($user_index);
           foreach($consult_list as $key => $consult) {
               $consult_list[$key]['consult_date'] = dateNoZero("Y.m.d", $consult['consult_date']);
           }
           $this->data['consult_list'] = $consult_list;
   	 */
		userInfo.put("user_age", CommonUtil.getKoreaAge(Long.toString(CommonUtil.dateToLong(userInfo.get("user_birthday").toString(), "yyyy-MM-dd"))));
		// Date Parsing
		userInfo.put("user_birthday", CommonUtil.DateFormatChg(userInfo.get("user_birthday").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
		userInfo.put("user_pledge_date", CommonUtil.DateFormatChg(userInfo.get("user_pledge_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
		userInfo.put("user_registration_date", CommonUtil.DateFormatChg(userInfo.get("user_registration_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
		userInfo.put("user_withdraw_date", CommonUtil.DateFormatChg(userInfo.get("user_withdraw_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
		userInfo.put("user_konos_registration_date", CommonUtil.DateFormatChg(userInfo.get("user_konos_registration_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
		userInfo.put("user_konos_withdraw_date", CommonUtil.DateFormatChg(userInfo.get("user_konos_withdraw_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
		// Mobile/Phone Number Parsing
		/*userInfo.put("user_mobile", userInfo.get("user_mobile").toString().split("-"));
		userInfo.put("user_phone", userInfo.get("user_phone").toString().split("-"));
		// Email Parsing
		userInfo.put("user_email", userInfo.get("user_email").toString().split("@"));*/
		
		return userInfo;
	}
	
	@Override
	public Map<String, Object> selectUserList(Map<String, Object> commandMap)
			throws Exception {
		// TODO Auto-generated method stub		
    	    	
		List<Map<String, Object>> userList = webcoDAO.list("UserDAO.selectList", commandMap);
		
		EnumValue enumValue = new EnumValue();
		for( Map<String, Object> userInfo : userList ) {
			/*
			// User Age
            $this->data['user_list'][$i]['user_age'] = $this->getKoreaAge($user['user_birthday']);
            // Date Parsing
            $this->data['user_list'][$i]['user_birthday'] = dateNoZero("Y.m.d", $user['user_birthday']);
            $this->data['user_list'][$i]['user_pledge_date'] = dateNoZero("Y.m.d", $user['user_pledge_date']);
            $this->data['user_list'][$i]['user_registration_date'] = dateNoZero("Y.m.d", $user['user_registration_date']);
            $this->data['user_list'][$i]['user_withdraw_date'] = dateNoZero("Y.m.d", $user['user_withdraw_date']);
            $this->data['user_list'][$i]['user_konos_registration_date'] = dateNoZero("Y.m.d", $user['user_konos_registration_date']);
            $this->data['user_list'][$i]['user_konos_withdraw_date'] = dateNoZero("Y.m.d", $user['user_konos_withdraw_date']);
            // Social Security Number Parsing
            $this->data['user_list'][$i]['user_social_security_num'] = !empty($user['user_social_security_num']) ? $this->encryption->decrypt($user['user_social_security_num']) : "";
            // Enum Parsing : Select menu
            $this->data['user_list'][$i]['user_sex'] = $this->enumvalue->getValue('user_sex', $user['user_sex']);
            $this->data['user_list'][$i]['user_recognize_type'] = $this->enumvalue->getValue('user_recognize_type', $user['user_recognize_type']);
            $this->data['user_list'][$i]['user_is_driving_license'] = $this->enumvalue->getValue('user_is_driving_license', $user['user_is_driving_license']);
            $this->data['user_list'][$i]['user_konos_register_state'] = $this->enumvalue->getValue('user_konos_register_state', $user['user_konos_register_state']);
            $this->data['user_list'][$i]['user_register_channel'] = $this->enumvalue->getValue('user_register_channel', $user['user_register_channel']);
            $this->data['user_list'][$i]['user_withdraw_reason'] = $this->enumvalue->getValue('user_withdraw_reason', $user['user_withdraw_reason']);
            $this->data['user_list'][$i]['user_withdraw_way'] = $this->enumvalue->getValue('user_withdraw_way', $user['user_withdraw_way']);
            $this->data['user_list'][$i]['user_is_email_agree'] = $this->enumvalue->getValue('user_is_email_agree', $user['user_is_email_agree']);
            $this->data['user_list'][$i]['user_is_sms_agree'] = $this->enumvalue->getValue('user_is_sms_agree', $user['user_is_sms_agree']);
            $this->data['user_list'][$i]['user_is_mail_agree'] = $this->enumvalue->getValue('user_is_mail_agree', $user['user_is_mail_agree']);
            $this->data['user_list'][$i]['user_pledge_card_state'] = $this->enumvalue->getValue('user_pledge_card_state', $user['user_pledge_card_state']);
            // Enum Parsing : Checkbox
            $this->data['user_list'][$i]['user_is_legal_representative_text'] = $this->enumvalue->getValue('user_is_legal_representative_text', $user['user_is_legal_representative_text']);
            $this->data['user_list'][$i]['user_donation_type_body'] = $this->enumvalue->getValue('user_donation_type_body', $user['user_donation_type_body']);
            $this->data['user_list'][$i]['user_donation_type_organ'] = $this->enumvalue->getValue('user_donation_type_organ', $user['user_donation_type_organ']);
            $this->data['user_list'][$i]['user_donation_type_comea'] = $this->enumvalue->getValue('user_donation_type_comea', $user['user_donation_type_comea']);
			 */	
			// Calculate Age
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(userInfo.get("user_birthday")))) {
				userInfo.put("user_age", CommonUtil.getKoreaAge(Long.toString(CommonUtil.dateToLong(userInfo.get("user_birthday").toString(), "yyyy-MM-dd"))));
			}
			// Date Parsing
	        userInfo.put("user_birthday", CommonUtil.DateFormatChg(userInfo.get("user_birthday").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
	        userInfo.put("user_pledge_date", CommonUtil.DateFormatChg(userInfo.get("user_pledge_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
	        userInfo.put("user_registration_date", CommonUtil.DateFormatChg(userInfo.get("user_registration_date").toString(), "yyyy-MM-dd", "yyyyMMdd"));
	        userInfo.put("user_withdraw_date", CommonUtil.DateFormatChg(userInfo.get("user_withdraw_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
	        userInfo.put("user_konos_registration_date", CommonUtil.DateFormatChg(userInfo.get("user_konos_registration_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
	        userInfo.put("user_konos_withdraw_date", CommonUtil.DateFormatChg(userInfo.get("user_konos_withdraw_date").toString(), "yyyy-MM-dd", "yyyy.MM.dd"));
	        // Social Security Number Parsing
	        //$this->data['user_list'][$i]['user_social_security_num'] = !empty($user['user_social_security_num']) ? $this->encryption->decrypt($user['user_social_security_num']) : "";
	        
	        /*if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(userInfo.get("user_social_security_num")))) {
	        	//userInfo.put("user_social_security_num", aesUtil.decrypt(userInfo.get("user_social_security_num").toString()));	        	
	        }*/
	        
	        userInfo.put("user_sex", enumValue.getValue("user_sex", userInfo.get("user_sex").toString()));
	        userInfo.put("user_recognize_type", enumValue.getValue("user_recognize_type", userInfo.get("user_recognize_type").toString()));
	        userInfo.put("user_is_driving_license", enumValue.getValue("user_is_driving_license", userInfo.get("user_is_driving_license").toString()));
	        userInfo.put("user_konos_register_state", enumValue.getValue("user_konos_register_state", userInfo.get("user_konos_register_state").toString()));
            userInfo.put("user_register_channel", enumValue.getValue("user_register_channel", userInfo.get("user_register_channel").toString()));
            userInfo.put("user_withdraw_reason", enumValue.getValue("user_withdraw_reason", userInfo.get("user_withdraw_reason").toString()));
            userInfo.put("user_withdraw_way", enumValue.getValue("user_withdraw_way", userInfo.get("user_withdraw_way").toString()));
            userInfo.put("user_is_email_agree", enumValue.getValue("user_is_email_agree", userInfo.get("user_is_email_agree").toString()));
            userInfo.put("user_is_sms_agree", enumValue.getValue("user_is_sms_agree", userInfo.get("user_is_sms_agree").toString()));
            userInfo.put("user_is_mail_agree", enumValue.getValue("user_is_mail_agree", userInfo.get("user_is_mail_agree").toString()));
            userInfo.put("user_pledge_card_state", enumValue.getValue("user_pledge_card_state", userInfo.get("user_pledge_card_state").toString()));
            // Enum Parsing : Checkbox
            userInfo.put("user_is_legal_representative_text", enumValue.getValue("user_is_legal_representative_text", userInfo.get("user_is_legal_representative_text").toString()));
            userInfo.put("user_donation_type_body", enumValue.getValue("user_donation_type_body", userInfo.get("user_donation_type_body").toString()));
            userInfo.put("user_donation_type_organ", enumValue.getValue("user_donation_type_organ", userInfo.get("user_donation_type_organ").toString()));
            userInfo.put("user_donation_type_comea", enumValue.getValue("user_donation_type_comea", userInfo.get("user_donation_type_comea").toString()));
        }
		
		int totCnt = (Integer)webcoDAO.selectByPk("UserDAO.selectCount", commandMap);
		
		Map<String, Object> rtnMap = new HashMap<String, Object>();
		rtnMap.put("user_list", userList);
		rtnMap.put("total_count", totCnt);
		
        return rtnMap;
	}
	
	@Override
	public boolean exportExcel(Map<String, Object> commandMap) throws Exception {		
		boolean result = true;
		FileOutputStream outputStream = null; // 파일 쓰기 스트림
		try {
			System.out.println("엑셀 생성시작==========>");
			HSSFWorkbook objWorkBook = new HSSFWorkbook();
			HSSFSheet objSheet = null;
			HSSFRow objRow = null;
			HSSFCell objCell = null;       //셀 생성
			
			HSSFFont font = objWorkBook.createFont();
			font.setFontHeightInPoints((short)9);
			font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
			font.setFontName("맑은고딕");
			
			//제목 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
			styleHd.setFont(font);
			styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
			
			HSSFFont font2 = objWorkBook.createFont();
			font2.setFontHeightInPoints((short)9);
			font2.setBoldweight((short)font2.BOLDWEIGHT_NORMAL);
			font2.setFontName("맑은고딕");
			
			//본문 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleBd = objWorkBook.createCellStyle();    //제목 스타일
			styleBd.setFont(font2);
			styleBd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleBd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
	
			objSheet = objWorkBook.createSheet("서약자 현황");     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			String[] title_data = {
			            "회원번호", "성명", "주민등록번호", "생년월일", "나이", "성별", "이메일", "우편번호", "주소", "상세주소", "송달우편번호", "송달주소", "송달상세주소", "휴대전화", "집전화", "서약구분",
			            "기증형태_장기", "기증형태_조직", "기증형태_각막", "운전면허증 표시", "Konos 등록상태", "서약일", "등록일", "Konos 등록일",
			            "등록자", "접수채널", "탈퇴일", "탈퇴사유", "가입경로", "Konos 탈퇴일", "이메일동의", "문자동의", "우편동의", "서약카드",
			            "법정대리인정보", "법정대리인 첨부서류"
			};
			for (int i=0; i < title_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(title_data[i]);
				objCell.setCellStyle(styleHd);					
			}
			int idx = 1;		
			
			Map<String, Object> rtnMap = this.selectUserList(commandMap);
			List<Map<String, Object>> userList = (List<Map<String, Object>>) rtnMap.get("user_list");
			
			for( Map<String, Object> userInfo : userList ) {
				 objRow = objSheet.createRow(idx);
				 objRow.setHeight((short) 0x150);
				 
				 String[] row_data = {
			                userInfo.get("user_num").toString(), userInfo.get("user_name").toString(), userInfo.get("user_social_security_num").toString(), userInfo.get("user_birthday").toString(), userInfo.get("user_age").toString(), userInfo.get("user_sex").toString(), userInfo.get("user_email").toString(),
			                userInfo.get("user_post").toString(), userInfo.get("user_address").toString(), userInfo.get("user_address_detail").toString(), userInfo.get("user_send_post").toString(), userInfo.get("user_send_address").toString(), userInfo.get("user_send_address_detail").toString(), userInfo.get("user_mobile").toString(), userInfo.get("user_phone").toString(), userInfo.get("user_recognize_type").toString(),
			                userInfo.get("user_donation_type_organ").toString(), userInfo.get("user_donation_type_body").toString(), userInfo.get("user_donation_type_comea").toString(), userInfo.get("user_is_driving_license").toString(), userInfo.get("user_konos_register_state").toString(), userInfo.get("user_pledge_date").toString(),
			                userInfo.get("user_registration_date").toString(), userInfo.get("user_konos_registration_date").toString(), userInfo.get("user_register").toString(), userInfo.get("user_register_channel").toString(), userInfo.get("user_withdraw_date").toString(), userInfo.get("user_withdraw_reason").toString(),
			                userInfo.get("user_withdraw_way").toString(), userInfo.get("user_konos_withdraw_date").toString(), userInfo.get("user_is_email_agree").toString(), userInfo.get("user_is_sms_agree").toString(), userInfo.get("user_is_mail_agree").toString(), userInfo.get("user_pledge_card_state").toString(),
			                userInfo.get("user_legal_representative_info").toString(), userInfo.get("user_is_legal_representative_text").toString()
				 };
				 
				 for (int i=0; i < row_data.length; i++) {
					objCell = objRow.createCell(i);
					objCell.setCellValue(row_data[i]);
					objCell.setCellStyle(styleBd);					
				 }
				 idx++;
			}
			for (int i=0; i < title_data.length; i++) {
				objSheet.autoSizeColumn(i);
			}
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/");				
			String filePath = "/uploads/user_list/user_list.xls"; // 대상 파일
			System.out.println("파일저장경로==========>"+realPath+filePath);
			outputStream = new FileOutputStream(new File(realPath+filePath));				
			objWorkBook.write(outputStream);
		} catch (IOException  e) {
			result = false;
            log.error(e);                 
		} catch (Exception e) {
			result = false;
            log.error(e);                   
        } 
		finally
		{
			try
			{
				// 파일 닫기. 여기에도 try/catch가 필요하다.
				outputStream.close();
			}
			catch (Exception e)
			{
				result = false;
			}
		}
		return result;
	}
	
	@Override
	public boolean exportLabelforSelectedUser(Map<String, Object> commandMap) throws Exception {		
		boolean result = false;
		FileOutputStream outputStream = null; // 파일 쓰기 스트림
		try {
			log.info("선택 라벨 엑셀 생성시작==========>");
			HSSFWorkbook objWorkBook = new HSSFWorkbook();
			HSSFSheet objSheet = null;
			HSSFRow objRow = null;
			HSSFCell objCell = null;       //셀 생성
			
			HSSFFont font = objWorkBook.createFont();
			font.setFontHeightInPoints((short)9);
			font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
			font.setFontName("맑은고딕");
			
			//제목 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
			styleHd.setFont(font);
			styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
			
			HSSFFont font2 = objWorkBook.createFont();
			font2.setFontHeightInPoints((short)9);
			font2.setBoldweight((short)font2.BOLDWEIGHT_NORMAL);
			font2.setFontName("맑은고딕");
			
			//본문 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleBd = objWorkBook.createCellStyle();    //제목 스타일
			styleBd.setFont(font2);
			styleBd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleBd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

			objSheet = objWorkBook.createSheet("서약자 라벨 현황");     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			/*	선택된 라벨로 출력되도록 변경
			String[] title_data = {
					 "회원번호", "성명", "우편번호", "주소+상세주소", "송달우편번호", "송달주소", "연락처"
			};
			*/
			String[] title_data = (String[]) commandMap.get("user_export_col_name_array");
			for (int i=0; i < title_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(title_data[i]);
				objCell.setCellStyle(styleHd);	
				log.info(i+"===>"+title_data[i]);
			}
			int idx = 1;	
			
			Map<String, Object> rtnMap = this.selectUserList(commandMap);
			List<Map<String, Object>> userList = (List<Map<String, Object>>) rtnMap.get("user_list");
			System.out.println("userList값은?!!!"+userList);
			EnumValue emumValue = new EnumValue();
			for( Map<String, Object> userInfo : userList ) {
				objRow = objSheet.createRow(idx);
				objRow.setHeight((short) 0x150);
				// get user phone : "user_mobile, user_phone"
				
				String[] data_col_list = (String[]) commandMap.get("user_export_col_array");
				
				for (int i=0; i < data_col_list.length; i++) {
					String col_name = data_col_list[i];
					
					String col_data = EgovStringUtil.isNullToString(userInfo.get(col_name));
					/*String col_data = "";
					if(col_name.equals("user_birthday") || col_name.equals("user_pledge_date") || col_name.equals("user_registration_date")
						|| col_name.equals("user_konos_registration_date") || col_name.equals("user_withdraw_date")) {
						col_data = CommonUtil.longToDateFormat(EgovStringUtil.isNullToString(userInfo.get(col_name)), "yyyy.MM.dd");
					} else if(col_name.equals("user_sex") || col_name.equals("user_recognize_type") || col_name.equals("user_donation_type_organ")
						|| col_name.equals("user_donation_type_body") || col_name.equals("user_donation_type_comea") || col_name.equals("user_is_driving_license")
						|| col_name.equals("user_register_channel") || col_name.equals("user_withdraw_reason") || col_name.equals("user_withdraw_way")
						|| col_name.equals("user_is_email_agree") || col_name.equals("user_is_sms_agree") || col_name.equals("user_is_mail_agree")
						|| col_name.equals("user_pledge_card_state") || col_name.equals("user_is_legal_representative_text")) {
						col_data = emumValue.getValue(col_name, EgovStringUtil.isNullToString(userInfo.get(col_name)));
					} else if(col_name.equals("user_age")) { 
						if(EgovStringUtil.isNullToString(userInfo.get(col_name)).equals("") || 
								EgovStringUtil.isNullToString(userInfo.get(col_name)).equals("0")) {
							if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(userInfo.get("user_birthday")))) {
								col_data = String.valueOf(CommonUtil.getKoreaAge(EgovStringUtil.isNullToString(userInfo.get("user_birthday"))));
							}
						} else { 
							col_data = EgovStringUtil.isNullToString(userInfo.get(data_col_list[i]));
						}
					} else {
						col_data = EgovStringUtil.isNullToString(userInfo.get(data_col_list[i]));
					}*/
					/*String[] row_data = {
							userInfo.get("user_num").toString(), userInfo.get("user_name").toString(), userInfo.get("user_post").toString(), userInfo.get("user_address").toString()+ " "+userInfo.get("user_address_detail").toString(), userInfo.get("user_send_post").toString(),
				            userInfo.get("user_send_address").toString()+ " " +userInfo.get("user_send_address_detail").toString(), user_phone				                
					};*/				 			
					objCell = objRow.createCell(i);
					objCell.setCellValue(col_data);
					objCell.setCellStyle(styleBd);					
				 }
				 idx++;
			}
			for (int i=0; i < title_data.length; i++) {
				objSheet.autoSizeColumn(i);
			}
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/");				
			String filePath = "/uploads/user_list/label_list.xls"; // 대상 파일			
			outputStream = new FileOutputStream(new File(realPath+filePath));				
			objWorkBook.write(outputStream);
			
			log.info("파일저장경로==========>"+realPath+filePath);
			result = true;
		} catch (IOException  e) {
			result = false;
            log.error(e);                  
        } catch (Exception e) {
			result = false;
            log.error(e);   
        } 
		finally
		{
			try
			{
				// 파일 닫기. 여기에도 try/catch가 필요하다.
				outputStream.close();
			}
			catch (Exception e)
			{
				result = false;
			}
		}
		return result;
	}
	
	@Override
	public boolean exportLabelforSelectedUserOrg(Map<String, Object> commandMap) throws Exception {		
		boolean result = true;
		FileOutputStream outputStream = null; // 파일 쓰기 스트림
		try {
			log.info("엑셀 생성시작==========>");
			HSSFWorkbook objWorkBook = new HSSFWorkbook();
			HSSFSheet objSheet = null;
			HSSFRow objRow = null;
			HSSFCell objCell = null;       //셀 생성
			
			HSSFFont font = objWorkBook.createFont();
			font.setFontHeightInPoints((short)9);
			font.setBoldweight((short)font.BOLDWEIGHT_BOLD);
			font.setFontName("맑은고딕");
			
			//제목 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleHd = objWorkBook.createCellStyle();    //제목 스타일
			styleHd.setFont(font);
			styleHd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleHd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);
			
			HSSFFont font2 = objWorkBook.createFont();
			font2.setFontHeightInPoints((short)9);
			font2.setBoldweight((short)font2.BOLDWEIGHT_NORMAL);
			font2.setFontName("맑은고딕");
			
			//본문 스타일에 폰트 적용, 정렬
			HSSFCellStyle styleBd = objWorkBook.createCellStyle();    //제목 스타일
			styleBd.setFont(font2);
			styleBd.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleBd.setVerticalAlignment (HSSFCellStyle.VERTICAL_CENTER);

			objSheet = objWorkBook.createSheet("서약자 라벨 현황");     //워크시트 생성
			objRow = objSheet.createRow(0);
			objRow.setHeight ((short) 0x150);
			
			String[] title_data = {
					 "회원번호", "성명", "우편번호", "주소+상세주소", "송달우편번호", "송달주소", "연락처"
			};
			for (int i=0; i < title_data.length; i++) {
				objCell = objRow.createCell(i);
				objCell.setCellValue(title_data[i]);
				objCell.setCellStyle(styleHd);					
			}
			int idx = 1;	
			
			Map<String, Object> rtnMap = this.selectUserList(commandMap);
			List<Map<String, Object>> userList = (List<Map<String, Object>>) rtnMap.get("user_list");
			
			for( Map<String, Object> userInfo : userList ) {
				objRow = objSheet.createRow(idx);
				objRow.setHeight((short) 0x150);
				// get user phone : "user_mobile, user_phone"
				String user_phone = "";
				if(userInfo.get("user_mobile") != null && !("").equals(userInfo.get("user_mobile").toString()))
					user_phone = userInfo.get("user_mobile").toString();
				if(userInfo.get("user_phone") != null && !("").equals(userInfo.get("user_phone").toString())) {
					if(!("").equals(user_phone))
						user_phone = user_phone+", "+userInfo.get("user_phone").toString();
					else
						user_phone = userInfo.get("user_phone").toString();
				}
				String[] row_data = {
						userInfo.get("user_num").toString(), userInfo.get("user_name").toString(), userInfo.get("user_post").toString(), userInfo.get("user_address").toString()+ " "+userInfo.get("user_address_detail").toString(), userInfo.get("user_send_post").toString(),
			            userInfo.get("user_send_address").toString()+ " " +userInfo.get("user_send_address_detail").toString(), user_phone				                
				};
				 
				 for (int i=0; i < row_data.length; i++) {
					objCell = objRow.createCell(i);
					objCell.setCellValue(row_data[i]);
					objCell.setCellStyle(styleBd);					
				 }
				 idx++;
			}
			for (int i=0; i < title_data.length; i++) {
				objSheet.autoSizeColumn(i);
			}
			HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder .getRequestAttributes()).getRequest();
			
			String realPath = request.getSession().getServletContext().getRealPath("/");				
			String filePath = "/uploads/user_list/label_list.xls"; // 대상 파일			
			outputStream = new FileOutputStream(new File(realPath+filePath));				
			objWorkBook.write(outputStream);
			
			log.info("파일저장경로==========>"+realPath+filePath);
		} catch (IOException  e) {
			result = false;
            log.error(e);                 
		} catch (Exception e) {
			result = false;
            log.error(e);                   
        } 
		finally
		{
			try
			{
				// 파일 닫기. 여기에도 try/catch가 필요하다.
				outputStream.close();
			}
			catch (Exception e)
			{
				result = false;
			}
		}
		return result;
	}
	
	//public void sendAutoSMS('greet_pledge', $user_mobile, $data_post['user_is_sms_agree']) throws Exception {
	public String sendAutoSMS(String messageCode, String user_mobile, String user_is_sms_agree) throws Exception {		
		String result = "";
		EnumValue enumValue = new EnumValue();
		
		if(EgovStringUtil.isEmpty(user_mobile)) {
			return "no user mobile number";
		}
		
		if(!user_is_sms_agree.equals("1")) {
			return "user deny sending sms";
		}
				
		
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("message_setting_code", messageCode);
		Map<String, Object> message_setting_value = (Map<String, Object>) webcoDAO.selectByPk("MessageSettingDAO.select", paramMap);
		
		if(message_setting_value != null) {
			log.debug("===============문자발송 준비");
			if(!message_setting_value.get("sms_send_state").toString().equals("1")) {
				log.debug("===============sms send state: No");
				return "sms send state: No";
			}
			
			Map<String, Object> smsMap = new LinkedHashMap<String, Object>();
			String sms_send_sender = enumValue.getValue("sms_send_sender", message_setting_value.get("sms_send_sender").toString());
			String[] sender = sms_send_sender.split("-");
			smsMap.put("sphone1", sender[0]);
			smsMap.put("sphone2", sender[1]);
			smsMap.put("sphone3", sender[2]);
			
			smsMap.put("msg", message_setting_value.get("sms_send_msg").toString());
			smsMap.put("rphone", user_mobile);						
			if(!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(message_setting_value.get("sms_type")))) {
				smsMap.put("sms_type", message_setting_value.get("sms_type").toString());
				if(message_setting_value.get("sms_type").toString().equals("L") &&
						!EgovStringUtil.isEmpty(EgovStringUtil.isNullToString(message_setting_value.get("sms_subject")))) {
					smsMap.put("subject", message_setting_value.get("sms_subject").toString());
				}
			}
			
			SMSManager smsManager = new SMSManager();			
			smsMap = smsManager.sendSmsAsync(smsMap);
		}
		return result;
	}

	@Override
	public int checkUserCI(String ipinCi) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> commandMap = new HashMap<String, Object>();
		int user_index = 0;
		commandMap.put("ipinCi", ipinCi);
		Map<String, Object> ipinUserInfo = (Map<String, Object>) webcoDAO.select("UserDAO.checkUserCI", commandMap);
		
		if(ipinUserInfo != null) {
			user_index = Integer.parseInt(ipinUserInfo.get("user_index").toString());
		}
				
		return user_index;
	}

	@Override
	public Map<String, Object> selectUserInfo(int user_index) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> commandMap = new HashMap<String, Object>();
		commandMap.put("user_index", user_index);
		Map<String, Object> userInfo = this.selectUserInfo(commandMap);
		return userInfo;
	}
	
}
