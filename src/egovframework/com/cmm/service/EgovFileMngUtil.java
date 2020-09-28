package egovframework.com.cmm.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import egovframework.com.cmm.EgovWebUtil;
import egovframework.com.utl.fcc.service.EgovStringUtil;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * @Class Name  : EgovFileMngUtil.java
 * @Description : 메시지 처리 관련 유틸리티
 * @Modification Information
 *
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.02.13       이삼섭                  최초 생성
 *   2011.08.09       서준식                  utl.fcc패키지와 Dependency제거를 위해 getTimeStamp()메서드 추가
 *   2017-02-08		    이정은		  시큐어코딩(ES) - 부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see
 *
 */
@Component("EgovFileMngUtil")
public class EgovFileMngUtil {

    private static final Logger LOG = Logger.getLogger(EgovFileMngUtil.class.getName());

    public static final int BUFF_SIZE = 2048;

    @Resource(name = "propertiesService")
    protected EgovPropertyService propertyService;
    
    private String OnServerType = EgovProperties.getProperty("Globals.OnServerType"); // 서버 구동 구분(DEV:개발빛테스트서버, LIVE:실서버)
    

    //@Resource(name = "egovFileIdGnrService")
    //private EgovIdGnrService idgenService;

    /**
     * 첨부파일에 대한 목록 정보를 취득한다.
     *
     * @param files
     * @return
     * @throws Exception
     */
//    public List<FileVO> parseFileInf(Map<String, MultipartFile> files, String KeyStr, 
//            int fileKeyParam, String atchFileId, String storePath) throws Exception {
//	int fileKey = fileKeyParam;
//
//	String storePathString = "";
//	String atchFileIdString = "";
//
//	if ("".equals(storePath) || storePath == null) {
//	    storePathString = EgovProperties.getProperty("Globals.fileStorePath");
//	} else {
//	    storePathString = EgovProperties.getProperty(storePath);
//	}
//
//	if ("".equals(atchFileId) || atchFileId == null) {
//	   // atchFileIdString = idgenService.getNextStringId();
//		atchFileIdString = "1";		
//	} else {
//	    atchFileIdString = atchFileId;
//	}
//
//	File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));
//
//	if (!saveFolder.exists() || saveFolder.isFile()) {
//	    if (saveFolder.mkdirs()){
//			LOGGER.debug("[file.mkdirs] saveFolder : Creation Success ");
//		}else{
//			LOGGER.error("[file.mkdirs] saveFolder : Creation Fail ");
//			}
//		}
//	}
//
//	Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
//	MultipartFile file;
//	String filePath = "";
//	List<FileVO> result  = new ArrayList<FileVO>();
//	FileVO fvo;
//
//	while (itr.hasNext()) {
//	    Entry<String, MultipartFile> entry = itr.next();
//
//	    file = entry.getValue();
//	    String orginFileName = file.getOriginalFilename();
//
//	    //--------------------------------------
//	    // 원 파일명이 없는 경우 처리
//	    // (첨부가 되지 않은 input file type)
//	    //--------------------------------------
//	    if ("".equals(orginFileName)) {
//		continue;
//	    }
//	    ////------------------------------------
//
//	    int index = orginFileName.lastIndexOf(".");
//	    //String fileName = orginFileName.substring(0, index);
//	    String fileExt = orginFileName.substring(index + 1);
//	    String newName = KeyStr + getTimeStamp() + fileKey;
//	    long _size = file.getSize();
//
//	    if (!"".equals(orginFileName)) {
//		filePath = storePathString + File.separator + newName;
//		file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
//	    }
//	    fvo = new FileVO();
//	    fvo.setFileExtsn(fileExt);
//	    fvo.setFileStreCours(storePathString);
//	    fvo.setFileMg(Long.toString(_size));
//	    fvo.setOrignlFileNm(orginFileName);
//	    fvo.setStreFileNm(newName);
//	    fvo.setAtchFileId(atchFileIdString);
//	    fvo.setFileSn(String.valueOf(fileKey));
//
//	    //writeFile(file, newName, storePathString);
//	    result.add(fvo);
//
//	    fileKey++;
//	}
//
//	return result;
//    }
    

