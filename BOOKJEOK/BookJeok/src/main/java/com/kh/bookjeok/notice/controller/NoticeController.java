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
	      

	      int listCount;      // 현재 일반게시판의 게시글 총 개수 => notice테이블로부터 SELECT COUNT(*) 활용해서 조회
	      int currentPage;   // 현재 페이지(사용자가 요청한 페이지) => 앞에서 넘길 것
	      int pageLimit;      // 페이지 하단에 보일 페이징바의 최대 개수 => 10개로 고정
	      int boardLimit;      // 한 페이지에 보여질 게시글의 최대 개수 => 10개로 고정
	      
	      int maxPage;      // 가장 마지막 페이지가 몇 번 페이지인지(총 페이지의 개수)
	      int startPage;      // 페이지 하단에 보여질 페이징바의 시작 수
	      int endPage;      // 페이지 하단에 보여질 페이징바의 끝 수
	      
	      // * listCount : 총 게시글 수
	      listCount = noticeService.noticeCount();
	      
	      // currentPage : 현재 페이지(사용자가 요청한 페이지)
	      currentPage = page;
	      
	      log.info("게시글의 총 개수 : {}, 현재 요청 페이지 : {}", listCount, currentPage);
	      
	      // * pageLimit = 10; : 페이징바의 최대 개수
	      pageLimit = 10;
	      
	      // * boardLimit = 한 페이지에 보여질 게시글의 최대 개수
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
	      
	      
	      //System.out.println("noticeList.."+noticeList.size());
	      //log.info("조회된 게시물의 개수 : {}", noticeList.size());
	      log.info("-----------------------------------------");
	      //log.info("조회된 게시글 목록 : {}", noticeList);

	      model.addAttribute("noticeList", noticeList);
	      
	      model.addAttribute("pageInfo", pageInfo);	      
	      
	      //List<Notice> noticeList = noticeService.noticeList();
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
	      
	      
	      //검색결과 수
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
	      
	      
	      // MyBatis에서는 페이징 처리를 위해 RowsBounds라는 클래스를 제공
	      // * offset, limit
	      
	      /*
	       * boardLimit가 3일 경우       건너뛸 숫자(offset)
	       * 
	       *  currentPage : 1 -> 1~3 ==> 0
	       *  currentPage : 2 -> 4~6 ==> 3
	       *  currentPage : 3 -> 7~9 ==> 6
	       *  
	       *  (currentPage() -1) * boardLimit()
	       */
	      
	      List<Notice> noticeList = noticeService.findByConditionAndKeyword(map, rowBounds);
	      
	      model.addAttribute("keyword", keyword);
		  model.addAttribute("pageInfo", pageInfo);
	      model.addAttribute("condition", condition);
	      model.addAttribute("noticeList", noticeList);
	      
	      return "notice/listNotice";
	   }

		@GetMapping("editFormNotice")
		public String insertForm() {
			return "notice/noticeEdit";
		}
	  
	   @PostMapping("insertNotice")
	   public String insertNotice(Notice notice, MultipartFile upfile, HttpSession session, Model model) {   //MultipartFile[] 여러 개의 파일이 배열로 한번에 들어옴
	      
	      
	      if(!upfile.getOriginalFilename().equals("")) {
	         
	         notice.setNoticeTextOriginName(upfile.getOriginalFilename());
	         notice.setNoticeTextChangeName(saveFile(upfile, session));
	      }
	      
	      
	      // 첨부파일이 존재하지 않을 경우 notice : 제목 / 내용 /작성자
	      // 첨부파일이 존재할 경우 notice : 제목 / 내용 /작성자
	      
	      if(noticeService.insertNotice(notice) > 0) {
	         
	         session.setAttribute("alertMsg", "게시글 작성 성공~");
	         
	         // 무조건 리다이렉트 해야함!!!!!
	         
	         return "redirect:noticeList";
	      } else {
	         
	         model.addAttribute("errorMsg", "게시글 작성 실패....");
	         return "common/errorPage";
	      }
	      

	      
//	      return "redirect:/noticeForm.do";
	      

	      

	   }
	   


	   @GetMapping("noticeDetail")
	   public ModelAndView findBynoticeNo(int noticeNo,
			   							 ModelAndView mv) {
		   

		   if(noticeService.increaseNoticeVisited(noticeNo) > 0) {	//count수 증가 성공 시

			   mv.addObject("notice", noticeService.findById(noticeNo))
			   .setViewName("notice/noticeDetail");
			   
		   } else {
			   mv.addObject("errMsg", "게시글 상세조회에 실패했습니다.").setViewName("common/errorPage");
		   }
		   return mv;
	   }
	   
	   
	   
	   
	   

	   @PostMapping("noticeDetail")
	   public String deleteById(int noticeNo,
			   					String filePath,
			   					HttpSession session,
			   					Model model) {
		   
		   if(noticeService.deleteNotice(noticeNo) > 0) {
			   
			   if(!"".equals(filePath)) {		//filePath는 null일 가능성 O. 따라서 filePath를 기준으로 잡으면 오타 발생 시 nullPointerException이 발생할 가능성이 있다. 따라서 빈 문자열 ""를 기준으로 .equals 비교를 한다면 nullPointerException 오류 발생은 막을 수 있다.
				   	new File(session.getServletContext().getRealPath(filePath)).delete();
			   }
			   
			   session.setAttribute("alertMsg", "게시물 삭제 성공");
			   return "redirect:noticeList";
			   
		   } else {
			   model.addAttribute("errorMsg", "게시글 삭제 실패");
			   return "common/errorPage";
		   }
	   }
	   
	   
		@GetMapping("insertForm")
		public String updateForm() {
			return "notice/noticeInsert";
		}
	   
	   
	   /*@GetMapping("insertForm")
	   public ModelAndView updateForm(ModelAndView mv, int noticeNo) {
		   
		   mv.addObject("notice", noticeService.findById(noticeNo))
		   	.setViewName("notice/noticeInsert");
		   return mv;
	   }*/
	   
		   @PostMapping("noticeInsert")
		   public String insert(Notice notice, 
				                MultipartFile upfile, 
				                HttpSession session, 
				                Model model) {   //MultipartFile[] 여러 개의 파일이 배열로 한번에 들어옴
		      

		      if(!upfile.getOriginalFilename().equals("")) {

		    	 notice.setNoticeTextOriginName(upfile.getOriginalFilename());
		    	 notice.setNoticeTextChangeName(saveFile(upfile, session));
		    	 notice.setNoticeImgOriginName(upfile.getOriginalFilename());
		    	 notice.setNoticeImgChangeName(saveFile(upfile, session));
		      }

		      if(noticeService.insertNotice(notice) > 0) {
		         
		         session.setAttribute("alertMsg", "게시글 작성 성공~");

		         return "redirect:noticeList";
		      } else {
		         
		         model.addAttribute("errorMsg", "게시글 작성 실패....");
		         return "common/errorPage";
		      }

		   }
		   
	   
	   @PostMapping("noticeEdit")
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
	   

	   



