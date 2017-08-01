package com.bitbox.dto;

public class SubSubjectDTO {
	private int sub_subject_seq;
	private String sub;
	private String sub_name;

	public int getSub_subject_seq() {
		return sub_subject_seq;
	}

	public void setSub_subject_seq(int sub_subject_seq) {
		this.sub_subject_seq = sub_subject_seq;
	}

	public String getSub() {
		return sub;
	}

	public void setSub(String sub) {
		this.sub = sub;
	}

	public String getSub_name() {
		return sub_name;
	}

	public void setSub_name(String sub_name) {
		this.sub_name = sub_name;
	}

	@Override
	public String toString() {
		return "SubSubjectDTO [sub_subject_seq=" + sub_subject_seq + ", sub=" + sub + ", sub_name=" + sub_name + "]";
	}
	
}