    /**
     * 첨부파일에 대한 목록 정보를 취득한다.
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> parseFileInf(Map<String, MultipartFile> files,
            String KeyStr, int fileKeyParam, String atchFileId, String storePath) throws Exception {
        int fileKey = fileKeyParam;

        //System.out.println("EgovFileUtil");

        String storePathString = ""; // 일반첨부파일, 이미지 저장 경로
        String storePathString_mov = ""; // 동영상 첨부파일 저장 경로
        String atchFileIdString = "";
        String pro_path     = "Globals."+OnServerType+".getFileStorePath";
//        System.out.println("".equals(storePath));
        // 첨부파일 저장 경로
        if (storePath == null || "".equals(storePath)) {
            /*
             * src/main/resources egovframework.spring context-properties.xml 에
             * 정의 되어 있음
             */
            
            storePathString     = EgovProperties.getProperty(pro_path) + "/";
            storePathString_mov = EgovProperties.getProperty(pro_path) + "/";
            
        } else {
            String pro_path_mov = "Globals."+OnServerType+".getCommonFilePath";
            
            storePathString     = EgovProperties.getProperty(pro_path)+storePath+"/";
            storePathString_mov = EgovProperties.getProperty(pro_path_mov)+storePath+"/";
//            System.out.println("dd");
        }

//        if (!"".equals(bbsId)) {
//            storePathString     = storePathString + "/";
//            storePathString_mov = storePathString_mov + "/";
//        } else {
            storePath = storePath+"/";
