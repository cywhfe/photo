package com.chidi.it.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.chidi.it.dao.PhotoDAO;
import com.chidi.it.entity.Photo;
import com.chidi.it.util.JsonUtil;
import com.fasterxml.jackson.databind.ObjectMapper;

public class PhotoShowServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {
		List<Photo> photoList = new ArrayList<Photo>();
		PhotoDAO dao = new PhotoDAO();

		String date = request.getParameter("date");
		if (StringUtils.isNotBlank(date)) {
			photoList = dao.findByDate(date);
		}
		
		ObjectMapper mapper = JsonUtil.getObjectMapper();
		String lists = mapper.writeValueAsString(photoList);
		
		OutputStream stream = response.getOutputStream();
		stream.write(lists.getBytes());
		stream.close();
	}

	@Override
	public void doPost(final HttpServletRequest request,
			final HttpServletResponse response) throws ServletException,
			IOException {
		doGet(request, response);
	}	
}
