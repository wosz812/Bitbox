package com.bitbox.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.bitbox.dto.PMemoDTO;

@Controller
@RequestMapping(value = "/memo")
public class MemoController {

	@RequestMapping(value = "/registMemo", method = RequestMethod.POST)
	public String addMemo(PMemoDTO dto) {
		String url = "/memolist";
		System.out.println(dto.toString());

		url = "redirect:/memo/memoView";

		return url;
	}

	@RequestMapping(value = "/memoView", method = { RequestMethod.GET, RequestMethod.POST })
	public String memolist(HttpSession session) {
		String url = "/bitbox/memo";
		session.setAttribute("id", session.getAttribute("id"));
		session.setAttribute("code", session.getAttribute("code"));
		return url;
	}
}
