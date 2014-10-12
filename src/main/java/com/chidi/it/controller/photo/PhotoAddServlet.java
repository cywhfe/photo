package com.chidi.it.controller.photo;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.joda.time.DateTime;
import org.joda.time.format.DateTimeFormat;
import org.joda.time.format.DateTimeFormatter;

import com.chidi.it.dao.PhotoDAO;
import com.chidi.it.entity.Photo;

public class PhotoAddServlet extends HttpServlet {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		RequestDispatcher dispatcher = request
				.getRequestDispatcher("/WEB-INF/jsp/photo/photoAdd.jsp");
		dispatcher.forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(1024 * 1024 * 15);// file
																			// size
																			// buffer
																			// limit
																			// is
																			// 15M
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setSizeMax(1024 * 1024 * 50);// 将页面请求传递信息最大值设置为50M
		upload.setFileSizeMax(1024 * 1024 * 15);// 将单个上传文件信息最大值设置为10M
		Map<String, String> params = new HashMap<String, String>();
		try {
			List<FileItem> items = upload.parseRequest(request);
			for (FileItem item : items) {
				if (item.isFormField()) {
					String fieldName = item.getFieldName();
					String value = item.getString();
					params.put(fieldName, value);
				} else {
					String filename = FilenameUtils.getName(item.getName());
					if (StringUtils.isNotBlank(filename)) {// check file is not
															// blank
						String basePath = this.getServletContext().getRealPath("/tmp");
						Date date = new Date();
						File file = new File(basePath + File.separator + date.getTime());//rename photo name as upload time
						item.write(file);

						// save photo
						Photo aPhoto = new Photo();
						aPhoto.setName(params.get("name"));
						DateTimeFormatter formatter = DateTimeFormat
								.forPattern("yyyy-MM-dd");
						DateTime uploadDate = formatter.parseDateTime(params
								.get("date"));
						aPhoto.setDate(uploadDate.toDate());
						aPhoto.setPath(String.valueOf(date.getTime()));
						PhotoDAO dao = new PhotoDAO();
						dao.insert(aPhoto);
					}
				}
			}
			response.sendRedirect("../photo/list");
		} catch (FileUploadException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
