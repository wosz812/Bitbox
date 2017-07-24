package com.bitbox.dto;

public class PageDTO {

	private String id;
	private int start;

	public PageDTO(String id, int start) {
		this.id = id;
		this.start = start;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	@Override
	public String toString() {
		return "id=" + id + ", start=" + start;
	}

}
