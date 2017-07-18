package com.bitbox.dto;

public class QnaDTO {
	private int q_seq;
	private String q_title;
	private String q_content;
	private int q_readCount;
	private String q_upload;
	private String q_image;
	private String q_category;
	private String s_id;

	public int getQ_readCount() {
		return q_readCount;
	}

	public void setQ_readCount(int q_readCount) {
		this.q_readCount = q_readCount;
	}

	public int getQ_seq() {
		return q_seq;
	}

	public void setQ_seq(int q_seq) {
		this.q_seq = q_seq;
	}

	public String getQ_title() {
		return q_title;
	}

	public void setQ_title(String q_title) {
		this.q_title = q_title;
	}

	public String getQ_content() {
		return q_content;
	}

	public void setQ_content(String q_content) {
		this.q_content = q_content;
	}

	public String getQ_upload() {
		return q_upload;
	}

	public void setQ_upload(String q_upload) {
		this.q_upload = q_upload;
	}

	public String getQ_image() {
		return q_image;
	}

	public void setQ_image(String q_image) {
		this.q_image = q_image;
	}

	public String getQ_category() {
		return q_category;
	}

	public void setQ_category(String q_category) {
		this.q_category = q_category;
	}

	public String getS_id() {
		return s_id;
	}

	public void setS_id(String s_id) {
		this.s_id = s_id;
	}

	@Override
	public String toString() {
		return "QnaDTO [q_seq=" + q_seq + ", q_title=" + q_title + ", q_content=" + q_content + ", q_readCount="
				+ q_readCount + ", q_upload=" + q_upload + ", q_image=" + q_image + ", q_category=" + q_category
				+ ", s_id=" + s_id + "]";
	}


}
