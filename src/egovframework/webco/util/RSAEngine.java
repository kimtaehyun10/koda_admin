/**
 * @Class Name  : RSAEngine.java
 * @Description : 문자열 RSA 암호화에 필요한 메소드
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2014.05.21     문주식          최초 생성
 *
 * @author 개발1팀
 * @since 2014.05.21
 * @version 1.0
 * @see 
 * 
 */

package egovframework.webco.util;


import java.util.HashMap;
import java.util.Map;
import java.security.KeyFactory;
import java.security.KeyPair;
import java.security.KeyPairGenerator;
import java.security.PrivateKey;
import java.security.PublicKey;
import java.security.spec.RSAPublicKeySpec;

import javax.crypto.Cipher;
import javax.servlet.http.HttpServletRequest;

public class RSAEngine {
	/**
	 * KEY_SIZE
	 */	
	public static final int KEY_SIZE = 1024;

	/**
	 * 공개키 생성 (공개키를 문자열로 반환)
	 */
	public static Map<String, Object> getPublicKeyString(HttpServletRequest request) {

	    Map<String, Object> publicKeyMap = new HashMap();
	    
	    try {
    	    KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(KEY_SIZE);
            
            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
    
            // 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
            request.getSession().setAttribute("rsaPrivateKey", privateKey);
            
            // 공개키를 문자열로 변환하여 JavaScript RSA 라이브러리 넘겨준다.
            RSAPublicKeySpec publicSpec = (RSAPublicKeySpec) keyFactory.getKeySpec(publicKey, RSAPublicKeySpec.class);
    
            String publicKeyModulus = publicSpec.getModulus().toString(16);
            String publicKeyExponent = publicSpec.getPublicExponent().toString(16);
                        
            publicKeyMap.put("modulus", publicKeyModulus);
            publicKeyMap.put("exponent", publicKeyExponent);
            
	    } catch (Exception ex) {
	        publicKeyMap = null;
            //throw new ServletException(ex.getMessage(), ex);
        }
		return publicKeyMap;
	}
	
	
	/**
     * 문자열 복호화(JavaScript 로 암호화 한경우)
     * @param privateKey , securedValue
     * @param request   - 
     * @return result   - 
     * @exception Exception
     */
    public static String decryptRsa(PrivateKey privateKey, String securedValue) throws Exception {
        
        String decryptedValue  = "";
        
        if(securedValue != null && !securedValue.equals("")){
        
            Cipher cipher = Cipher.getInstance("RSA");
            byte[] encryptedBytes = hexToByteArray(securedValue);
            cipher.init(Cipher.DECRYPT_MODE, privateKey);
            byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
            decryptedValue = new String(decryptedBytes, "utf-8"); // 문자 인코딩 주의.
        }
        
        return decryptedValue;
    }
    
    /**
     * 16진 문자열을 byte 배열로 변환한다.
     */
    public static byte[] hexToByteArray(String hex) {
        if (hex == null || hex.length() % 2 != 0) {
            return new byte[]{};
        }

        byte[] bytes = new byte[hex.length() / 2];
        for (int i = 0; i < hex.length(); i += 2) {
            byte value = (byte)Integer.parseInt(hex.substring(i, i + 2), 16);
            bytes[(int) Math.floor(i / 2)] = value;
        }
        return bytes;
    }
    
    
    
	/**
     * 공개키 생성 (공개키를 key로 반환)
     */
    public static PublicKey getPublicKeyJava(HttpServletRequest request) {
        
        try {
            KeyPairGenerator generator = KeyPairGenerator.getInstance("RSA");
            generator.initialize(KEY_SIZE);
            
            KeyPair keyPair = generator.genKeyPair();
            KeyFactory keyFactory = KeyFactory.getInstance("RSA");
    
            PublicKey publicKey = keyPair.getPublic();
            PrivateKey privateKey = keyPair.getPrivate();
    
            // 세션에 공개키의 문자열을 키로하여 개인키를 저장한다.
            request.getSession().setAttribute("rsaPrivateKey", privateKey);
            
            return publicKey;
            
        } catch (Exception ex) {
            return null;
            //throw new ServletException(ex.getMessage(), ex);
        }
        
        
    }

    
    
    /**
     * java에서 String 값을 암복호화 할경우 예제
     * 
    
        PublicKey publicKey = RSAEngine.getPublicKeyJava(request);
        String entestString = RSAEngine.encrypteRsaJava(publicKey, "abcd1234"); // 문자열 암호화
        
        log.debug("암호화 ===========" + entestString);
            
        PrivateKey privateKey = (PrivateKey) session.getAttribute("rsaPrivateKey");         
        String detestString = RSAEngine.decryptRsaJava(privateKey, entestString); // 복호화
        
        log.debug("복호화 ===========" + detestString);
        
    /*
	
	/**
     * 문자열 암호화 (Java에서 String값 암호화)
     * @param privateKey , securedValue
     * @param request   - 
     * @return result   - 
     * @exception Exception
     */
    public static String encrypteRsaJava(PublicKey publicKey, String securedValue) throws Exception {
        
        Cipher cipher = Cipher.getInstance("RSA");
        cipher.init( Cipher.ENCRYPT_MODE, publicKey);
        
        byte[] arrCipherData = cipher.doFinal( securedValue.getBytes( ) );

        //String encryptedValue = new String( arrCipherData, "utf-8" );
        //System.out.println( "encryptedValue(" + encryptedValue + ")" );
        String encryptedValue = new java.math.BigInteger(arrCipherData).toString(16);
        
        return encryptedValue;

    }
    
	/**
     * 문자열 복호화 (Java에서 암호화한 값을 복호화)
     * @param privateKey , securedValue
     * @param request   - 
     * @return result   - 
     * @exception Exception
     */
    public static String decryptRsaJava(PrivateKey privateKey, String securedValue) throws Exception {
        
        Cipher cipher = Cipher.getInstance("RSA");
        byte[] encryptedBytes = new java.math.BigInteger(securedValue, 16).toByteArray();
        cipher.init(Cipher.DECRYPT_MODE, privateKey);
        byte[] decryptedBytes = cipher.doFinal(encryptedBytes);
        String decryptedValue = new String(decryptedBytes); // 문자 인코딩 주의.
        
        return decryptedValue;
    }
    
    
}
