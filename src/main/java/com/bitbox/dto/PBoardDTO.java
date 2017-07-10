package com.bitbox.dto;

import java.sql.Date;

public class PBoardDTO {
	private int p_boardseq;
	private String p_title;
	private String p_content;
	private String p_filename;
	private String p_uuidname;
	private Date p_date;
	private String p_category;
	private String s_id;

	public PBoardDTO() {
	}

	public int getP_boardseq() {
		return p_boardseq;
	}

	public void setP_boardseq(int p_boardseq) {
		this.p_boardseq = p_boardseq;
	}

	public String getP_title() {
		return p_title;
	}

	public void setP_title(String p_title) {
		this.p_title = p_title;
	}

	public String getP_content() {
		return p_content;
	}

	public void setP_content(String p_content) {
		this.p_content = p_content;
	}

	public String getP_filename() {
		return p_filename;
	}

	public void setP_filename(String p_filename) {
		this.p_filename = p_filename;
	}

	

	public String getP_uuidname() {
		return p_uuidname;
	}

	public void setP_uuidname(String p_uuidname) {
		this.p_uuidname = p_uuidname;
	}

	public Date getP_date() {
		return p_date;
	}

	public void setP_date(Date p_date) {
		this.p_date = p_date;
	}

	public String getP_category() {
		return p_category;
	}

	public void setP_category(String p_category) {
		this.p_category = p_category;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	
	
	
}
