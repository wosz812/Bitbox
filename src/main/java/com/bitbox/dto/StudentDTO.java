package com.bitbox.dto;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class StudentDTO implements UserDetails {
	public String getGit_id() {
		return git_id;
	}
	public void setGit_id(String git_id) {
		this.git_id = git_id;
	}
	public String getGit_pw() {
		return git_pw;
	}
	public void setGit_pw(String git_pw) {
		this.git_pw = git_pw;
	}
	private String s_id;
	private String s_img;
	private String s_uuid_img;
	private int s_seq;
	private String s_pw;
	private String s_email;
	private String s_name;
	private int s_phone;
	private int s_class_code;
	private String git_id;
	private String git_pw;
	
	private List<GroupDTO> group = new ArrayList<GroupDTO>();
	
	
	
	@Override
	public String toString() {
		return "StudentDTO [s_id=" + s_id + ", s_img=" + s_img + ", s_uuid_img=" + s_uuid_img + ", s_seq=" + s_seq
				+ ", s_pw=" + s_pw + ", s_email=" + s_email + ", s_name=" + s_name + ", s_phone=" + s_phone
				+ ", s_class_code=" + s_class_code + ", git_id=" + git_id + ", git_pw=" + git_pw + ", group=" + group
				+ "]";
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
	public List<GroupDTO> getGroup() {
		return group;
	}
	public void setGroup(List<GroupDTO> group) {
		this.group = group;
	}
	
	
	public String getS_img() {
		return s_img;
	}
	public void setS_img(String s_img) {
		this.s_img = s_img;
	}
	
	
	public String getS_uuid_img() {
		return s_uuid_img;
	}
	public void setS_uuid_img(String s_uuid_img) {
		this.s_uuid_img = s_uuid_img;
	}
	@Override
	public Collection<? extends GrantedAuthority> getAuthorities() {
		return null;
	}
	@Override
	public String getPassword() {
		return this.s_pw;
	}
	@Override
	public String getUsername() {
		return this.s_id;
	}
	@Override
	public boolean isAccountNonExpired() {
		return true;
	}
	@Override
	public boolean isAccountNonLocked() {
		return true;
	}
	@Override
	public boolean isCredentialsNonExpired() {
		return true;
	}
	@Override
	public boolean isEnabled() {
		return true;
	}
	
	
}
