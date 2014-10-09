package com.chidi.it.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;

import com.chidi.it.entity.User;
import com.chidi.it.util.DBUtil;

public class IndexServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;
//	private Connection conn;

	@Override
	protected void doGet(final HttpServletRequest req,
			final HttpServletResponse resp) throws ServletException,
			IOException {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = "SELECT * FROM user where id=?";
			QueryRunner runner = new QueryRunner();
			ResultSetHandler<User> userHandler = new BeanHandler<User>(
					User.class);
			User user1 = runner.query(conn, sql, userHandler, 1);
			System.out.println(user1.getId() + "-" + user1.getName());
		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
		} finally {
			DbUtils.closeQuietly(conn);
		}

		final PrintWriter out = resp.getWriter();
		out.println("SimpleServlet Executed");
		out.flush();
		out.close();
	}
}
