package com.chidi.it.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

public class DBUtil {
	private static DataSource dataSource = null;

	public static DataSource getDataSource() {
		return dataSource;
	}

	public static Connection getConnection() {
		Connection conn = null;
		try {
			conn = dataSource.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return conn;
	}

	public static void setDataSource(DataSource dataSource) {
		DBUtil.dataSource = dataSource;
	}

	public static void closeConn(Connection conn, PreparedStatement ps,
			ResultSet rs) throws SQLException {
		if (conn != null)
			conn.close();
		if (rs != null)
			rs.close();
		if (ps != null)
			ps.close();
	}
}
