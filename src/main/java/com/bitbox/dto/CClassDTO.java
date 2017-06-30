package com.bitbox.dto;

import oracle.sql.DATE;

public class CClassDTO {
	private int c_seq;
	private int class_code;
	private String sub_name;
	private DATE start_date;
	private DATE end_date;

	public int getC_seq() {
		return c_seq;
	}

	public void setC_seq(int c_seq) {
		this.c_seq = c_seq;
	}

	public int getClass_code() {
		return class_code;
	}

	public void setClass_code(int class_code) {
		this.class_code = class_code;
	}

	public String getSub_name() {
		return sub_name;
	}

	public void setSub_name(String sub_name) {
		this.sub_name = sub_name;
	}

	public DATE getStart_date() {
		return start_date;
	}

	public void setStart_date(DATE start_date) {
		this.start_date = start_date;
	}

	public DATE getEnd_date() {
		return end_date;
	}

	public void setEnd_date(DATE end_date) {
		this.end_date = end_date;
	}

}
