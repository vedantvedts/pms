package com.vts.pfms.pfts.controller;

import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.exolab.castor.types.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Component;

//public class JasperConnection {
//	private static final Logger logger=LogManager.getLogger(JasperConnection.class);
//	static Connection con;
//	@Qualifier("sessionFactory")
//	private static SessionFactory sessionFactory;
//	@Qualifier("oraclesessionFactory")
//	private SessionFactory oraclesessionFactory;
	
	@Component
	public class JasperJdbcConnection {
		
		 private static final Logger logger = LogManager.getLogger(JasperJdbcConnection.class);
		 
		 @Autowired
		 private Environment env;
		 
		 public Connection GetJasperJdbcConnection() {
			 Connection conn=null;
			 logger.info(new Date() + "Inside GetJasperJdbcConection.htm");
			 try {
				 conn = DriverManager.getConnection(env.getProperty("dataset.url"),env.getProperty("dataset.username"),env.getProperty("dataset.password"));
			 }catch (Exception e) {
				e.printStackTrace();
			 }
			 
			 return conn; 
		 }
	}
//		Session session = sessionFactory.openSession();
//		Connection conn=null;
//		logger.info("getting jdbc connection from hibernate");
//		try
//		{
//			SessionImpl sessionImpl = (SessionImpl) session;
//			conn = sessionImpl.connection();
//		}catch(Exception h)
//		{
//			logger.debug("exception occures");
//			h.printStackTrace();
//		}
//		
//		return conn;
	
	
	
	

