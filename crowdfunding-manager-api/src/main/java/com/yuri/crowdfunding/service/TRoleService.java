package com.yuri.crowdfunding.service;

import java.util.List;
import java.util.Map;

import com.yuri.crowdfunding.bean.TRole;

public interface TRoleService {

	List<TRole> listAllRoles(Map<String, Object> params);

	List<Integer> listAssignedRoles(Integer adminId);
	
	int updateRole(TRole role);

	int addRole(TRole role);

	int deleteRole(Integer id);

	int assignRoleToAdmin(Integer adminId, Integer[] roleIds);

	int revokeRoleFromAdmin(Integer adminId, Integer[] roleIds);
	
}