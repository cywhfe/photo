package com.chidi.it.controller.photo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.chidi.it.dao.PhotoDAO;
import com.chidi.it.entity.Photo;

public class PhotoListServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {

		List<Photo> photoList = new ArrayList<Photo>();
		PhotoDAO dao = new PhotoDAO();
		
		String date = request.getParameter("date");
		if (StringUtils.isNotBlank(date)) {
			photoList = dao.findByDate(date);
		}else {
			photoList = dao.findAll();
		}
		
		request.setAttribute("photoList", photoList);
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/WEB-INF/jsp/photo/photoList.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