//        }
//            System.out.println("storePath==="+storePath);
//            System.out.println("storePathString==="+storePathString);
//            System.out.println("storePathString_mov==="+storePathString_mov);
        //System.out.println("storePathString="+storePathString);
        // 첨부파일 일련번호를 구한다
        if (atchFileId == null || "".equals(atchFileId)) {
            // atchFileIdString = idgenService.getNextStringId();
            atchFileIdString = "11"; // 
        } else {
            atchFileIdString = atchFileId;
        }

        File saveFolder = new File(storePathString);
        File saveFolder_img = new File(storePathString_mov);

        if (!saveFolder.exists() || saveFolder.isFile()) { 
            saveFolder.mkdirs();// 일반파일 저장폴더 생성
          //2017.02.07 	이정은 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			if (saveFolder.mkdirs()){
				LOG.debug("[file.mkdirs] saveFolder : Creation Success ");
			}else{
				LOG.error("[file.mkdirs] saveFolder : Creation Fail ");
			}
        }        
        if (!saveFolder_img.exists() || saveFolder_img.isFile()) {
          //2017.02.07 	이정은 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			if (saveFolder_img.mkdirs()){
				LOG.debug("[file.mkdirs] saveFolder : Creation Success ");
			}else{
				LOG.error("[file.mkdirs] saveFolder : Creation Fail ");
			}
        }

        Iterator<Entry<String, MultipartFile>> itr = files.entrySet()
                .iterator();
        MultipartFile file;
        String filePath = "";
        List<FileVO> result = new ArrayList<FileVO>();
        FileVO fvo;

        while (itr.hasNext()) {
            Entry<String, MultipartFile> entry = itr.next();
//log.debug("getKey.==================================="+entry.getKey());
            file = entry.getValue();
            String orginFileName = file.getOriginalFilename();
//log.debug("getName.==================================="+file.getName());
            // --------------------------------------
            // 원 파일명이 없는 경우 처리
            // (첨부가 되지 않은 input file type)
            // --------------------------------------
            if ("".equals(orginFileName)) {
                continue;
            }
            // //------------------------------------

            int index = orginFileName.lastIndexOf(".");
            // String fileName = orginFileName.substring(0, index);
            String fileExt = this.fileExtChk(orginFileName.substring(index + 1));
            String newName = KeyStr + EgovStringUtil.getTimeStamp() + fileKey;
            long _size = file.getSize();

            String fileClsCd = "1370230"; // 일반 파일
            
            
            if (!"".equals(orginFileName)) {
                
                if (entry.getKey().indexOf("img") >= 0 || entry.getKey().indexOf("mov") >= 0) { // 이미지 동영상 파일인경우
                    newName = newName +"."+fileExt;
                    
                    //2017.02.07 	이정은 	시큐어코딩(ES)-경로 조작 및 자원 삽입[CWE-22, CWE-23, CWE-95, CWE-99]
                    newName = EgovWebUtil.fileInjectPathReplaceAll(newName);
                    
                    if (entry.getKey().indexOf("img") >= 0) {
                        filePath = storePathString + File.separator + newName;
                        fileClsCd = "47100004"; // 이미지 파일
                    } else {
                        filePath = storePathString_mov + File.separator + newName;
                        fileClsCd = "47100009"; // 동영상 파일
                    }
                } else {
                    filePath = storePathString + File.separator + newName;
                }
                file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
            }
            
//            
//            if (fileExt.equals("jpg")  || fileExt.equals("jpeg")
//                    || fileExt.equals("gif")  || fileExt.equals( "png")
//                    || fileExt.equals("tif" ) || fileExt.equals("bmp")
//                    || fileExt.equals("pic")) {
//                fileClsCd = "47100004"; // 이미지 파일
//            }else if(fileExt.equals("mp4")  || fileExt.equals("avi")
//                    || fileExt.equals("mkv")  || fileExt.equals("mka")
//                    || fileExt.equals("mpeg") || fileExt.equals("mpg")
//                    || fileExt.equals("wmv" ) || fileExt.equals("asf")
//                    || fileExt.equals("mov")  || fileExt.equals("flv")){
//                fileClsCd = "47100009"; // 동영상 파일
//            }
            
            
            fvo = new FileVO();
            fvo.setOrignlFileNm(orginFileName);  // 원 파일명
            fvo.setStreFileNm(newName); 		 // 저장 파일명
            fvo.setFileMg(Long.toString(_size)); // 파일 크기
            fvo.setFileStreCours(storePath);  	 // 파일 저장경로
            fvo.setFileClsCd(fileClsCd); 		 // 파일 구분코드
            fvo.setFileExtsn(fileExt); 			 // 파일 확장자
//            fvo.setFileMg(_size);  			 // 파일 크기
//            fvo.setSubDir(bbsId);
            
//            log.debug("aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"+fvo);
            
//            fvo = new FileVO();
//            fvo.setFileext(fileExt);
//            // fvo.setFileStreCours(storePathString);
//            // fvo.setFile_capacity(Long.toString(_size));
//            fvo.setFile_capacity(_size);
//            fvo.setFile_real_name(orginFileName);
//            fvo.setFile_name(newName);
//            fvo.setMenu_id(bbsId);
            // fvo.setDesc_sn(String.valueOf(fileKey));
            /*
             * System.out.println("fileExt="+fileExt);
             * System.out.println("storePathString="+storePathString);
             * System.out.println("setFileMg="+Long.toString(_size));
             * System.out.println("setOrignlFileNm="+orginFileName);
             * System.out.println("setStreFileNm="+newName);
             * System.out.println("setStreFileNm="+atchFileIdString);
             * System.out.println("setFileSn="+String.valueOf(fileKey));
             */
            // writeFile(file, newName, storePathString);
            result.add(fvo);

            fileKey++;
        }

        return result;
    }
    
    /**
     * 첨부파일을 서버에 저장한다.
     *
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected void writeUploadedFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;

	try {
	    stream = file.getInputStream();
	    File cFile = new File(stordFilePath);

	    if (!cFile.isDirectory()) {
		boolean _flag = cFile.mkdir();
		if (!_flag) {
		    throw new IOException("Directory creation Failed ");
		}
	    }

	    bos = new FileOutputStream(stordFilePath + File.separator + newName);

	    int bytesRead = 0;
	    byte[] buffer = new byte[BUFF_SIZE];

	    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		bos.write(buffer, 0, bytesRead);
	    }
	} catch (Exception e) {
	    //e.printStackTrace();
	    LOG.error("IGNORE:", e);	// 2011.10.10 보안점검 후속조치
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
		} catch (Exception ignore) {
		    LOG.debug("IGNORED: " + ignore.getMessage());
		}
	    }
	    if (stream != null) {
		try {
		    stream.close();
		} catch (Exception ignore) {
		    LOG.debug("IGNORED: " + ignore.getMessage());
		}
	    }
	}
    }

    /**
     * 서버의 파일을 다운로드한다.
     *
     * @param request
     * @param response
     * @throws Exception
     */
    public static void downFile(HttpServletRequest request, HttpServletResponse response) throws Exception {

	String downFileName = "";
	String orgFileName = "";

	if ((String)request.getAttribute("downFile") == null) {
	    downFileName = "";
	} else {
	    downFileName = (String)request.getAttribute("downFile");
	}

	if ((String)request.getAttribute("orgFileName") == null) {
	    orgFileName = "";
	} else {
	    orgFileName = (String)request.getAttribute("orginFile");
	}

	orgFileName = orgFileName.replaceAll("\r", "").replaceAll("\n", "");

	File file = new File(EgovWebUtil.filePathBlackList(downFileName));

	if (!file.exists()) {
	    throw new FileNotFoundException(downFileName);
	}

	if (!file.isFile()) {
	    throw new FileNotFoundException(downFileName);
	}

	byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.

	response.setContentType("application/x-msdownload");
	response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(), "UTF-8"));
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");

	BufferedInputStream fin = null;
	BufferedOutputStream outs = null;

	try {
		fin = new BufferedInputStream(new FileInputStream(file));
	    outs = new BufferedOutputStream(response.getOutputStream());
	    int read = 0;

		while ((read = fin.read(b)) != -1) {
		    outs.write(b, 0, read);
		}
	} finally {
	    if (outs != null) {
			try {
			    outs.close();
			} catch (Exception ignore) {
			    //System.out.println("IGNORED: " + ignore.getMessage());
			    LOG.debug("IGNORED: " + ignore.getMessage());
			}
		    }
		    if (fin != null) {
			try {
			    fin.close();
			} catch (Exception ignore) {
			    //System.out.println("IGNORED: " + ignore.getMessage());
			    LOG.debug("IGNORED: " + ignore.getMessage());
			}
		    }
		}
    }

    /**
     * 첨부로 등록된 파일을 서버에 업로드한다.
     *
     * @param file
     * @return
     * @throws Exception
     */
    public static HashMap<String, String> uploadFile(MultipartFile file) throws Exception {

	HashMap<String, String> map = new HashMap<String, String>();
	//Write File 이후 Move File????
	String newName = "";
	String stordFilePath = EgovProperties.getProperty("Globals.fileStorePath");
	String orginFileName = file.getOriginalFilename();

	int index = orginFileName.lastIndexOf(".");
	//String fileName = orginFileName.substring(0, _index);
	String fileExt = orginFileName.substring(index + 1);
	long size = file.getSize();

	//newName 은 Naming Convention에 의해서 생성
	newName = getTimeStamp();	// 2012.11 KISA 보안조치
	writeFile(file, newName, stordFilePath);
	//storedFilePath는 지정
	map.put(Globals.ORIGIN_FILE_NM, orginFileName);
	map.put(Globals.UPLOAD_FILE_NM, newName);
	map.put(Globals.FILE_EXT, fileExt);
	map.put(Globals.FILE_PATH, stordFilePath);
	map.put(Globals.FILE_SIZE, String.valueOf(size));

	return map;
    }

    /**
     * 파일을 실제 물리적인 경로에 생성한다.
     *
     * @param file
     * @param newName
     * @param stordFilePath
     * @throws Exception
     */
    protected static void writeFile(MultipartFile file, String newName, String stordFilePath) throws Exception {
	InputStream stream = null;
	OutputStream bos = null;

	try {
	    stream = file.getInputStream();
	    File cFile = new File(EgovWebUtil.filePathBlackList(stordFilePath));

	    if (!cFile.isDirectory())
		cFile.mkdir();

	    bos = new FileOutputStream(EgovWebUtil.filePathBlackList(stordFilePath + File.separator + newName));

	    int bytesRead = 0;
	    byte[] buffer = new byte[BUFF_SIZE];

	    while ((bytesRead = stream.read(buffer, 0, BUFF_SIZE)) != -1) {
		bos.write(buffer, 0, bytesRead);
	    }
	} catch (Exception e) {
	    //e.printStackTrace();
	    //throw new RuntimeException(e);	// 보안점검 후속조치
		Logger.getLogger(EgovFileMngUtil.class).debug("IGNORED: " + e.getMessage());
	} finally {
	    if (bos != null) {
		try {
		    bos.close();
		} catch (Exception ignore) {
		    Logger.getLogger(EgovFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
		}
	    }
	    if (stream != null) {
		try {
		    stream.close();
		} catch (Exception ignore) {
		    Logger.getLogger(EgovFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
		}
	    }
	}
    }

    /**
     * 서버 파일에 대하여 다운로드를 처리한다.
     *
     * @param response
     * @param streFileNm
     *            : 파일저장 경로가 포함된 형태
     * @param orignFileNm
     * @throws Exception
     */
    public void downFile(HttpServletResponse response, String streFileNm, String orignFileNm) throws Exception {
	String downFileName = streFileNm;
	String orgFileName = orignFileNm;

	File file = new File(downFileName);
	//log.debug(this.getClass().getName()+" downFile downFileName "+downFileName);
	//log.debug(this.getClass().getName()+" downFile orgFileName "+orgFileName);

	if (!file.exists()) {
	    throw new FileNotFoundException(downFileName);
	}

	if (!file.isFile()) {
	    throw new FileNotFoundException(downFileName);
	}

	//byte[] b = new byte[BUFF_SIZE]; //buffer size 2K.
	int fSize = (int)file.length();
	if (fSize > 0) {
	    BufferedInputStream in = null;

	    try {
		in = new BufferedInputStream(new FileInputStream(file));

    	    	String mimetype = "text/html"; //"application/x-msdownload"

    	    	response.setBufferSize(fSize);
		response.setContentType(mimetype);
		response.setHeader("Content-Disposition:", "attachment; filename=" + orgFileName);
		response.setContentLength(fSize);
		//response.setHeader("Content-Transfer-Encoding","binary");
		//response.setHeader("Pragma","no-cache");
		//response.setHeader("Expires","0");
		FileCopyUtils.copy(in, response.getOutputStream());
	    } finally {
		if (in != null) {
		    try {
			in.close();
		    } catch (Exception ignore) {
			
			Logger.getLogger(EgovFileMngUtil.class).debug("IGNORED: " + ignore.getMessage());
		    }
		}
	    }
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	}

	/*
	String uploadPath = propertiesService.getString("fileDir");

	File uFile = new File(uploadPath, requestedFile);
	int fSize = (int) uFile.length();

	if (fSize > 0) {
	    BufferedInputStream in = new BufferedInputStream(new FileInputStream(uFile));

	    String mimetype = "text/html";

	    response.setBufferSize(fSize);
	    response.setContentType(mimetype);
	    response.setHeader("Content-Disposition", "attachment; filename=\""
					+ requestedFile + "\"");
	    response.setContentLength(fSize);

	    FileCopyUtils.copy(in, response.getOutputStream());
	    in.close();
	    response.getOutputStream().flush();
	    response.getOutputStream().close();
	} else {
	    response.setContentType("text/html");
	    PrintWriter printwriter = response.getWriter();
	    printwriter.println("<html>");
	    printwriter.println("<br><br><br><h2>Could not get file name:<br>" + requestedFile + "</h2>");
	    printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
	    printwriter.println("<br><br><br>&copy; webAccess");
	    printwriter.println("</html>");
	    printwriter.flush();
	    printwriter.close();
	}
	//*/


	/*
	response.setContentType("application/x-msdownload");
	response.setHeader("Content-Disposition:", "attachment; filename=" + new String(orgFileName.getBytes(),"UTF-8" ));
	response.setHeader("Content-Transfer-Encoding","binary");
	response.setHeader("Pragma","no-cache");
	response.setHeader("Expires","0");

	BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
	BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
	int read = 0;

	while ((read = fin.read(b)) != -1) {
	    outs.write(b,0,read);
	}
	log.debug(this.getClass().getName()+" BufferedOutputStream Write Complete!!! ");

	outs.close();
    	fin.close();
	//*/
    }

    /**
     * 2011.08.09
     * 공통 컴포넌트 utl.fcc 패키지와 Dependency제거를 위해 내부 메서드로 추가 정의함
     * 응용어플리케이션에서 고유값을 사용하기 위해 시스템에서17자리의TIMESTAMP값을 구하는 기능
     *
     * @param
     * @return Timestamp 값
     * @exception MyException
     * @see
     */
    private static String getTimeStamp() {

	String rtnStr = null;

	// 문자열로 변환하기 위한 패턴 설정(년도-월-일 시:분:초:초(자정이후 초))
	String pattern = "yyyyMMddhhmmssSSS";

	try {
	    SimpleDateFormat sdfCurrent = new SimpleDateFormat(pattern, Locale.KOREA);
	    Timestamp ts = new Timestamp(System.currentTimeMillis());

	    rtnStr = sdfCurrent.format(ts.getTime());
	} catch (Exception e) {
	    //e.printStackTrace();
		
	    //throw new RuntimeException(e);	// 보안점검 후속조치
	    LOG.debug("IGNORED: " + e.getMessage());
	}

	return rtnStr;
    }
    
    // 파일 확장자를 체크하여 보안에 위배되는 확장자는 확장자명을 바꾼다.
    public String fileExtChk(String fileExt) {
        String ext = "";
        
        fileExt = fileExt.toLowerCase(); // 소문자로 변환하여 체크
        if (fileExt != null) {
            if (fileExt.equals("jpg") || fileExt.equals("jpeg") || fileExt.equals("gif") || fileExt.equals("png")
                || fileExt.equals("tif") || fileExt.equals("bmp") || fileExt.equals("pic")
                || fileExt.equals("mp4") || fileExt.equals("avi") || fileExt.equals("mkv") || fileExt.equals("mka")
                || fileExt.equals("mpeg") || fileExt.equals("mpg") || fileExt.equals("wmv") || fileExt.equals("asf")
                || fileExt.equals("mov") || fileExt.equals("flv") 
                || fileExt.equals("doc") || fileExt.equals("docx") || fileExt.equals("ppt") || fileExt.equals("pptx")
                || fileExt.equals("xls") || fileExt.equals("xlsx") || fileExt.equals("hwp") || fileExt.equals("pdf")
                || fileExt.equals("zip") || fileExt.equals("tar") || fileExt.equals("jar") || fileExt.equals("txt")
                ) {
                
                ext = fileExt;                
                
            } else {
                
                ext = fileExt+"xx";
            }
        } 
        return ext;
    }
    
    /**
     * contents 파일 저장 및 정보 취득
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public List<FileVO> parseFileInf_contents(Map<String, MultipartFile> files,
                                              String storePath, 
                                              String sub_dir,
                                              String fileUniqYN,
                                              String fileRenameYN,
                                              String uploadFileName) throws Exception {
        
        String storePathString = "";
        String viewSubDir = ""; // 보여줄때 파일저장 경로 (DB에 저장되는 path경로)
        
        // 첨부파일 저장 경로
        if (storePath == null || "".equals(storePath)) {
            
            //String pro_path = "Globals."+OnServerType+".getWebappFilePath";
            String pro_path = "Globals."+OnServerType+".getCommonFilePath";
            storePathString = EgovProperties.getProperty(pro_path); // 파일저장경로
            
            if (!"".equals(sub_dir))
                viewSubDir = "/"+EgovProperties.getProperty("Globals.BaseDir")+sub_dir;
            
        } else {
            storePathString = propertyService.getString(storePath);
        }

        if (!"".equals(sub_dir))
            storePathString = storePathString + sub_dir;

        //System.out.println("storePathString="+storePathString);

        File saveFolder = new File(storePathString);

        if (!saveFolder.exists() || saveFolder.isFile()) {
            //2017.02.07 	이정은 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			if (saveFolder.mkdirs()){
				LOG.debug("[file.mkdirs] saveFolder : Creation Success ");
			}else{
				LOG.error("[file.mkdirs] saveFolder : Creation Fail ");
			}
        }

        Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file;
        String filePath = "";
        
        List<FileVO> result = new ArrayList<FileVO>();
        FileVO fvo;

        while (itr.hasNext()) {
            Entry<String, MultipartFile> entry = itr.next();

            file = entry.getValue();
            String orginFileName = file.getOriginalFilename();

            // --------------------------------------
            // 원 파일명이 없는 경우 처리
            // (첨부가 되지 않은 input file type)
            // --------------------------------------
            if ("".equals(orginFileName)) {
                continue;
            }
            // //------------------------------------

            int index = orginFileName.lastIndexOf(".");
            String fileName = orginFileName.substring(0, index);
            String fileExt = this.fileExtChk(orginFileName.substring(index + 1));
            String newName = fileName+"."+fileExt; 
            
            if (fileRenameYN != null && fileRenameYN.equals("Y")) {
                newName = "gb"+EgovStringUtil.getTimeStamp()+"."+fileExt; 
            }
            
            // uploadFileName 파일명을 받아왔다면 받아온 파일명으로 업로드
            if (uploadFileName != null && !uploadFileName.equals("")) {
                newName = uploadFileName;
            }
            
            if (fileUniqYN.equals("Y")) {
                // 파일명 중복 처리
                int fileNum = 0;
                File savefilePath = new File(storePathString + newName);
                while(savefilePath.exists()) {                    
                    fileNum++;
                    newName = fileName+"_"+fileNum+"."+fileExt;
                    savefilePath = new File(storePathString  + newName);
                }
            } else {
                File savefilePath = new File(storePathString + newName);
                if (savefilePath.exists()) {
                    //log.debug("==========================================파일삭제="+storePathString + newName);
                    boolean chk = savefilePath.delete();
                    //log.debug("==========================================파일삭제"+chk);
                }
            }
            
            
            long _size = file.getSize();

            if (!"".equals(orginFileName)) {
            	//2017.02.07 	이정은 	시큐어코딩(ES)-경로 조작 및 자원 삽입[CWE-22, CWE-23, CWE-95, CWE-99]
				newName = EgovWebUtil.fileInjectPathReplaceAll(newName);
                filePath = storePathString + File.separator + newName;
                //file.transferTo(new File(filePath));
				file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
            }
            
//            log.debug("==========================================");
//            log.debug("저장위치:"+storePathString);
//            log.debug("fileExt:"+fileExt);
//            log.debug("newName:"+newName);
//            log.debug("fileName:"+fileName);
//            log.debug("size:"+_size);
//            log.debug("==========================================");
            
            
            //저장된 파일 내용            
            fvo = new FileVO();
            fvo.setFileExtsn(fileExt); // 파일 확장자
            fvo.setFileStreCours(storePathString);  // 파일저장경로
            fvo.setFileMg(Long.toString(_size)); // 파일크기
            //fvo.setFileMg(_size);  // 파일크기
            fvo.setOrignlFileNm(orginFileName);  // 원파일명
            fvo.setStreFileNm(newName); // 저장파일명
            fvo.setSubDir(viewSubDir);
            
            result.add(fvo);

        }

        //System.out.println(result);
        
        return result;
    }
    
    /**
     * contents 파일 삭제
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public boolean fileDelete_contents(String storePath, String sub_dir,
                                              String file_name) throws Exception {

        String storePathString = "";

        boolean result = false;
                
        // 첨부파일 저장 경로
        if (storePath == null || "".equals(storePath)) {
            
            String pro_path = "Globals."+OnServerType+".getCommonFilePath";
            storePathString = EgovProperties.getProperty(pro_path); // 파일저장경로
        
        } else {
            storePathString = propertyService.getString(storePath);
        }
//       log.debug("file_name==========================================파일삭제"+file_name);
       file_name = EgovStringUtil.replace(file_name, "..", "");// 경로를 못바꾸게 한다.
       
       File savefilePath = new File(storePathString + sub_dir + file_name);
        if (savefilePath.exists()) {
            result = savefilePath.delete();
//            log.debug("==========================================파일삭제"+result);
        }
        
        return result;
    }
    
    /**
     * 업로드 파일 확장자 체크
     * 
     * @param files
     * @return
     * @throws Exception
     */
    public String uploadFileExtChk(Map<String, MultipartFile> files,
                                              String storePath, 
                                              String sub_dir,
                                              String fileType) throws Exception {
        
        String chk = "";
        String chkExt = ""; // 체크후 확장자
        
        String storePathString = "";

        // 첨부파일 저장 경로
        if (storePath == null || "".equals(storePath)) {
            
            String pro_path = "Globals."+OnServerType+".getCommonFilePath";
            storePathString = EgovProperties.getProperty(pro_path); // 파일저장경로
        
        } else {
            storePathString = propertyService.getString(storePath);
        }

        if (!"".equals(sub_dir))
            storePathString = storePathString + sub_dir;

        //System.out.println("storePathString="+storePathString);

        File saveFolder = new File(storePathString);

        if (!saveFolder.exists() || saveFolder.isFile()) {
        	//2017.02.07 	이정은 	시큐어코딩(ES)-부적절한 예외 처리[CWE-253, CWE-440, CWE-754]
			if (saveFolder.mkdirs()){
				LOG.debug("[file.mkdirs] saveFolder : Creation Success ");
			}else{
				LOG.error("[file.mkdirs] saveFolder : Creation Fail ");
			}
        }

        Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
        MultipartFile file;
        String filePath = "";
        
        List<FileVO> result = new ArrayList<FileVO>();
        FileVO fvo;

        while (itr.hasNext()) {
            Entry<String, MultipartFile> entry = itr.next();

            file = entry.getValue();
            String orginFileName = file.getOriginalFilename();

            // --------------------------------------
            // 원 파일명이 없는 경우 처리
            // (첨부가 되지 않은 input file type)
            // --------------------------------------
            if ("".equals(orginFileName)) {
                chk = "NoFile";
                continue;
            }
            // //------------------------------------

            //log.debug("files111111111111111111111111111111111=========="+files);
            
            int index = orginFileName.lastIndexOf(".");
            String fileName = orginFileName.substring(0, index);           
            String fileExt = orginFileName.substring(index + 1);
            fileExt = fileExt.toLowerCase(); // 소문자로 변환하여 체크
            
            if (fileType.equals("img")) { // 이미지 파일 확장자 체크인경우
                if (fileExt.equals("jpg") || fileExt.equals("jpeg") || fileExt.equals("gif") || fileExt.equals("png")
                        || fileExt.equals("tif") || fileExt.equals("bmp") || fileExt.equals("pic")) {
                    
                    chkExt = fileExt;                
                    
                } else {
                    
                    chkExt = fileExt+"xx";
                }
            } else { // 기타 나머지 파일 확장자 인경우      
                chkExt = fileExtChk(fileExt);                
            }
            
            if (chkExt.equals(fileExt)) { // 변환전이랑 변환후 확장자가 같으면 true
                chk = "Y";
            } else {
                chk = "N";
            }

        }
        
        return chk;
    }
}
