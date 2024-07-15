package com.kh.bookjeok.qna.controller;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.kh.bookjeok.member.model.vo.Member;
import com.kh.bookjeok.model.Page;
import com.kh.bookjeok.qna.model.service.QnaService;
import com.kh.bookjeok.qna.model.vo.Answer;
import com.kh.bookjeok.qna.model.vo.Question;
import com.kh.bookjeok.template.PageTemplate;

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
					   Page pageInfo,
					   HttpSession session,
					   Member member) {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		
		//log.info("Received request for list.qna with page: {}", page);
		System.out.println("Received request for list.qna with page: " + page);
		
		
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
		
		pageLimit = 5;
		listLimit = 2;
		
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
		List<Answer> answer = qnaService.findAllAnswer(map);
		
		log.info("조회된 1대1 문의사항 개수 : {}", question.size());
		log.info("조회된 1대1 문의사항 목록 : {}", question);
		
		System.out.println("조회된 문의사항 개수" + question.size());
		System.out.println("조회된 문의사항 목록" + question);
		System.out.println("answer : " + answer);
		
		model.addAttribute("question", question);
		model.addAttribute("answer", answer);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("userId", userId);
		
		return "qna/qna-list";
	}
	
	
	@GetMapping("search.qna")
	public String search(String condition, 
			   			   String keyword,
			   			   @RequestParam(value="page", defaultValue="1") int page,
			   			   Model model) {
		
	    log.info("검색 조건 : {}", condition);
	    log.info("검색 키워드 : {}", keyword);
	    
	    System.out.println("검색 조건 : " + condition);
	    System.out.println("검색 키워드 : " + keyword);
	   
	    Map<String, String> map = new HashMap();
	    map.put("condition", condition);
	    map.put("keyword", keyword);
	   
	    int searchCount = qnaService.searchCount(map);
	    
	    log.info("검색 조건에 부합하는 행의 수 : {}", searchCount);
	    System.out.println("검색 조건에 부합하는 행의 수 : " + searchCount);
	    
	    int currentPage = page;
	    int pageLimit = 3;
	    int listLimit = 3;
	   
	    Page pageInfo = PageTemplate.getPageInfo(searchCount, 
		 	   								     currentPage, 
			   									 pageLimit, 
			   								     listLimit);
	   
	    RowBounds rowBounds = new RowBounds((currentPage - 1) * listLimit, listLimit);
	   
	    List<Question> question = qnaService.findByConditionAndKeyword(map, rowBounds);
	   
	    model.addAttribute("question", question);
	    model.addAttribute("pageInfo", pageInfo);
	    model.addAttribute("keyword", keyword);
	    model.addAttribute("condition", condition);
	   
	    return "qna/qna-list";
	}
	
	@GetMapping("detail.qna")
	public ModelAndView detail(int qnaNo, ModelAndView mv) {
	    Question question = qnaService.findById(qnaNo);
	    Answer answer = qnaService.findAnswerByQnaNo(qnaNo);

	    mv.addObject("question", question);
	    mv.addObject("answer", answer); // answer 객체를 뷰에 추가
	    mv.setViewName("qna/qna-detail");
	    
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
			return "redirect:list.qna";
			
		} else {
			
			model.addAttribute("alert", "문의실패!");
			return "redirect:list.qna";
		}
	}
	
	@GetMapping("updateForm.question")
	public ModelAndView updateForm(ModelAndView mv, int qnaNo) {
		
		mv.addObject("question", qnaService.findById(qnaNo)).setViewName("qna/question-update");
		
		return mv;
	}
	
	@PostMapping("update.question")
	public String updateQuestion(Question question,
						 		 MultipartFile reUpfile,
						 		 HttpSession session) {
		
		if(reUpfile != null && !reUpfile.getOriginalFilename().equals("")) {
			question.setQuestionOriginname(reUpfile.getOriginalFilename());
			question.setQuestionChangename(saveFile(reUpfile, session));
		}
		
		if(qnaService.updateQuestion(question) > 0) {
			
			session.setAttribute("alert", "문의수정완료!");
			return "redirect:detail.qna?qnaNo=" + question.getQnaNo();
			
		} else {
			
			session.setAttribute("alert", "문의수정실패!");
			return "redirect:detail.qna?qnaNo=" + question.getQnaNo();
		}
	}
	
	@GetMapping("delete.qna")
	public String deleteQna(int qnaNo,
							String filePath,
							HttpSession session,
							Model model) {
		
		if(qnaService.deleteQna(qnaNo) > 0) {
			
			if(filePath != null && !"".equals(filePath)) {
				
				new File(session.getServletContext().getRealPath(filePath)).delete();
				
			}
			
			session.setAttribute("alert", "문의삭제완료!");
			
			return "redirect:list.qna";
			
		} else {
			
			model.addAttribute("alert", "문의삭제실패!");
			return "redirect:list.qna";
		}
	}
	
	// ---------------------------------------------------------------------
	
	// 답변
	@GetMapping("insertForm.answer")
	public String insertAnswerForm() {
		return "qna/answer-insert";
	}
	
	@PostMapping("insert.answer")
	public String insertAnswer(Answer answer,
						 	   HttpSession session,
						 	   Model model,
						 	   MultipartFile upfile,
						 	   @RequestParam("qnaNo") int qnaNo) {
		
		if(!upfile.getOriginalFilename().equals("")) {
			
			answer.setAnswerOriginname(upfile.getOriginalFilename());
			answer.setAnswerChangename(saveFile(upfile, session));
		}
		
		// QnaNo 설정
	    answer.setQnaNo(qnaNo);
		
		
		if(qnaService.insertAnswer(answer) > 0) {
			
			session.setAttribute("alert", "답변완료!");
			return "redirect:detail.qna?qnaNo=" + answer.getQnaNo();
			
		} else {
			
			model.addAttribute("alert", "답변실패!");
			return "redirect:detail.qna?qnaNo=" + answer.getQnaNo();
		}
	}
	
	@GetMapping("delete.answer")
	public String deleteAnswer(int answerNo,
							   String filePath,
							   HttpSession session,
							   Model model) {
		
		if(qnaService.deleteAnswer(answerNo) > 0) {
			
			if(filePath != null && !"".equals(filePath)) {
				
				new File(session.getServletContext().getRealPath(filePath)).delete();
				
			}
			
			System.out.println("filePath : "+ filePath);
			
			session.setAttribute("alert", "답변삭제완료!");
			return "redirect:list.qna";
			
		} else {
			
			model.addAttribute("alert", "답변삭제실패!");
			return "redirect:list.qna";
		}
		
	}
	
	@GetMapping("updateForm.answer")
	public ModelAndView updateAnswerForm(ModelAndView mv, int answerNo) {
		
		mv.addObject("answer", qnaService.findByAnswerNo(answerNo))
		  .setViewName("qna/answer-update");
		
		return mv;
	}
	
	@PostMapping("update.answer")
	public String updateAnswer(Answer answer,
						 	   MultipartFile reUpfile,
						 	   HttpSession session,
						 	   int qnaNo) {
		
		if(!reUpfile.getOriginalFilename().equals("")) {
			answer.setAnswerOriginname(reUpfile.getOriginalFilename());
			answer.setAnswerChangename(saveFile(reUpfile, session));
		}
		
		if(qnaService.updateAnswer(answer) > 0) {
			
			session.setAttribute("alert", "답변수정완료!");
			return "redirect:detail.qna?qnaNo=" + answer.getQnaNo();
			
		} else {
			
			session.setAttribute("alert", "답변수정실패!");
			return "redirect:detail.qna?qnaNo=" + answer.getQnaNo();
		}
	}
	
	//---------------------------------------------------------------------
	
	// 파일 관련 컨트롤러
	
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
	
	@GetMapping("delete-file")
    public String deleteFile(@RequestParam int qnaNo, 
                             @RequestParam String filePath, 
                             HttpSession session, 
                             Model model) {

        if (new File(session.getServletContext().getRealPath(filePath)).delete()) {
            // 성공적으로 삭제되었음을 클라이언트에 전달
            model.addAttribute("fileDeleted", true);
        } else {
            // 삭제 실패 정보를 클라이언트에 전달
            model.addAttribute("fileDeleted", false);
        }

        // 다시 수정 페이지로 리다이렉트
        return "redirect:update.question?questionNo=" + qnaNo;
    }
	
}
