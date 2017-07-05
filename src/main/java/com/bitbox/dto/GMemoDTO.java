package com.bitbox.dto;

public class GMemoDTO {
	private int gm_seq;
	private String m_title;
	private String m_content;
	private int group_seq;
	private int m_seq;

	public int getM_seq() {
		return m_seq;
	}

	public void setM_seq(int m_seq) {
		this.m_seq = m_seq;
		this.gm_seq = m_seq;
	}

	public int getGm_seq() {
		return gm_seq;
	}

	public void setGm_seq(int gm_seq) {
		this.gm_seq = gm_seq;
		this.m_seq = gm_seq;
	}

	public String getM_title() {
		return m_title;
	}

	public void setM_title(String m_title) {
		this.m_title = m_title;
	}

	public String getM_content() {
		return m_content;
	}

	public void setM_content(String m_content) {
		this.m_content = m_content;
	}

	public int getGroup_seq() {
		return group_seq;
	}

	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}

	@Override
	public String toString() {
		return "GMemoDTO [gm_seq=" + gm_seq + ", m_title=" + m_title + ", m_content=" + m_content + ", group_seq="
				+ group_seq + "]";
	}

}
