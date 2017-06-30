package com.bitbox.dto;

public class StudentDTO {
	private String s_id;
	private int s_seq;
	private String s_pw;
	private String s_email;
	private String s_name;
	private int s_phone;
	private int s_class_code;	
	
	
	@Override
	public String toString() {
		return "StudentDTO [s_id=" + s_id + ", s_seq=" + s_seq + ", s_pw=" + s_pw + ", s_email=" + s_email
				+ ", s_name=" + s_name + ", s_phone=" + s_phone + ", s_class_code=" + s_class_code + "]";
	}
	public String getS_email() {
		return s_email;
	}
	public void setS_email(String s_email) {
		this.s_email = s_email;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public int getS_seq() {
		return s_seq;
	}
	public void setS_code(int s_seq) {
		this.s_seq = s_seq;
	}
	public String getS_pw() {
		return s_pw;
	}
	public void setS_pw(String s_pw) {
		this.s_pw = s_pw;
	}
	public String getS_name() {
		return s_name;
	}
	public void setS_name(String s_name) {
		this.s_name = s_name;
	}
	public int getS_phone() {
		return s_phone;
	}
	public void setS_phone(int s_phone) {
		this.s_phone = s_phone;
	}
	public int getS_class_code() {
		return s_class_code;
	}
	public void setS_class_code(int s_class_code) {
		this.s_class_code = s_class_code;
	}
	
	
}
