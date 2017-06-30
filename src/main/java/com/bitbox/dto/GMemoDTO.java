package com.bitbox.dto;

public class GMemoDTO {
	private int gm_seq;
	private String m_title;
	private String m_context;
	private int group_seq;

	public int getGm_seq() {
		return gm_seq;
	}

	public void setGm_seq(int gm_seq) {
		this.gm_seq = gm_seq;
	}

	public String getM_title() {
		return m_title;
	}

	public void setM_title(String m_title) {
		this.m_title = m_title;
	}

	public String getM_context() {
		return m_context;
	}

	public void setM_context(String m_context) {
		this.m_context = m_context;
	}

	public int getGroup_seq() {
		return group_seq;
	}

	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}

	@Override
	public String toString() {
		return "GMemoDTO [gm_seq=" + gm_seq + ", m_title=" + m_title + ", m_context=" + m_context + ", group_seq="
				+ group_seq + "]";
	}

}
