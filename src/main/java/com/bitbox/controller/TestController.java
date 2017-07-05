package com.bitbox.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bitbox.dao.BitboxDAO;
import com.bitbox.dao.IBitboxDAO;
import com.bitbox.dto.GroupDTO;

@RequestMapping(value = "/test")
@Controller
public class TestController {
	
	@Autowired
	private IBitboxDAO dao;
	
	@RequestMapping(value = "/", method = { RequestMethod.POST, RequestMethod.GET })
	public String index() {
		String url = "/test";
		return url;
	}
	@RequestMapping(value = "/alarm", method = { RequestMethod.POST, RequestMethod.GET })
	public @ResponseBody int alarm() {
		int cnt=0;
		System.out.println("alarm cnt: "+cnt);
		//BitboxDAO dao=new BitboxDAO();
		cnt=dao.getPBoardCnt();
		return cnt;
	}
}
