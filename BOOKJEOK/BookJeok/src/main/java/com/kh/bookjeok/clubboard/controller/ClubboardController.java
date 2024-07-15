package com.kh.bookjeok.clubboard.controller;

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

import com.kh.bookjeok.clubboard.model.service.ClubboardService;
import com.kh.bookjeok.clubboard.model.vo.Clubboard;
import com.kh.bookjeok.common.model.FileUploadService;
import com.kh.bookjeok.common.template.PageInfo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ClubboardController {
	
	private final ClubboardService clubboardService;
	private final FileUploadService fileUploadService;
	
	@GetMapping("list.clubboard")
	public String list(@RequestParam(value="page", defaultValue="1") int page,
			   		   Model model,
			           HttpSession session) {
		
		int listCount = clubboardService.clubboardCount();
		//listCount, currentPage, pageLimit, boardLimit
		PageInfo pageInfo = PageInfo.getPageInfo(listCount, page, 5, 8);
		
		Map<String, Integer> map = new HashMap();
		
		map.put("startValue", pageInfo.getStartValue());
		map.put("endValue", pageInfo.getEndValue());
		
		List<Clubboard> totalClubboard = clubboardService.findAllClubboard(map);
		List<Clubboard> statusClubboard = clubboardService.findByClubStatus(map);
		
		model.addAttribute("totalClubboard", totalClubboard);
		model.addAttribute("statusClubboard", statusClubboard);
		model.addAttribute("pageInfo", pageInfo);
		
		return "clubboard/clubboard-list";
	}
	
	@GetMapping("insertForm.clubboard")
	public String insertForm() {
		return "clubboard/clubboard-insert";
	}
	
	@PostMapping("insert.clubboard")
	public String insertClubboard(Clubboard clubboard,
								  Model model,
								  HttpSession session,
								  MultipartFile upFile) {
		
		if(!upFile.getOriginalFilename().equals("")) {
			
			clubboard.setClubboardOriginname(upFile.getOriginalFilename());
			clubboard.setClubboardChangename(fileUploadService.saveFile(upFile, session));
			
		} 
		
		if(clubboardService.insertClubboard(clubboard) > 0) {
			
			session.setAttribute("alert", "작성완료!");
			return "redirect:list.clubboard";
			
		} else {
			
			model.addAttribute("alert", "작성실패!");
			return "redirect:list.clubboard";
		}
		
	}

}
