package com.bitbox.dto;

public class SubjectDateFormat {
	String subject;
	int code;
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public int getCode() {
		return code;
	}
	public void setCode(int code) {
		this.code = code;
	}
	@Override
	public String toString() {
		return "SubjectDateFormat [subject=" + subject + ", code=" + code + "]";
	}
	
}
