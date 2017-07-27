package com.bitbox.dto;

public class TodoDTO {
	private int todo_seq;
	private String todo;
	private String todo_id;

	public int getTodo_seq() {
		return todo_seq;
	}

	public void setTodo_seq(int todo_seq) {
		this.todo_seq = todo_seq;
	}

	public String getTodo() {
		return todo;
	}

	public void setTodo(String todo) {
		this.todo = todo;
	}

	public String getTodo_id() {
		return todo_id;
	}

	public void setTodo_id(String todo_id) {
		this.todo_id = todo_id;
	}

	public TodoDTO(String todo, String todo_id) {
		this.todo = todo;
		this.todo_id = todo_id;
	}

	public TodoDTO() {
		this.todo_seq = todo_seq;
		this.todo = todo;
		this.todo_id = todo_id;
	}

}
