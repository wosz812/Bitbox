package com.bitbox.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.oauth2.client.OAuth2RestTemplate;
import org.springframework.security.oauth2.common.OAuth2AccessToken;
import org.springframework.security.oauth2.provider.OAuth2Authentication;
import org.springframework.security.oauth2.provider.authentication.OAuth2AuthenticationDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitbox.dto.GroupDTO;
import com.bitbox.service.IBitboxService;

@RequestMapping(value = "/git")

@Controller
public class GitController {
	
	@Autowired
	private OAuth2RestTemplate oauth2RestTemplate;
	
	@Autowired
	private IBitboxService service;
	
	@RequestMapping(value = "/gitBoard", method = RequestMethod.GET)
	public String gitBoard(@RequestParam("title") String title,HttpSession session,@RequestParam(value="status",defaultValue="0") String val) {
		System.out.println("gitBoard controller: " + title);
		session.setAttribute("title",title);
		session.setAttribute("status",val);
		String url = "redirect:http://localhost:8080/login/github";
		return url;
	}
	

	@RequestMapping(value = "/gitBoardView", method = RequestMethod.GET)
	public String gitBoardView(String title, Model model,HttpSession session) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication instanceof OAuth2Authentication) {
			OAuth2AccessToken accessToken = oauth2RestTemplate.getAccessToken();
	
			OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) ((OAuth2Authentication) authentication)
					.getDetails();
//			model.addAttribute("token", details.getTokenValue());
			model.addAttribute("token", accessToken.getValue());
		}
		int status=Integer.parseInt((String) session.getAttribute("status"));
		String url="";
		String gtitle=(String) session.getAttribute("title");
		//master id 삽입 => repository 생성하기 위한 masterid
		if(status==1){
			String masId=SecurityContextHolder.getContext().getAuthentication().getName();
			GroupDTO gdto=new GroupDTO();
			gdto.setTitle(gtitle);
			gdto.setMaster_id(masId);
			boolean flag=service.gitMasterUpdate(gdto);
			if(flag){
				url = "bitbox/gitBoard";
			}
		}else if(status==0){ //생성된 repos에 member 초대하기
			/*GroupDTO gdto=new GroupDTO();
			gdto.setTitle(gtitle);
			GroupDTO sdto=service.selectMasId(gdto);
			String masId=sdto.getMaster_id();
			model.addAttribute("masId",masId);*/
			url = "bitbox/gitBoard";
		}
		model.addAttribute("title",session.getAttribute("title"));
		model.addAttribute("username", SecurityContextHolder.getContext().getAuthentication().getName());
		return url;
	}
}
