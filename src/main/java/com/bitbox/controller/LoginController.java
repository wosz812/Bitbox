package com.bitbox.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.authority.AuthorityUtils;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitbox.dto.GroupDTO;
import com.bitbox.dto.StudentDTO;
import com.bitbox.service.IBitboxService;
import com.bitbox.service.SecurityService;

@Controller
@RequestMapping(value = "/login")
public class LoginController {

	@Autowired
	private IBitboxService service;
	@Autowired
	private SecurityService bitboxSecurity = new SecurityService(256);

	private static final Logger logger = LoggerFactory.getLogger(LoginController.class);

	@RequestMapping(method = { RequestMethod.GET })
	public String loginView(@RequestParam(value = "logID", defaultValue = "") String logID,
			@RequestParam(value = "check", defaultValue = "0") int check, Model model) {
		String url = "/login/loginForm";
		if (check == 1) {
			String different_pw = "비밀번호가 맞지 않습니다.";
			model.addAttribute("different", different_pw);
			model.addAttribute("logID", logID);
		} else if (check == 2) {
			String different_id = "존재하지 않는 아이디입니다.";
			model.addAttribute("different", different_id);
		}
		return url;
	}

	@RequestMapping(value = "/registView", method = { RequestMethod.GET, RequestMethod.POST })
	public String registView() {
		String url = "/login/loginRegistForm";
		return url;
	}

	@RequestMapping(value = "/regist", method = { RequestMethod.GET, RequestMethod.POST })
	public String regist(StudentDTO student, HttpServletResponse response) {
		String url = "";
		logger.info(student.toString());
		/////// **password encoding(암호화)**///////
		bitboxSecurity.setSalt(null);
		String encodedPw = bitboxSecurity.encode(student.getS_pw());
		student.setS_pw(encodedPw);
		//////////// default img///////////////////
		student.setS_img("default.png");
		student.setS_uuid_img("default.png");
		/////////////////////////////////////////
		boolean flag = service.studentRegist(student);
		if (flag) {
			try {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('회원가입을 축하드립니다');</script>");
				out.flush();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

			url = "/login/loginForm";
		}
		return url;
	}

	@RequestMapping(value = "/searchView", method = { RequestMethod.GET, RequestMethod.POST })
	public String searchView() {
		String url = "/login/searcher";
		return url;
	}
}