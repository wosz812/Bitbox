package com.bitbox.dto;

import java.util.Date;

public class PMemoDTO {
	private int m_seq;
	private String m_title;
	private String m_content;
	private String s_id;

	public int getM_seq() {
		return m_seq;
	}

	public void setM_seq(int m_seq) {
		this.m_seq = m_seq;
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

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	@Override
	public String toString() {
		return "m_seq=" + m_seq + ", m_title=" + m_title + ", m_content=" + m_content + ", s_id=" + s_id;
	}

}
