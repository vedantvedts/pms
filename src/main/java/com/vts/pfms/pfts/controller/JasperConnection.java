package com.vts.pfms.pfts.controller;

import java.sql.Connection;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.internal.SessionImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

public class JasperConnection {
	private static final Logger logger=LogManager.getLogger(JasperConnection.class);
	static Connection con;
	@Qualifier("sessionFactory")
	private static SessionFactory sessionFactory;
//	@Qualifier("oraclesessionFactory")
//	private SessionFactory oraclesessionFactory;
	
	
	public Connection getJdbcConnection()
	{
		Session session = sessionFactory.openSession();
		Connection conn=null;
		logger.info("getting jdbc connection from hibernate");
		try
		{
			SessionImpl sessionImpl = (SessionImpl) session;
			conn = sessionImpl.connection();
		}catch(Exception h)
		{
			logger.debug("exception occures");
			h.printStackTrace();
		}
		
		return conn;
	}
	
}
