package com.chidi.it.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.chidi.it.entity.Photo;
import com.chidi.it.util.JdbcUtils;

@Ignore
public class PhotoDAOTest {

	private Connection connection;
 
	@Before
	public void setUp() {
		try {
			connection = JdbcUtils.getConnection();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	@Test
	public void testFindAll() {
		PhotoDAO dao = new PhotoDAO();
		List<Photo> photos = dao.findAll();
		Assert.assertTrue(photos.size() > 0);
	}

}
