package com.yuri.crowdfunding.component;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;

import com.yuri.crowdfunding.bean.TAdmin;
import com.yuri.crowdfunding.bean.TAdminExample;
import com.yuri.crowdfunding.mapper.TAdminMapper;
import com.yuri.crowdfunding.mapper.TPermissionMapper;
import com.yuri.crowdfunding.mapper.TRoleMapper;

@Component
public class securityUserDetailsServiceImpl implements UserDetailsService {

	@Autowired
	TAdminMapper adminMapper;
	
	@Autowired
	TRoleMapper roleMapper;
	
	@Autowired
	TPermissionMapper permissionMapper;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		TAdminExample example = new TAdminExample();
		example.createCriteria().andLoginacctEqualTo(username);
		List<TAdmin> adminList = adminMapper.selectByExample(example);
		return null;
	}


}
