package com.yuri.crowdfunding.service;

import java.util.List;

import com.yuri.crowdfunding.bean.TPermission;

public interface TPermissionService {

	List<TPermission> listAllPermission();

	int addPermission(TPermission permission);

	int updatePermission(TPermission permission);

	int deletePermission(Integer id);

	int assignPermissionToRole(Integer roleId, List<Integer> permissionIds);

	List<Integer> listPermissionByRoleId(Integer roleId);

}
