package com.kh.bookjeok.qna.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import com.kh.bookjeok.qna.model.service.QnaService;
import com.kh.bookjeok.qna.model.vo.Question;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class QnaController {

	private final QnaService qnaService;
	/*
	@GetMapping("list.qna")
	public String list(Model model) {
		
		// paging
		
		List <Question> question = qnaService.findById();
		
		log.info("조회된 1대1 문의사항 개수 : {}", question.size());
		log.info("조회된 1대1 문의사항 목록 : {}", question);
		
		model.addAttribute("question", question);
		
		return "qna/questionList";
	}
	
	
	@GetMapping("search.qna")
	public String search(String condition,
					     String keyword,
					     Model model) {
		
		log.info("검색조건 : {}", condition);
		log.info("검색키워드 : {}", keyword);
	}
	*/
	
	@GetMapping("insertForm.question")
	public String insertForm() {
		return "qna/question-insert";
	}
	
	@PostMapping("insert.question")
	public String insertQustion(Question question,
						 		HttpSession session,
						 		Model model,
						 		MultipartFile upfile) {
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			question.setQuestionOriginname(upfile.getOriginalFilename());
			question.setQuestionChangename(saveFile(upfile, session));
		}
		
		
		if(qnaService.insertQuestion(question) > 0) {
			
			session.setAttribute("alertMsg", "문의완료!");
			return "redirect:questionList";
			
		} else {
			
			model.addAttribute("errorMsg", "문의실패!");
			return "redirect:questionList";
		}
	}
	
	public String saveFile(MultipartFile upfile, HttpSession session) {
		
		String originname = upfile.getOriginalFilename();
		
		String ext = originname.substring(originname.lastIndexOf("."));
		
		int num = (int)(Math.random() * 900) + 100;
		
		String currentTime = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		
		String savePath = session.getServletContext().getRealPath("resources/uploadFiles/");
		
		String changename = "BOOKJEOK_" + currentTime + "_" + num + ext;
		
		try {
			upfile.transferTo(new File(savePath + changename));
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		return "resources/uploadFiles/" + changename;
	}
}
