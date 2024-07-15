package com.kh.bookjeok.notice.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kh.bookjeok.common.template.PageInfo;
import com.kh.bookjeok.notice.model.service.NoticeService;
import com.kh.bookjeok.notice.model.vo.Notice;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class NoticeController {
	
	   private final NoticeService noticeService;

	   
	   @GetMapping("noticeList")
	   public String forwarding(@RequestParam(value="page", defaultValue="1") int page, Model model) {
	      

	      int listCount;      // 현재 일반게시판의 게시글 총 개수 => BOARD테이블로부터 SELECT COUNT(*) 활용해서 조회
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
	   
}
