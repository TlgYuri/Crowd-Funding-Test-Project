package com.yuri.crowdfunding.component;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.yuri.crowdfunding.bean.TAdmin;

@SuppressWarnings("serial")
public class TSecurityAdmin extends User {
	
	private TAdmin admin ;

	public TSecurityAdmin(TAdmin admin, Collection<? extends GrantedAuthority> authorities) {
		super(admin.getLoginacct(), admin.getUserpswd(), true, true, true, true, authorities);
		this.admin = admin ;
	}
	
	public TSecurityAdmin(TAdmin admin, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, Collection<? extends GrantedAuthority> authorities) {
		super(admin.getLoginacct(), admin.getUserpswd(), true, true, true, true, authorities);
		this.admin = admin ;
	}
	
	public TAdmin getAdmin() {
		return admin;
	}
}
