package com.kh.bookjeok.notice.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
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

import com.kh.bookjeok.common.template.PageInfo;
import com.kh.bookjeok.model.Page;
import com.kh.bookjeok.notice.model.service.NoticeService;
import com.kh.bookjeok.notice.model.vo.Notice;
//import com.kh.bookjeok.notice.model.vo.NoticeFile;
import com.kh.bookjeok.template.PageTemplate;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class NoticeController {
	
	   private final NoticeService noticeService;
	

	   @GetMapping("listNotice")
	   public String list(@RequestParam(value="page", defaultValue="1") int page, 
			   				   Model model) {
	      

	      int listCount;    
	      int currentPage; 
	      int pageLimit;    
	      int boardLimit;     
	      
	      int maxPage;     
	      int startPage;    
	      int endPage;      
	      
	      listCount = noticeService.noticeCount();
	      currentPage = page;
	      
	      log.info("게시글의 총 개수 : {}, 현재 요청 페이지 : {}", listCount, currentPage);

	      pageLimit = 10;
	      boardLimit = 10;
	      
	      maxPage = (int)Math.ceil((double)listCount / boardLimit);
	      startPage = (currentPage - 1) / boardLimit * boardLimit + 1;
	      endPage = startPage + pageLimit - 1;

	      if(endPage > maxPage) endPage = maxPage;
	      int startValue = (currentPage - 1) * boardLimit + 1;
	      int endValue = startValue + boardLimit - 1;

	      PageInfo pageInfo = PageInfo.builder()
					                  .listCount(listCount)
					                  .currentPage(currentPage)
					                  .pageLimit(pageLimit)
					                  .boardLimit(boardLimit)
					                  .maxPage(maxPage)
					                  .startPage(startPage)
					                  .endPage(endPage)
					                  .build();
	      
	      Map<String, Integer> map = new HashMap();
	      
	      map.put("startValue", startValue);
	      map.put("endValue", endValue);
	      
	      List<Notice> noticeList = noticeService.findAll(map);

	      model.addAttribute("noticeList", noticeList);
	      model.addAttribute("pageInfo", pageInfo);	      
	      model.addAttribute("noticeList", noticeList);
	      
	      return "notice/listNotice";
	   }
	   
	   
	   
	   
	   //검색기능(조건 조회 + 페이징 처리_)
	   @GetMapping("search.do")
	   public String search(String condition,
	                  		String keyword,
	                  		@RequestParam(value="page", defaultValue = "1") int page, Model model) {
	      
	      log.info("검색 조건 : {}",condition);
	      log.info("검색 키워드 : {}",keyword);
	      
	      System.out.println("검색 조건 : " + condition);
	      System.out.println("검색 키워드 : " + keyword);

	      Map<String, String> map = new HashMap();
	      map.put("condition", condition);
	      map.put("keyword", keyword);
	      
	      int searchCount = noticeService.searchCount(map);
	      log.info("검색 조건에 부합하는 행의 수 : {}", searchCount);
	      int currentPage = page;
	      int pageLimit = 10;
	      int boardLimit = 10;
	      
	      Page pageInfo = PageTemplate.getPageInfo(searchCount,
	                                        currentPage,
	                                        pageLimit,
	                                        boardLimit);
	      
	      RowBounds rowBounds = new RowBounds((currentPage - 1) * boardLimit, boardLimit);
	      List<Notice> noticeList = noticeService.findByConditionAndKeyword(map, rowBounds);
	      
	      model.addAttribute("keyword", keyword);
		  model.addAttribute("pageInfo", pageInfo);
	      model.addAttribute("condition", condition);
	      model.addAttribute("noticeList", noticeList);
	      
	      return "notice/listNotice";
	   }


	   
	   
		
		@GetMapping("insertForm")
		public String insertForm() {
			return "notice/noticeInsert";
		}
		
		

		
	  
	   @PostMapping("insertNotice")
	   public String insertNotice(Notice notice, 
			                      MultipartFile upfile, 
			                      HttpSession session, 
			                      Model model) {   //MultipartFile[] 여러 개의 파일이 배열로 한번에 들어옴
	      
	      if(!upfile.getOriginalFilename().equals("")) {  
	         notice.setNoticeTextOriginName(upfile.getOriginalFilename());
	         notice.setNoticeTextChangeName(saveFile(upfile, session));
	      }
	      
	      if(noticeService.insertNotice(notice) > 0) { 
	         session.setAttribute("alertMsg", "공지사항 작성 성공~");
	         return "redirect:listNotice";
	      } else {
	         model.addAttribute("errorMsg", "공지사항 작성 실패....");
	         return "common/errorPage";
	      }
	   }


	   
	   
	   
	 @GetMapping("noticeDetail")
	   public ModelAndView findBynoticeNo(int noticeNo,
			   							 ModelAndView mv) {
		   if(noticeService.increaseNoticeVisited(noticeNo) > 0) {	//count수 증가 성공 시
			   mv.addObject("notice", noticeService.findById(noticeNo))
			   .setViewName("notice/noticeDetail");
		   } else {
			   mv.addObject("errMsg", "공지사항 조회에 실패했습니다.").setViewName("common/errorPage");
		   }
		   return mv;
	   }
	
	   

	 
	 
	 
		@PostMapping("deleteNotice")
		 public String delete(@RequestParam("noticeNo") int noticeNo,
		                      @RequestParam(value = "filePath", required = false) String filePath,
		                      HttpSession session,
		                      Model model) {
		     
		     if (noticeService.deleteNotice(noticeNo) > 0) {
		         if (filePath != null && !"".equals(filePath)) {
		             // filePath가 null이 아니고 빈 문자열도 아닌 경우 파일 삭제
		             new File(session.getServletContext().getRealPath(filePath)).delete();
		         }
		         session.setAttribute("alertMsg", "공지사항 삭제 성공");
		         return "redirect:listNotice"; 
		     } else {
		         model.addAttribute("errorMsg", "공지사항 삭제 실패");
		         return "common/errorPage";
		     }
		 }

	   


		@GetMapping("editFormNotice")
		public ModelAndView updateForm(ModelAndView mv, int noticeNo) {
			mv.addObject("notice", noticeService.findById(noticeNo))
			  .setViewName("notice/noticeEdit");
			return mv;
		}
	   
		
		

	   @PostMapping("editNotice")
	   public String update(Notice notice,
			   				MultipartFile reUpFile,
			   				HttpSession session) {
		   

		   if(!reUpFile.getOriginalFilename().equals("")) {	  
			   notice.setNoticeTextOriginName(reUpFile.getOriginalFilename());
			   notice.setNoticeTextChangeName(saveFile(reUpFile, session));
		   }
		   
		   if(noticeService.updateNotice(notice) > 0) {
			   
			   session.setAttribute("alertMsg", "수정 완료");
			   return "redirect:noticeDetail?noticeNo="+notice.getNoticeNo();
			   
		   } else {
			   
			   session.setAttribute("errorMsg", "수정 실패");
			   return "common/errorPage";
		   }
	   }

	   
	   
	   
	// changeName 생성 메서드 만들기
	     public String saveFile(MultipartFile upfile, HttpSession session) {
		   String originName = upfile.getOriginalFilename();
	       
	       String ext = originName.substring(originName.lastIndexOf('.'));
	       //"abc.ddd.txt"
	       
	       //math * 숫자는 범위이고 뒤에 + 정수는 시작값 소수점을 버리기 위해 int로 형변환
	       int num =(int)(Math.random() * 900) + 100;
	       
	       String currentTime= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date(num));         
	       
	       String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
	       
	       String changeName = "BOOKJEOK_" + currentTime + "_" + num + ext;
	       
	       try {
	          upfile.transferTo(new File(savePath + changeName));
	       } catch (IllegalStateException e) {
	          e.printStackTrace();
	       } catch (IOException e) {
	          e.printStackTrace();
	       }
	       
	       return "resources/uploadFiles/" + changeName;
	    } 
	}
	   

	   



