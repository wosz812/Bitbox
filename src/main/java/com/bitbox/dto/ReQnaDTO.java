package com.bitbox.dto;

public class ReQnaDTO {
	private int re_seq;
	private String re_writer;
	private String re_content;
	private int q_seq;
	public int getRe_seq() {
		return re_seq;
	}
	public void setRe_seq(int re_seq) {
		this.re_seq = re_seq;
	}
	public String getRe_writer() {
		return re_writer;
	}
	public void setRe_writer(String re_writer) {
		this.re_writer = re_writer;
	}
	public String getRe_content() {
		return re_content;
	}
	public void setRe_content(String re_content) {
		this.re_content = re_content;
	}
	public int getQ_seq() {
		return q_seq;
	}
	public void setQ_seq(int q_seq) {
		this.q_seq = q_seq;
	}
	@Override
	public String toString() {
		return "ReQnaDTO [re_seq=" + re_seq + ", re_writer=" + re_writer + ", re_content=" + re_content + ", q_seq="
				+ q_seq + "]";
	}
	
}
