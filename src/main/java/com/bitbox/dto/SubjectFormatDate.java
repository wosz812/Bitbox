package com.bitbox.dto;

import java.sql.Date;

public class SubjectFormatDate {
	String label;
	Date value;

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	
	public Date getValue() {
		return value;
	}

	public void setValue(Date value) {
		this.value = value;
	}

	@Override
	public String toString() {
		return "SubjectFormatDate [label=" + label + ", value=" + value + "]";
	}
	
}
