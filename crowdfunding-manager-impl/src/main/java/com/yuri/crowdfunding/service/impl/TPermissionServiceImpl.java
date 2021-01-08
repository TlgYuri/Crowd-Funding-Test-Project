package com.yuri.crowdfunding.service.impl;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuri.crowdfunding.bean.TPermission;
import com.yuri.crowdfunding.mapper.TPermissionMapper;
import com.yuri.crowdfunding.mapper.TRolePermissionMapper;
import com.yuri.crowdfunding.service.TPermissionService;

@Service
public class TPermissionServiceImpl implements TPermissionService {

	@Autowired
	TPermissionMapper permissionMapper;

	@Autowired
	TRolePermissionMapper rpMapper;
	
	Logger log = LoggerFactory.getLogger(TPermissionServiceImpl.class);

	@Override
	public List<TPermission> listAllPermission() {
		return permissionMapper.selectByExample(null);
	}

	@Override
	public int addPermission(TPermission permission) {
		return permissionMapper.insertSelective(permission);
	}

	@Override
	public int updatePermission(TPermission permission) {
		return permissionMapper.updateByPrimaryKeySelective(permission);
	}

	@Override
	public int deletePermission(Integer id) {
		return permissionMapper.deleteByPrimaryKey(id);
	}

	@Override
	public List<Integer> listPermissionByRoleId(Integer roleId) {
		return rpMapper.selectPermissionByRoleId(roleId);
	}

	@Override
	public int assignPermissionToRole(Integer roleId, List<Integer> permissionIds) {
		rpMapper.deleteByRoleId(roleId);
		return rpMapper.assignPermissionToRole(roleId, permissionIds);
	}

}
