package com.bitbox.controller;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitbox.dto.StudentDTO;
import com.bitbox.service.IBitboxService;
import com.bitbox.service.SecurityService;

@Controller
@RequestMapping(value = "/mail")
public class MailController {

	@Autowired
	private JavaMailSender mailSender;
	@Autowired
	private SecurityService bitboxSecurity = new SecurityService(256);
	@Autowired
	private IBitboxService service;

	@RequestMapping(value = "/sendMail", method = { RequestMethod.GET, RequestMethod.POST })
	public String sendMail(StudentDTO dto, Model model, @RequestParam("type") int type) {
		String url = "/login/searchInfo";
		String info = "";
		StudentDTO student = service.searchInfo(dto, type);
		MimeMessage message = null;
		MimeMessageHelper messageHelper = null;
		try {
			if (student != null) {
				message = mailSender.createMimeMessage();
				messageHelper = new MimeMessageHelper(message, true, "UTF-8");
				messageHelper.setFrom("BITBOX");
				messageHelper.setTo(student.getS_email());
				messageHelper.setSubject("BITBOX에서 소중한 회원님의 정보를 알려드립니다.");// 제목
				if (type == 0) {
					messageHelper.setText(student.getS_name() + " 님의 ID는 < " + student.getS_id() + " > 입니다.");// 내용
				} else {
					String sendUrl = "<a href=\"http://localhost:8080/mail/changePwForm?id=" + dto.getS_id()
							+ "\">비밀번호 변경</a>";
					messageHelper.setText("아래 링크를 통해 새로운 비밀번호를 입력하시기 바랍니다.<br>" + sendUrl, true);// 내용
				}
				mailSender.send(message);
				info = "요청하신 정보를 < " + student.getS_email() + " > 로 보냈으니 확인부탁드립니다.";
			} else {
				info = "입력한 정보가 알맞지 않습니다.";
			}
		} catch (MessagingException e) {
			e.printStackTrace();
		}

		model.addAttribute("info", info);
		return url;
	}

	@RequestMapping(value = "/changePwForm", method = { RequestMethod.GET, RequestMethod.POST })
	public String changePwForm(@RequestParam("id") String id, Model model) {
		String url = "/login/changePwForm";
		model.addAttribute("id", id);
		return url;
	}

	@RequestMapping(value = "/changePW", method = { RequestMethod.GET, RequestMethod.POST })
	public String changePW(StudentDTO student, Model model) {
		String url = "/login/complete";
		String info = "비밀번호 변경에 실패하였습니다.";
		String encodedPw = bitboxSecurity.encode(student.getS_pw());
		student.setS_pw(encodedPw);
		boolean flag = service.changePw(student);
		if (flag) {
			info = "비밀번호 변경이 완료되었습니다.";
		}
		model.addAttribute("info", info);
		return url;
	}

}
