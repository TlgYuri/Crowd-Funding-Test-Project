package com.yuri.crowdfunding.bean;

import java.util.List;

public class Data {

	private Integer roleId;
	private List<Integer> permissionIds;

	public Integer getRoleId() {
		return roleId;
	}

	public void setRoleId(Integer roleId) {
		this.roleId = roleId;
	}

	public List<Integer> getPermissionIds() {
		return permissionIds;
	}

	public void setPermissionIds(List<Integer> permissionIds) {
		this.permissionIds = permissionIds;
	}

}
