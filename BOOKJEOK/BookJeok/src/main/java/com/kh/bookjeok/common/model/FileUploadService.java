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
        System.out.println(changeName);
        log.info("changName : {}",changeName);
        return "resources/uploadFiles/" + changeName;
    }

}

/*
 파일 업로드 service 만들어서 메서드 호출해서 사용하세용
 
 
 */
