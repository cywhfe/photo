package com.chidi.it.entity;

import java.util.Date;

import org.apache.commons.lang3.builder.ToStringBuilder;

public class Photo {

	private int id;
	private String name;
	private String path;
	private Date date;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public Date getDate() {
		return date;
	}
	public void setDate(Date date) {
		this.date = date;
	}

	@Override
	public String toString() {
//		return "[photo] name:" + this.name + ", date:" + date + ", path:" + path;
		return ToStringBuilder.reflectionToString(this);
	}

}
