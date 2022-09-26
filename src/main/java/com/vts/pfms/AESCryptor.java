package com.vts.pfms;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.security.spec.KeySpec;
import java.util.Base64;
import java.util.Date;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.PBEKeySpec;
import javax.crypto.spec.SecretKeySpec;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class AESCryptor {

	private final Logger logger=LogManager.getLogger(AESCryptor.class);
	
	
	private final String SECRET_KEY = "drdo_LRDE";
    
	private final String SALT = "EnCRYPTsalt";
	
	    public String encrypt(String strToEncrypt)
	    {
	        try {
	        	
	            // Create default byte array
	            byte[] iv = { 0, 0, 0, 0, 0, 0, 0, 0,
	                          0, 0, 0, 0, 0, 0, 0, 0 };
	            
	            IvParameterSpec ivspec  = new IvParameterSpec(iv);
	  
	            // Create SecretKeyFactory object
	            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
	            
	            // Create KeySpec object and assign with
	            // constructor
	            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), SALT.getBytes(), 65536, 256);
	            SecretKey tmp = factory.generateSecret(spec);
	            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");
	  
	            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5Padding");
	            cipher.init(Cipher.ENCRYPT_MODE, secretKey, ivspec);
	            // Return encrypted string
	            return Base64.getEncoder().encodeToString(cipher.doFinal(strToEncrypt.getBytes(StandardCharsets.UTF_8)));
	        }
	        catch (Exception e) {
	        	logger.error(new Date() +" Inside AESCryptor.encrypt ", e);
	            System.err.println("Error while encrypting: " + e.toString());
	        }
	        return null;
	    }
	
	    
	    
	    
	    public String decrypt(String strToDecrypt)
	    {
	        try {
	  
	            // Default byte array
	            byte[] iv = { 0, 0, 0, 0, 0, 0, 0, 0,
	                          0, 0, 0, 0, 0, 0, 0, 0  };
	            // Create IvParameterSpec object and assign with
	            // constructor
	            IvParameterSpec ivspec = new IvParameterSpec(iv);
	  
	            // Create SecretKeyFactory Object
	            SecretKeyFactory factory = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256");
	  
	            // Create KeySpec object and assign with
	            // constructor
	            KeySpec spec = new PBEKeySpec(SECRET_KEY.toCharArray(), SALT.getBytes(),65536, 256);
	            SecretKey tmp = factory.generateSecret(spec);
	            SecretKeySpec secretKey = new SecretKeySpec(tmp.getEncoded(), "AES");
	  
	            Cipher cipher = Cipher.getInstance("AES/CBC/PKCS5PADDING");
	            cipher.init(Cipher.DECRYPT_MODE, secretKey, ivspec);
	            // Return decrypted string
	            return new String(cipher.doFinal(Base64.getDecoder().decode(strToDecrypt)));
	        }
	        catch (Exception e) 
	        {
	        	logger.error(new Date() +" Inside AESCryptor.decrypt ", e);
	        }
	        return null;
	    }
	    
	    public String encryptParam(String strToEncrypt) throws Exception
	    {
	    	try {
	    		return URLEncoder.encode(encrypt(strToEncrypt),"UTF-8");
	    	} catch (Exception e){
	    		logger.error(new Date() +" Inside AESCryptor.encryptParam ", e);
	    		 System.err.println("Error while Encrypting: "+ e.toString());
	    		 e.printStackTrace();
	    		 return null;
	    	}
	    }
	    
	    public String decryptParam(String strToEncrypt) throws Exception
	    {
	    	try {
	    		return URLDecoder.decode(decrypt(strToEncrypt), "UTF-8");
	    	} catch (Exception e){
	    		logger.error(new Date() +" Inside AESCryptor.decryptParam ", e);
	    		 System.err.println("Error while Decrypting: "+ e.toString());
	    		 e.printStackTrace();
	    		 return null;
	    	}
	    }
	    
	
}
