package com.yuri.crowdfunding.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuri.crowdfunding.bean.Data;
import com.yuri.crowdfunding.bean.TPermission;
import com.yuri.crowdfunding.service.TPermissionService;

@Controller
public class TPermissionServiceController {

	@Autowired
	TPermissionService permissionService;
	
	Logger log = LoggerFactory.getLogger(TPermissionServiceController.class);
	
	@RequestMapping("/permission/index")
	public String index() {
		return "/permission/index";
	}
	
	@ResponseBody
	@RequestMapping("/permission/loadZTree")
	public List<TPermission> loadZTree(){
		return permissionService.listAllPermission();
	}
	
	@ResponseBody
	@RequestMapping("/permission/addPermission")
	public int addPermission(TPermission permission) {
		return permissionService.addPermission(permission);
	}
	
	@ResponseBody
	@RequestMapping("/permission/updatePermission")
	public int updatePermission(TPermission permission) {
		return permissionService.updatePermission(permission);
	}
	
	@ResponseBody
	@RequestMapping("/permission/deletePermission")
	public int deletePermission(Integer id) {
		return permissionService.deletePermission(id);
	}
	
	@ResponseBody
	@RequestMapping("/permission/listPermissionByRoleId")
	public List<Integer> listPermissionByRoleId(Integer roleId){
		return permissionService.listPermissionByRoleId(roleId);
	}
	
	@ResponseBody
	@RequestMapping("/permission/doAssignPermissionToRole")
	public int assignPermissionToRole(Data data){
		return permissionService.assignPermissionToRole(data.getRoleId(), data.getPermissionIds());
	}
	
}
