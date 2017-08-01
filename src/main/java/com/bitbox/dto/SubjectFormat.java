package com.bitbox.dto;

public class SubjectFormat {
	String label;
	String value;
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	@Override
	public String toString() {
		return "SubjectFormat [label=" + label + ", value=" + value + "]";
	}	
	
}
