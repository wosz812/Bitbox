package com.bitbox.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@RequestMapping(value = "/git")

@Controller
public class GitController {
	@RequestMapping(value="/gitBoard", method=RequestMethod.GET)
	public String gitBoard(@RequestParam("title") String title){
		System.out.println("gitBoard controller: "+title);
		String url ="/bitbox/gitBoard";
		return url;
	}
}
