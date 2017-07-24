package com.bitbox.controller;

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

@RequestMapping(value = "/git")

@Controller
public class GitController {
	
	@Autowired
	private OAuth2RestTemplate oauth2RestTemplate;
	@RequestMapping(value = "/gitBoard", method = RequestMethod.GET)
	public String gitBoard(@RequestParam("title") String title) {
		System.out.println("gitBoard controller: " + title);
		String url = "index";
		return url;
	}

	@RequestMapping(value = "/gitBoardView", method = RequestMethod.GET)
	public String gitBoardView(String title, Model model) {
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if (authentication instanceof OAuth2Authentication) {
			OAuth2AccessToken accessToken = oauth2RestTemplate.getAccessToken();
			
			OAuth2AuthenticationDetails details = (OAuth2AuthenticationDetails) ((OAuth2Authentication) authentication)
					.getDetails();
//			model.addAttribute("token", details.getTokenValue());
			model.addAttribute("token", accessToken.getValue());
		}
		System.out.println("gitBoard controller: " + title);
		String url = "bitbox/gitBoard";
		model.addAttribute("username", SecurityContextHolder.getContext().getAuthentication().getName());
		return url;
	}
}
