package com.kh.bookjeok.qna.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookjeok.model.Page;
import com.kh.bookjeok.qna.model.service.QnaService;
import com.kh.bookjeok.qna.model.vo.Question;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class QnaController {

	private final QnaService qnaService;
	
	@GetMapping("list.qna")
	public String list(@RequestParam(value="page", defaultValue="1") int page,
					   Model model,
					   Page pageInfo) {
		
		// paging
		
		int listCount; 		// 게시글 수
		int currentPage;	// 현재 페이지
		int pageLimit;		// 페이징 바(버튼)에 보여질 최대 개수
		int listLimit;		// 한 페이지에 보여질 게시글 최대 개수
		

		int maxPage;		// 총 페이지 개수
		int startPage;		// 페이징 바의 시작 수 
		int endPage;		// 페이징 바의 마지막 수

		
		listCount = qnaService.qnaCount();
		currentPage = page;
		
		pageLimit = 10;
		listLimit = 10;
		
		maxPage = (int)Math.ceil((double)listCount/listLimit);
		
		startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		
		endPage = startPage + pageLimit - 1;
		
		if(endPage > maxPage) endPage = maxPage;
		
		int startValue = (currentPage - 1) * listLimit + 1;
		
		int endValue = startValue + listLimit - 1;
		
		pageInfo = Page.builder()
					   .listCount(listCount)
					   .currentPage(currentPage)
					   .pageLimit(pageLimit)
					   .listLimit(listLimit)
					   .maxPage(maxPage)
					   .startPage(startPage)
					   .endPage(endPage)
					   .build();
		
		Map<String, Integer> map = new HashMap();
		
		map.put("startValue", startValue);
		map.put("endValue", endValue);
		
		List<Question> question = qnaService.findAll(map);
		
		log.info("조회된 1대1 문의사항 개수 : {}", question.size());
		log.info("조회된 1대1 문의사항 목록 : {}", question);
		
		model.addAttribute("question", question);
		model.addAttribute("pageInfo", pageInfo);
		
		return "qna/qna-list";
	}
	
	/*
	@GetMapping("search.qna")
	public String search(String condition,
					     String keyword,
					     Model model) {
		
		log.info("검색조건 : {}", condition);
		log.info("검색키워드 : {}", keyword);
	}
	*/
	
	@GetMapping("detail.qna")
	public ModelAndView detail(int qnaNo, ModelAndView mv) {
		
		mv.addObject("question", qnaService.findById(qnaNo))
		  .setViewName("qna/qna-detail");
		
		return mv;
	}
	
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
			
			session.setAttribute("alert", "문의완료!");
			return "redirect:questionList";
			
		} else {
			
			model.addAttribute("alert", "문의실패!");
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
	
	@PostMapping("updateForm.question")
	public ModelAndView updateForm(ModelAndView mv, int qnaNo) {
		
		mv.addObject("question", qnaService.findById(qnaNo)).setViewName("qna/question-update");
		
		return mv;
	}
	
	@PostMapping("update.question")
	public String updateQuestion(Question question,
						 		 MultipartFile reUpfile,
						 		 HttpSession session) {
		
		if(!reUpfile.getOriginalFilename().equals("")) {
			question.setQuestionOriginname(reUpfile.getOriginalFilename());
			question.setQuestionChangename(saveFile(reUpfile, session));
		}
		
		if(qnaService.updateQuestion(question) > 0) {
			
			session.setAttribute("alert", "문의수정완료!");
			return "redirect:qna-detail?qnaNo=" + question.getQnaNo();
			
		} else {
			
			session.setAttribute("alert", "문의수정실패!");
			return "redirect:qna-detail?qnaNo=" + question.getQnaNo();
		}
	}
	
	@PostMapping("delete.qna")
	public String deleteQna(int qnaNo,
							String filePath,
							HttpSession session,
							Model model) {
		
		if(qnaService.deleteQna(qnaNo) > 0) {
			
			if(!"".equals(filePath)) {
				
				new File(session.getServletContext().getRealPath(filePath)).delete();
				
			}
			
			session.setAttribute("alert", "문의삭제완료!");
			
			return "redirect:questionList";
			
		} else {
			
			model.addAttribute("alert", "문의삭제실패!");
			return "redirect:questionList";
		}
	}
	
	@PostMapping
	public String deleteFile(int qnaNo,
							 String filePath,
							 HttpSession session,
							 Model model) {
		
		new File(session.getServletContext().getRealPath(filePath)).delete();
		
		return "";
	}
}
