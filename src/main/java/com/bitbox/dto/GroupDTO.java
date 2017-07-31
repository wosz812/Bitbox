package com.bitbox.dto;

public class GroupDTO {
	private int group_seq;
	private String pw;
	private String title;
	private String info;
	private String s_id;
	
	

	public int getGroup_seq() {
		return group_seq;
	}

	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	@Override
	public String toString() {
		return "GroupDTO [group_seq=" + group_seq + ", pw=" + pw + ", title=" + title + ", info=" + info + ", s_id="
				+ s_id + ", master_id=" + "]";
	}

}
