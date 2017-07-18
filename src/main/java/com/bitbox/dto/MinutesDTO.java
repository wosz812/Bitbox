package com.bitbox.dto;

public class MinutesDTO {
	private int min_seq;
	private String min_date;
	private String min_attendee;
	private String min_subject;
	private String min_content;
	private String min_opinion;
	private String min_decide;
	private String min_schedule;
	private String min_prepare;
	private int group_seq;
	public int getMin_seq() {
		return min_seq;
	}
	public void setMin_seq(int min_seq) {
		this.min_seq = min_seq;
	}
	public String getMin_date() {
		return min_date;
	}
	public void setMin_date(String min_date) {
		this.min_date = min_date;
	}
	public String getMin_attendee() {
		return min_attendee;
	}
	public void setMin_attendee(String min_attendee) {
		this.min_attendee = min_attendee;
	}
	public String getMin_subject() {
		return min_subject;
	}
	public void setMin_subject(String min_subject) {
		this.min_subject = min_subject;
	}
	public String getMin_content() {
		return min_content;
	}
	public void setMin_content(String min_content) {
		this.min_content = min_content;
	}
	public String getMin_opinion() {
		return min_opinion;
	}
	public void setMin_opinion(String min_opinion) {
		this.min_opinion = min_opinion;
	}
	public String getMin_decide() {
		return min_decide;
	}
	public void setMin_decide(String min_decide) {
		this.min_decide = min_decide;
	}
	public String getMin_schedule() {
		return min_schedule;
	}
	public void setMin_schedule(String min_schedule) {
		this.min_schedule = min_schedule;
	}
	public String getMin_prepare() {
		return min_prepare;
	}
	public void setMin_prepare(String min_prepare) {
		this.min_prepare = min_prepare;
	}
	public int getGroup_seq() {
		return group_seq;
	}
	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}
	@Override
	public String toString() {
		return "MinutesDTO [min_seq=" + min_seq + ", min_date=" + min_date
				+ ", min_attendee=" + min_attendee + ", min_subject=" + min_subject + ", min_content=" + min_content
				+ ", min_opnion=" + min_opinion + ", min_decide=" + min_decide + ", min_schedule=" + min_schedule
				+ ", min_prepare=" + min_prepare + ", group_seq=" + group_seq + "]";
	}
}
