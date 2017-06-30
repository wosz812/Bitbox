package com.bitbox.dto;

import java.util.Date;

public class PMemoDTO {
	private int m_seq;
	private String m_title;
	private String m_context;
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

	public String getM_context() {
		return m_context;
	}

	public void setM_context(String m_context) {
		this.m_context = m_context;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	@Override
	public String toString() {
		return "PMemoDTO [m_seq=" + m_seq + ", m_title=" + m_title + ", m_context=" + m_context + ", s_id=" + s_id
				+ "]";
	}

}
