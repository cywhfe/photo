package com.chidi.it.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

import javax.sql.DataSource;

import org.apache.commons.dbcp.BasicDataSourceFactory;

public class JdbcUtils {

	private static DataSource ds;

	private static ThreadLocal<Connection> tl = new ThreadLocal<Connection>();
	static {
		try {
			Properties prop = new Properties();
			InputStream is = JdbcUtils.class.getClassLoader()
					.getResourceAsStream("app.properties");
			prop.load(is);
			BasicDataSourceFactory factory = new BasicDataSourceFactory();
			ds = factory.createDataSource(prop);

		} catch (Exception e) {
			throw new ExceptionInInitializerError(e);
		}
	}
	
	public static DataSource getDataSource(){  
        return ds;  
    }  
	
	public static Connection getConnection() throws SQLException{
		try {
			Connection conn = tl.get();
			if (conn == null) {
				conn = ds.getConnection();
				tl.set(conn);
			}
			return conn;
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	

}
