package com.bitbox.dto;

public class GLogDTO {
	private int log_seq;
	private String s_id;
	private String title;
	private String acting_id;
	private String action;
	private String detail;
	
	public GLogDTO(){
		
	}
	public GLogDTO(String s_id,String title,String acting_id,String action,String detail){
		this.s_id=s_id;
		this.title=title;
		this.acting_id=acting_id;
		this.action=action;
		this.detail=detail;
	}
	public int getLog_seq() {
		return log_seq;
	}
	public void setLog_seq(int log_seq) {
		this.log_seq = log_seq;
	}
	public String getS_id() {
		return s_id;
	}
	public void setS_id(String s_id) {
		this.s_id = s_id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getActing_id() {
		return acting_id;
	}
	public void setActing_id(String acting_id) {
		this.acting_id = acting_id;
	}
	public String getAction() {
		return action;
	}
	public void setAction(String action) {
		this.action = action;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	@Override
	public String toString() {
		return "GLogDTO [log_seq=" + log_seq + ", s_id=" + s_id + ", title=" + title + ", acting_id=" + acting_id
				+ ", action=" + action + ", detail=" + detail + "]";
	}
	
}
