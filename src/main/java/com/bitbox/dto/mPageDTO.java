package com.bitbox.dto;


public class mPageDTO {
	
	private int group_seq;
	private int start;
	
	public mPageDTO(int group_seq, int start) {
		this.group_seq = group_seq;
		this.start = start;
	}
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
	
	
}
