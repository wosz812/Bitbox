package com.bitbox.dto;


public class gPageDTO {
	
	private int group_seq;
	private int start;
	public int getGroup_seq() {
		return group_seq;
	}
	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public gPageDTO(int group_seq, int start) {
		super();
		this.group_seq = group_seq;
		this.start = start;
	}
	
	
	
}
