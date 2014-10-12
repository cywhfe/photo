package com.chidi.it.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.dbutils.DbUtils;
import org.apache.commons.dbutils.QueryRunner;
import org.apache.commons.dbutils.ResultSetHandler;
import org.apache.commons.dbutils.handlers.BeanHandler;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.commons.dbutils.handlers.ScalarHandler;

import com.chidi.it.entity.Photo;
import com.chidi.it.util.DBUtil;

public class PhotoDAO {

	public List<Photo> findAll() {
		Connection conn = null;
		List<Photo> photoList = null;
		try {
			conn = DBUtil.getConnection();
			String sql = "SELECT * FROM photos ";
			QueryRunner runner = new QueryRunner();
			ResultSetHandler<List<Photo>> handler = new BeanListHandler<Photo>(
					Photo.class);
			photoList = runner.query(conn, sql, handler);
		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return photoList;
	}

	public List<Photo> findByDate(String date) {
		Connection conn = null;
		List<Photo> photoList = null;
		try {
			conn = DBUtil.getConnection();
			String sql = "SELECT * FROM photos where date = ?";
			QueryRunner runner = new QueryRunner();
			ResultSetHandler<List<Photo>> handler = new BeanListHandler<Photo>(
					Photo.class);
			photoList = runner.query(conn, sql, handler, new Object[]{date});
		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return photoList;
	}

	public Photo getPhoto(Photo photo) {
		Connection conn = null;
		Photo aPhoto = null;
		try {
			conn = DBUtil.getConnection();
			String sql = "SELECT * FROM photos where id=? ";
			QueryRunner runner = new QueryRunner();
			ResultSetHandler<Photo> handler = new BeanHandler<Photo>(
					Photo.class);
			aPhoto = runner.query(conn, sql, handler, photo.getId());
		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return aPhoto;
	}

	public void insert(Photo photo) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = "INSERT INTO photos (name, date, path) values (?, ?, ?) ";
			QueryRunner runner = new QueryRunner();
			runner.update(
					conn,
					sql,
					new Object[]{photo.getName(), photo.getDate(),
							photo.getPath()});
		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
			e.printStackTrace();
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public int save() {
		Connection conn = null;
		int id = 0;
		try {
			conn = DBUtil.getConnection();
			String sql = "INSERT INTO photos (name, date, path) values (?, ?, ?) ";
			QueryRunner runner = new QueryRunner();
			ResultSetHandler<Photo> handler = new BeanHandler<Photo>(
					Photo.class);
			runner.insert(conn, sql, handler);

			runner.update(conn, sql);
			id = runner.query(conn, "SELECT LAST_INSERT_ID()",
					new ScalarHandler<Integer>(1));

		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
		} finally {
			DbUtils.closeQuietly(conn);
		}
		return id;
	}

	public void update(Photo photo) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = "UPDATE photos SET name = ?, date = ?, path = ? WHERE id = ? ";
			QueryRunner runner = new QueryRunner();
			runner.update(
					conn,
					sql,
					new Object[]{photo.getName(), photo.getDate(),
							photo.getPath(), photo.getId()});
		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}

	public void delete(int id) {
		Connection conn = null;
		try {
			conn = DBUtil.getConnection();
			String sql = "DELETE FROM photos WHERE id = ? ";
			QueryRunner runner = new QueryRunner();
			runner.update(conn, sql, new Object[]{id});
		} catch (SQLException e) {
			DbUtils.printStackTrace(e);
		} finally {
			DbUtils.closeQuietly(conn);
		}
	}


}
