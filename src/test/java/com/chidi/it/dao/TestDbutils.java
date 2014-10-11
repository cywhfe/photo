package com.chidi.it.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.junit.Ignore;
import org.junit.Test;

import com.chidi.it.entity.User;
import com.chidi.it.util.JdbcUtils;
 
@Ignore
public class TestDbutils {
	// 使用dbutils完成数据库的crud
	@Test
	public void insert() throws SQLException {
		QueryRunner runner = new QueryRunner(JdbcUtils.getDataSource());
		String sql = "insert into users(id,name) values(?,?)";
		Object params[] = {11, "aaaa"};
		runner.update(sql, params);
	}

	@Test
	public void update() throws SQLException {
		QueryRunner runner = new QueryRunner(JdbcUtils.getDataSource());
		String sql = "update users set name=? where id=?";
		Object params[] = {"aaaa111", 111};
		runner.update(sql, params);
	}

	@Test
	public void delete() throws SQLException {
		QueryRunner runner = new QueryRunner(JdbcUtils.getDataSource());
		String sql = "delete from users where id=?";
		runner.update(sql, 1);
	}

	@Test
	public void find() throws SQLException {
		QueryRunner runner = new QueryRunner(JdbcUtils.getDataSource());
		String sql = "select * from user where id=?";
		User user = (User) runner.query(sql, 1, new BeanHandler(User.class));
		System.out.println(user.getName());
	}

	@Test
	public void getAll() throws Exception {
		QueryRunner runner = new QueryRunner(JdbcUtils.getDataSource());
		String sql = "select * from user";
		List list = (List) runner.query(sql, new BeanListHandler(User.class));
		System.out.println(list);
	}
	
	@Test
	public void batch() throws SQLException {
		QueryRunner runner = new QueryRunner(JdbcUtils.getDataSource());
		String sql = "insert into users(id, name) values(?, ?)";
		Object params[][] = new Object[3][2];
		for (int i = 0; i < params.length; i++) { // 3
			params[i] = new Object[]{i + 1, "aa" + i};
		}
		runner.batch(sql, params);
	}
}
