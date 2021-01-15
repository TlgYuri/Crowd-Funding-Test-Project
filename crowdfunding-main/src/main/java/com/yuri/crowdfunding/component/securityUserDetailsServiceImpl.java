package com.yuri.crowdfunding.component;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.yuri.crowdfunding.bean.TAdmin;
import com.yuri.crowdfunding.bean.TAdminExample;
import com.yuri.crowdfunding.bean.TPermission;
import com.yuri.crowdfunding.bean.TRole;
import com.yuri.crowdfunding.mapper.TAdminMapper;
import com.yuri.crowdfunding.mapper.TPermissionMapper;
import com.yuri.crowdfunding.mapper.TRoleMapper;

@Component
public class SecurityUserDetailsServiceImpl implements UserDetailsService {

	Logger log = LoggerFactory.getLogger(getClass());
	
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
		
		if(adminList != null && !adminList.isEmpty()) {
			TAdmin admin = adminList.get(0);
			
			Set<GrantedAuthority> authorities = new HashSet<GrantedAuthority>();
			
			List<TRole> roles = roleMapper.selectRolesByAdminId(admin.getId());
			for(TRole role : roles) {
				if(!StringUtils.isEmpty(role.getName())) {
					authorities.add(new SimpleGrantedAuthority("ROLE_" + role.getName()));
				}
			}
			
			List<TPermission> perms = permissionMapper.selectPermissionsByAdminId(admin.getId()) ;
			for(TPermission perm : perms) {
				if(!StringUtils.isEmpty(perm.getName())) {
					authorities.add(new SimpleGrantedAuthority(perm.getName()));
				}
			}
			
			return new TSecurityAdmin(admin, authorities);
		}
		
		return null;
	}


}
