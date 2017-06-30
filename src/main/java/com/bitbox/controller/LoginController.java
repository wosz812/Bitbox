package com.bitbox.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitbox.dto.StudentDTO;
import com.bitbox.service.IBitboxService;

@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@Autowired
	private IBitboxService service;

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
	public String loginView() {
		System.out.println("LoginController-loginview");
		String url = "/login/loginForm";
		return url;
	}

	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(HttpSession session, @RequestParam("s_id") String s_id, @RequestParam("s_pw") String s_pw) {
		String url = "";
		StudentDTO student = new StudentDTO();
		student.setS_id(s_id);
		student.setS_pw(s_pw);
		StudentDTO sdto = service.loginCheck(student);
		if (sdto != null) {
			session.setAttribute("id", s_id);
			session.setAttribute("s_pw", s_pw);
			url = "redirect:/bitbox/home";
		}
		return url;
	}

	@RequestMapping(value = "/registView", method = { RequestMethod.GET, RequestMethod.POST })
	public String registView() {
		String url = "/login/loginRegistForm";
		return url;
	}

	@RequestMapping(value = "/regist", method = { RequestMethod.GET, RequestMethod.POST })
	public String regist(StudentDTO student) {
		String url = "";
		logger.info(student.toString());
		boolean flag = service.studentRegist(student);
		if (flag) {
			url = "/login/loginForm";
		}
		return url;
	}

	@RequestMapping(value = "/searchView", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchView() {
		String url = "/login/searcher";
		return url;
	}

	@RequestMapping(value = "/test", method = { RequestMethod.GET, RequestMethod.POST })
	public String test() {
		String url = "/pro/test";
		return url;
	}
}
