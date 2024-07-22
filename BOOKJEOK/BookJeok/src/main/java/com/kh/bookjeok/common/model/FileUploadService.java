package com.kh.bookjeok.common.model;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class FileUploadService {
	public String saveFile(MultipartFile upfile, HttpSession session) {
        String originName = upfile.getOriginalFilename();
        String ext = originName.substring(originName.lastIndexOf("."));
        int num = (int)(Math.random() * 900) + 100;
        String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
        String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
        String changeName = "KH_" + currentTime + "_" + num + ext;

        try {
            upfile.transferTo(new File(savePath + changeName));
        } catch (IllegalStateException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println("changeName"+changeName);
        return "resources/uploadFiles/" + changeName;
    }
	
	public int deleteFile(String url) {
		//해당 파일이 저장소에 있는지를 비교
		
		
		int i = 0;
		return i == 0 ? 0 : 1;
		 
	}
}
