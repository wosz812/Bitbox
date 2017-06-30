package com.bitbox.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.bitbox.dto.StudentDTO;
import com.bitbox.service.IBitboxService;

@Controller
@RequestMapping(value = "/mail")
public class MailController {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private IBitboxService service;

	@RequestMapping(value = "/sendMail", method = { RequestMethod.GET, RequestMethod.POST })
	public String sendMail(StudentDTO dto, Model model, @RequestParam("type") int type) {
		String url = "/login/searchInfo";

		StudentDTO student = service.searchInfo(dto, type);
		String info = "";
		if (student != null) {
			SimpleMailMessage message = new SimpleMailMessage();
			message.setFrom("Hello");
			message.setTo(student.getS_email());
			message.setSubject("BitBox에서 소중한 회원님의 정보를 알려드립니다.");// 제목
			if (type == 0) {
				message.setText(student.getS_name() + " 님의 ID는 < " + student.getS_id() + " > 입니다.");// 내용
			} else {
				message.setText(student.getS_name() + " 님의 PW는 < " + student.getS_pw() + " > 입니다.");// 내용
			}
			mailSender.send(message);
			info = "요청하신 정보를 < " + student.getS_email() + " > 로 보냈으니 확인부탁드립니다.";
		} else {
			info = "입력한 정보가 알맞지 않습니다.";
		}
		model.addAttribute("info", info);
		return url;
	}

}
