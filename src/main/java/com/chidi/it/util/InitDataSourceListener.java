package com.chidi.it.util;

import java.io.IOException;
import java.util.Properties;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.apache.commons.dbcp.BasicDataSource;

public class InitDataSourceListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		Properties properties = new Properties();
		try {
			properties.load(InitDataSourceListener.class.getClassLoader()
					.getResourceAsStream("app.properties"));
			String url = properties.getProperty("url");
			String username = properties.getProperty("username");
			String password = properties.getProperty("password");
			String driverName = properties.getProperty("driverName");
			String initialSize = properties.getProperty("initialSize");
			String maxActive = properties.getProperty("maxActive");
			String maxIdle = properties.getProperty("maxIdle");
			String maxWait = properties.getProperty("maxWait");

			BasicDataSource basicDataSource = new BasicDataSource();
			basicDataSource.setUrl(url);
			basicDataSource.setUsername(username);
			basicDataSource.setPassword(password);
			basicDataSource.setDriverClassName(driverName);
			basicDataSource.setInitialSize(Integer.valueOf(initialSize));
			basicDataSource.setMaxActive(Integer.valueOf(maxActive));
			basicDataSource.setMaxIdle(Integer.valueOf(maxIdle));
			basicDataSource.setMaxWait(Integer.valueOf(maxWait));
			System.out.println(basicDataSource);
			DBUtil.setDataSource(basicDataSource);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
