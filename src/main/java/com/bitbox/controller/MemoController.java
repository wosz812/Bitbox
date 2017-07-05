package com.bitbox.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitbox.dto.GMemoDTO;
import com.bitbox.dto.PMemoDTO;
import com.bitbox.service.IBitboxService;

@Controller
@RequestMapping(value = "/memo")
public class MemoController {
	
	@Autowired//injet는 불가능
	IBitboxService service;

	@RequestMapping(value = "/registMemo", method = RequestMethod.POST)
	public String addMemo(PMemoDTO pdto, GMemoDTO gdto, HttpSession session , 
			@RequestParam(value="group_seq", defaultValue="0") int group_seq) {
		
		String url = "";
		System.out.println("seq : "+group_seq);
		if(group_seq==0){
			url = "redirect:/memo/pMemo?group_seq="+group_seq;
			// System.out.println(dto.toString());
			pdto.setS_id((String) session.getAttribute("id"));
			boolean flag = service.registPMemo(pdto);
			session.setAttribute("id", session.getAttribute("id"));
			session.setAttribute("code", session.getAttribute("code"));
		}else{
			url = "redirect:/memo/gMemo?group_seq="+group_seq;
			// System.out.println(dto.toString());
			gdto.setGroup_seq(group_seq);
			boolean flag = service.registGMemo(gdto);
			session.setAttribute("id", session.getAttribute("id"));
			session.setAttribute("code", session.getAttribute("code"));
		}
		
		return url;
	}

	@RequestMapping(value = "/pMemo", method = { RequestMethod.GET, RequestMethod.POST })
	public String pMemolist(HttpSession session, Model model,
			@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "group_seq") int group_seq) {
		String url = "/bitbox/memo";
		List<PMemoDTO> memoList = service.getPMemoList((String) session.getAttribute("id"),page);// id가
																							// 들어가야함
		// 페이지 추가
		ArrayList<String> pageList = service.getPageList(page, (String) session.getAttribute("id"));
		model.addAttribute("memoList", memoList);
		model.addAttribute("pageList", pageList);
		model.addAttribute("group_seq",group_seq);
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		return url;
	}
	@RequestMapping(value = "/gMemo", method = { RequestMethod.GET, RequestMethod.POST })
	public String gMemolist(HttpSession session, Model model,
			@RequestParam(value = "page", defaultValue = "0") int page,
			@RequestParam(value = "group_seq", defaultValue = "0") int group_seq) {
		String url = "/bitbox/memo";
		List<GMemoDTO> memoList = service.getGMemoList(group_seq,page);// id가
		System.out.println(group_seq);																					// 들어가야함
		// 페이지 추가
		ArrayList<String> pageList = service.getGPageList(page, group_seq);
		model.addAttribute("memoList", memoList);
		model.addAttribute("pageList", pageList);
		model.addAttribute("group_seq",group_seq);
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		return url;
	}
}
