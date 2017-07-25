package com.bitbox.dto;

public class GanttDTO {
	private int gan_seq;
	private String gan_data;
	private int group_seq;

	public GanttDTO() {
	}

	public GanttDTO(int group_seq) {
		this.group_seq = group_seq;
	}

	public int getGan_seq() {
		return gan_seq;
	}

	public void setGan_seq(int gan_seq) {
		this.gan_seq = gan_seq;
	}

	public String getGan_data() {
		return gan_data;
	}

	public void setGan_data(String gan_data) {
		this.gan_data = gan_data;
	}

	public int getGroup_seq() {
		return group_seq;
	}

	public void setGroup_seq(int group_seq) {
		this.group_seq = group_seq;
	}

	@Override
	public String toString() {
		return "gan_seq=" + gan_seq + ", gan_data=" + gan_data + ", group_seq=" + group_seq;
	}

}
