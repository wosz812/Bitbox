package com.bitbox.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.encoding.ShaPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
public class SecurityService implements PasswordEncoder{

<<<<<<< HEAD
	
	
	private ShaPasswordEncoder passwordEncoder;
	
	private Object salt = null;
	
	public SecurityService(){
		passwordEncoder = new ShaPasswordEncoder();
	}
	
	public SecurityService(int sha){
		passwordEncoder = new ShaPasswordEncoder(sha);
	}
	
	public void setEncodeHashAsBase64(boolean encodeHashAsBase64) { 
		passwordEncoder.setEncodeHashAsBase64(encodeHashAsBase64); 
	} 

	public void setSalt(Object salt){
		this.salt = salt;
	}
	
	@Override
	public String encode(CharSequence rawPw) {
		// TODO Auto-generated method stub
		return passwordEncoder.encodePassword(rawPw.toString(), salt);
	}

	@Override
	public boolean matches(CharSequence rawPw, String encodedPw) {
		// TODO Auto-generated method stub
		return false;
	}
	
	
}
=======
   
   
   private ShaPasswordEncoder passwordEncoder;
   
   private Object salt = null;
   
   public SecurityService(){
      passwordEncoder = new ShaPasswordEncoder();
   }
   
   public SecurityService(int sha){
      passwordEncoder = new ShaPasswordEncoder(sha);
   }
   
   public void setEncodeHashAsBase64(boolean encodeHashAsBase64) { 
      passwordEncoder.setEncodeHashAsBase64(encodeHashAsBase64); 
   } 

   public void setSalt(Object salt){
      this.salt = salt;
   }
   
   @Override
   public String encode(CharSequence rawPw) {
      // TODO Auto-generated method stub
      return passwordEncoder.encodePassword(rawPw.toString(), salt);
   }

   @Override
   public boolean matches(CharSequence rawPw, String encodedPw) {
      // TODO Auto-generated method stub
      return false;
   }
   
   
}
>>>>>>> origin/master
