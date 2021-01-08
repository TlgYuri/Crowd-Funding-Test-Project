package com.yuri.crowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.yuri.crowdfunding.bean.TRole;
import com.yuri.crowdfunding.bean.TRoleExample;
import com.yuri.crowdfunding.mapper.TAdminRoleMapper;
import com.yuri.crowdfunding.mapper.TRoleMapper;
import com.yuri.crowdfunding.service.TRoleService;

@Service
public class TRoleServiceImpl implements TRoleService {

	@Autowired
	TRoleMapper roleMapper;
	
	@Autowired
	TAdminRoleMapper arMapper;

	Logger log = LoggerFactory.getLogger(TRoleServiceImpl.class);
	
	@Override
	public List<TRole> listAllRoles(Map<String, Object> params) {
		String condition = null ;
		if(params != null) {
			condition = (String) params.get("condition");
		}
		
		TRoleExample example = new TRoleExample();
		
		if(condition != null && !StringUtils.isEmpty(condition.trim())) {
			example.createCriteria().andNameLike("%"+condition+"%");
		}
		
		List<TRole> roleList = roleMapper.selectByExample(example);

		
		return roleList;
	}
	
	@Override
	public List<Integer> listAssignedRoles(Integer adminId) {
		return arMapper.selectRoleIdByAdminId(adminId);
	}
	
	@Override
	public int addRole(TRole role) {
		if(!StringUtils.isEmpty(role.getName().trim())) {
			return roleMapper.insertSelective(role);
		}
		return 0;
	}
	
	@Override
	public int updateRole(TRole role) {
		if(!StringUtils.isEmpty(role.getName().trim())) {
			return roleMapper.updateByPrimaryKeySelective(role);
		}
		return 0;
	}
	
	@Override
	public int deleteRole(Integer id) {
		return roleMapper.deleteByPrimaryKey(id);
	}
	
	@Override
	public int assignRoleToAdmin(Integer adminId, Integer[] roleIds) {
		return arMapper.assignRoleToAdmin(adminId, roleIds);
	}

	@Override
	public int revokeRoleFromAdmin(Integer adminId, Integer[] roleIds) {
		return arMapper.revokeRoleFromAdmin(adminId, roleIds);
	}
}