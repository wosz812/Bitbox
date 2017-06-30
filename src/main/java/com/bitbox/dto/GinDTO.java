package com.bitbox.dto;

import oracle.sql.DATE;

public class GinDTO {
	private int gin_seq;
	private int group_seq;
	private String s_id;
	private DATE g_date;

	public GinDTO() {

	}

	public GinDTO(int group_seq, String s_id) {
		this.group_seq = group_seq;
		this.s_id = s_id;
	}

	public int getGin_seq() {
		return gin_seq;
	}

	public void setGin_seq(int gin_seq) {
		this.gin_seq = gin_seq;
	}

	public int getGroup_seq() {
		return group_seq;
	}

	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	public DATE getG_date() {
		return g_date;
	}

	public void setG_date(DATE g_date) {
		this.g_date = g_date;
	}

	@Override
	public String toString() {
		return "GinDTO [gin_seq=" + gin_seq + ", group_seq=" + group_seq + ", s_id=" + s_id + ", g_date=" + g_date
				+ "]";
	}

	
}
