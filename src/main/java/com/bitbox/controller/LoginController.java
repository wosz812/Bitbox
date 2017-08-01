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

	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
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

	@RequestMapping(value = "/login", method = { RequestMethod.GET, RequestMethod.POST })
	public String login(HttpSession session, @RequestParam("s_id") String s_id, @RequestParam("s_pw") String s_pw,
			Model model) {
		String url = "";
		// StudentDTO student = new StudentDTO();
		List<GroupDTO> groupList = null;
		// id 조회
		boolean check_id = service.idCheck(s_id);
		if (check_id) {
			// id로 encodedPw 조회
			String encodedPw = service.passwordCheck(s_id);
			// s_pw 가 받아온 값 --입력값 비교
			boolean flag = bitboxSecurity.matches(s_pw, encodedPw);
			if (flag) {
				// StudentDTO ss = (StudentDTO)
				// SecurityContextHolder.getContext().getAuthentication().getPrincipal();
				// login 성공
				// session / groupList
				StudentDTO sdto = service.login(s_id);
				groupList = service.getGroupList(sdto.getS_id());
				// session담기
				session.setAttribute("groupList", groupList);
				session.setAttribute("id", sdto.getS_id());
				session.setAttribute("code", sdto.getS_class_code());
				session.setAttribute("img", sdto.getS_uuid_img());
				UsernamePasswordAuthenticationToken token = new UsernamePasswordAuthenticationToken(s_id, "",
						AuthorityUtils.NO_AUTHORITIES);
				SecurityContextHolder.getContext().setAuthentication(token);
				url = "redirect:/bitbox/home";
			} else {
				// login 실패(pw 오류)
				url = "redirect:/login/?check=1&logID=" + s_id;
			}
		} else {
			// login 실패(id 오류)
			url = "redirect:/login/?check=2";
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