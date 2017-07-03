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

import com.bitbox.dto.PMemoDTO;
import com.bitbox.service.IBitboxService;

@Controller
@RequestMapping(value = "/memo")
public class MemoController {
	
	@Autowired//injet는 불가능
	IBitboxService service;

	@RequestMapping(value = "/registMemo", method = RequestMethod.POST)
	public String addMemo(PMemoDTO dto, HttpSession session) {
		String url = "redirect:/memo/memoView";
		// System.out.println(dto.toString());
		dto.setS_id((String) session.getAttribute("id"));
		boolean flag = service.registMemo(dto);
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));

		return url;
	}

	@RequestMapping(value = "/memoView", method = { RequestMethod.GET, RequestMethod.POST })
	public String memolist(HttpSession session, Model model,
			@RequestParam(value = "page", defaultValue = "0") int page) {
		String url = "/bitbox/memo";
		List<PMemoDTO> memoList = service.getMemoList((String) session.getAttribute("id"),page);// id가
																							// 들어가야함
		// 페이지 추가
		ArrayList<String> pageList = service.getPageList(page, (String) session.getAttribute("id"));
		model.addAttribute("memoList", memoList);
		model.addAttribute("pageList", pageList);
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		return url;
	}
}
