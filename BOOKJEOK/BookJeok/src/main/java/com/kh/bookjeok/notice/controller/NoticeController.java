package com.kh.bookjeok.notice.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
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

import com.kh.bookjeok.common.template.PageInfo;
import com.kh.bookjeok.notice.model.service.NoticeService;
import com.kh.bookjeok.notice.model.vo.Notice;
import com.kh.bookjeok.notice.model.vo.NoticeFile;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class NoticeController {
	
	   private final NoticeService noticeService;

	   
	   @GetMapping("noticeList")
	   public String forwarding(@RequestParam(value="page", defaultValue="1") int page, Model model) {
	      

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
	      

	      startPage = (currentPage - 1) / pageLimit * pageLimit + 1;

	      endPage = startPage + pageLimit - 1;

	      if(endPage > maxPage) endPage = maxPage;

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
	      
	      int startValue = (currentPage - 1) * boardLimit + 1;
	      int endValue = startValue + boardLimit - 1;
	      
	      map.put("startValue", startValue);
	      map.put("endValue", endValue);
	      
	      List<Notice> noticeList = noticeService.findAll(map);
	      /*
	      log.info("조회된 게시물의 개수 : {}", noticeList.size());
	      log.info("-----------------------------------------");
	      log.info("조회된 게시글 목록 : {}", noticeList);
	      */
	      model.addAttribute("noticeList", noticeList);
	      model.addAttribute("pageInfo", pageInfo);	      
	      
	      
	      return "notice/noticeList";
	   }

	   
	   
	   //검색기능(조건 조회 + 페이징 처리_)
	   @GetMapping("search.do")
	   public String search(String condition,
	                  String keyword,
	                  @RequestParam(value="page", defaultValue = "1") int page, Model model) {
	      
	      log.info("검색 조건 : {}",condition);
	      log.info("검색 키워드 : {}",keyword);
	      
	      // 사용자가 선택한 조건과 입력한 키워드를 가지고
	      // 페이징 처리를 끝낸 후 검색 결과를 들고 가야 함.
	      
	      // "writer", "title", "content"
	      // 사용자가 입력한 키워드 (뭐가 들어올지 모름)
	      // 이 두 개를 DB까지 가져가야 하는데
	      // => String[], List, ((Set)-제외. 사용자가 똑같은 걸 쓸 수 있다?), Map, Class
	      
	      // Map 쓰겠다(통일성 있어야 함)
	      Map<String, String> map = new HashMap();
	      map.put("condition", condition);
	      map.put("keyword", keyword);
	      
	      //검색결과 수
	      int searchCount = noticeService.searchCount(map);
	      log.info("검색 조건에 부합하는 행의 수 : {}", searchCount);
	      int currentPage = page;
	      int pageLimit = 10;
	      int boardLimit = 10;
	      
	      /* 페이징 넣는 페이지들의 공통영역으로 common/PageTemplate에 넣어둠
	      
	      int maxPage = (int)Math.ceil((double)searchCount / boardLimit);
	      int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
	      int endPage = startPage + pageLimit -1;
	      if(endPage > maxPage) endPage = maxPage;
	      
	b      PageInfo pageInfo = PageInfo.builder().pageLimit(pageLimit)
	                              .startPage(startPage)
	                              .endPage(endPage)
	                              .listCount(searchCount)
	                              .currentPage(currentPage)
	                              .maxPage(maxPage)
	                              .boardLimit(boardLimit)
	                              .build();
	                              
	      */         
	      PageInfo pageInfo = PageTemplate.getPageInfo(searchCount,
	                                        currentPage,
	                                        pageLimit,
	                                        boardLimit);
	      
	      
	      // MyBatis에서 제공하는 >>>RowBounds()<<<
	      // offset, limit
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
	      
	      model.addAttribute("list", noticeList);
	      model.addAttribute("pageInfo", pageInfo);
	      model.addAttribute("keyword", keyword);
	      model.addAttribute("condition", condition);
	      
	      return "notice/noticeList";
	   }
	   
	   @GetMapping("noticeForm.do")
	   public String noticeFormForwording() {
	      
	      return "notice/noticeInsert";
	   }
	   
	   @PostMapping("insertForm.do")
	   public String insert(NoticeFile noticeFile, MultipartFile upfile, HttpSession session, Model model) {   //MultipartFile[] 여러 개의 파일이 배열로 한번에 들어옴
	      
	      
	      
//	      log.info("게시글정보 : {}", notice);
//	      log.info("파일정보 : {}", upfile);
	      
//	      첨부파일 존재 o / 존재 x
//	      Multipart객체는 무조건 생성!!!
//	      => fileName 필드에 원본명이 존재하는가 / 없는가
//	      전달된 파일이 존재할 경우 => 파일 업로드!!
	      
	      if(!upfile.getOriginalFilename().equals("")) {
	         
	         //   KH_년월일시분초_랜덤값.확장자
	/*
	         String originName = upfile.getOriginalFilename();
	         
	         String ext = originName.substring(originName.lastIndexOf('.'));
	         //"abc.ddd.txt"
	         
	         //math * 숫자는 범위이고 뒤에 + 정수는 시작값 소수점을 버리기 위해 int로 형변환
	         int num =(int)(Math.random() * 900) + 100;
	         
	                  // 0.0 ~ 0.99999999999999999
	                  // 0.0 ~ 99.999999999999999
	                  // 0 ~ 99
	                  // 1 ~ 100
	                  // 10 ~ 109
	                  // 100 ~ 199
	         
	         //log.info("currentTime : {}", new Date());
	         
	         String currentTime= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());         
	         
	         String savePath = session.getServletContext().getRealPath("/resources/uploadFiles/");
	         
	         String changeName = "KH_" + currentTime + "_" + num + ext;
	         
	         try {

	            upfile.transferTo(new File(savePath + changeName));
	            
	         } catch (IllegalStateException e) {
	            e.printStackTrace();
	         } catch (IOException e) {
	            e.printStackTrace();
	         }
	*/
	         // 첨부파일이 존재한다.
	         // 1. 업로드 완료
	         // 2. notice객체에 originName + chageName
	         noticeFile.setNoticeOriginName(upfile.getOriginalFilename());
	         noticeFile.setNoticeChangeName(saveFile(upfile, session));
	      }
	      
	      
	      // 첨부파일이 존재하지 않을 경우 notice : 제목 / 내용 /작성자
	      // 첨부파일이 존재할 경우 notice : 제목 / 내용 /작성자
	      
	      if(noticeService.insert(notice) > 0) {
	         
	         session.setAttribute("alertMsg", "게시글 작성 성공~");
	         
	         // 무조건 리다이렉트 해야함!!!!!
	         
	         return "redirect:noticeList";
	      } else {
	         
	         model.addAttribute("errorMsg", "게시글 작성 실패....");
	         return "common/errorPage";
	      }
	      
	      // 어쩌고 저쩌고 DB가야한다
	      
//	      return "redirect:/noticeForm.do";
	      
	      // 40분 이번 주 업무일지작성 Slack DM으로 제출
	      
	      // 과제겸 숙제 list.jsp 이전 / 다음 페이지 버튼 완성 해오기
	      // Notice테이블을 이용하여 공지사항 전체 목록조회 / 공지사항 작성 기능 완성해오기
	   }
	   

	   // localhost/spring/notice-detail?noticeNo=???
	   @GetMapping("notice-detail")
	   public ModelAndView findBynoticeNo(int noticeNo,
			   							 ModelAndView mv) {
		   
		   // int abc = Integer.parseInt("123");	//강제형변환이 아니라,,, parsing이다?????
		   
		   // Object obj = 123;
		   // 참조자료형 = 기본자료형 (대입 중임?? X -> 불가능)
		   // 참조자료형에 대입되는 건 기본자료형이 아니라, 기본자료형이 저장되는 위치의 >>>주소<<<임
		   
		   // 1. 데이터 가공 --> 한 개라서 할 게 없네
		   // 2. 서비스 호출
		   if(noticeService.increaseCount(noticeNo) > 0) {	//count수 증가 성공 시
			   // 3. 응답화면 지정
			   mv.addObject("notice", noticeService.findById(noticeNo))
			   .setViewName("notice/noticeDetail");
			   
		   } else {
			   mv.addObject("errMsg", "게시글 상세조회에 실패했습니다.").setViewName("common/errorPage");
		   }
		   return mv;
	   }
	   
	   /*
	    * deleteById : Client(게시글작성자)에게 정수형의 noticeNo(BOARD테이블의 PK)를 전달받아서 BOARD테이블의 존재하는 STATUS컬럼의 값을 'N'으로 갱신
	    * 
	    * @param boardNo : 각 행을 식별하기 위한 PK
	    * 
	    * @return : 반환된 View의 논리적인 경로
	    * 
	    * ++
	    * -- 발생오류 & 해결메시지 --
	    */
	   @PostMapping("noticeDelete.do")
	   public String deleteById(int noticeNo,
			   					String filePath,
			   					HttpSession session,
			   					Model model) {
		   
		   if(noticeService.delete(noticeNo) > 0) {
			   
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
	   
	   @PostMapping("noticeUpdateForm.do")
	   public ModelAndView updateForm(ModelAndView mv, int noticeNo) {
		   
		   mv.addObject("notice", noticeService.findById(noticeNo))
		   	.setViewName("notice/noticeEdit");
		   return mv;
	   }
	   
	   @PostMapping("notice-update.do")
	   public String update(Notice notice,
			   				MultipartFile reUpFile,
			   				HttpSession session) {
		   
		   // DB가서 Notice 테이블에 UPDATE
		   
		   // Board board
		   /*
		    * -> boardTitle, boardContent
		    * -> boardWriter, boardNo (안 바꿈. update와 무관)
		    * 
		    * + File
		    * 
		    * 1. 기존 첨부파일 X, 새로운 첨부파일 X => 그렇구나
		    * 
		    * 2. 기존 첨부파일 O, 새로운 첨부파일 X => origin : 기존 첨부파일 이름, change : 기존 첨부파일 경로
		    * 
		    * 3. 기존 첨부파일 X, 새로운 첨부파일 O => origin : 새로운 첨부파일 이름, change : 새로운 첨부파일 경로
		    * 
		    * 4. 기존 첨부파일 O, 새로운 첨부파일 O => origin : 새로운 첨부파일 이름, change :  새로운 첨부파일 경로
		    */
		   
		   // => 새로운 첨부파일이 존재하는가? -> reUpFile의 새로운 경로를 담아줘야 함.
		   if(!reUpFile.getOriginalFilename().equals("")) {	//새로 올린 파일의 원래파일명이 빈문자열과 같지 않다면 = 기존 파일이 존재한다면
			   
			   notice.setOriginName(reUpFile.getOriginalFilename());
			   notice.setChangeName(saveFile(reUpFile, session));
		   }
		   
		   if(noticeService.update(notice) > 0) {
			   
			   session.setAttribute("alertMsg", "수정 완료");
			   return "redirect:notice-detail?noticeNo="+notice.getNoticeNo();
			   
		   } else {
			   
			   session.setAttribute("errorMsg", "수정 실패");
			   return "common/errorPage";
		   }
	   }

	// changeName 생성 메서드 만들기
	/*   public String saveFile(MultipartFile upfile, HttpSession session) {
		   String originName = upfile.getOriginalFilename();
	       
	       String ext = originName.substring(originName.lastIndexOf('.'));
	       //"abc.ddd.txt"
	       
	       //math * 숫자는 범위이고 뒤에 + 정수는 시작값 소수점을 버리기 위해 int로 형변환
	       int num =(int)(Math.random() * 900) + 100;
	       
	       String currentTime= new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());         
	       
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
	    }*/
	   


	}
	   
	   
	   
	   

	   
	   
	   
	   

