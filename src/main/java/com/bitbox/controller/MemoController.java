package com.bitbox.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitbox.dto.PMemoDTO;
import com.bitbox.service.IBitboxService;

@Controller
@RequestMapping(value = "/memo")
public class MemoController {

	@Autowired
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
	public String memolist(HttpSession session, Model model) {
		String url = "/bitbox/memo";
		List<PMemoDTO> memoList = service.getMemoList();
		model.addAttribute("memoList", memoList);
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		return url;
	}
}
