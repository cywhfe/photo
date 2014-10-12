package com.chidi.it.controller.photo;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;

import com.chidi.it.dao.PhotoDAO;

public class PhotoDeleteServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
		if (StringUtils.isNotBlank(id)) {
			try {
				PhotoDAO dao = new PhotoDAO();
				dao.delete(Integer.valueOf(id));
			} catch (NumberFormatException e) {
				e.printStackTrace();
			}
		}
		response.sendRedirect("../photo/list");
	}

}
