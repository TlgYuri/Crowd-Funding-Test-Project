package com.yuri.crowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuri.crowdfunding.bean.TRole;
import com.yuri.crowdfunding.service.TRoleService;


@Controller
public class TRoleController {

	@Autowired
	TRoleService roleService;
	
	Logger log = LoggerFactory.getLogger(TRoleController.class);
	
	@RequestMapping("/role/index")
	public String index() {
		
		log.debug("跳转到role页面主页");
		
		return "role/index";
	}
	
	@ResponseBody
	@RequestMapping("/role/loadData")
	public PageInfo<TRole> loadData(@RequestParam(value="pageNum",required=false,defaultValue="1") Integer pageNum,
									@RequestParam(value="pageSize",required=false,defaultValue="3") Integer pageSize, 
									@RequestParam(value="condition",required=false,defaultValue="") String condition) {
		log.debug("开始加载role页面主页数据");
		log.debug("pageNum{},pageSize{},condition{}",pageNum,pageSize,condition);
		
		PageHelper.startPage(pageNum,pageSize);
		
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("condition", condition);
		
		List<TRole> roleList = roleService.listAllRoles(params);

		PageInfo<TRole> pInfo = new PageInfo<TRole>(roleList, 6);

		log.debug("获取到的role对象{}",pInfo);
		
		return pInfo;
	}
	
	@ResponseBody
	@RequestMapping("/role/doAdd")
	public int doAdd(TRole role){
		return roleService.addRole(role);
	}
	
	@ResponseBody
	@RequestMapping("/role/doUpdate")
	public int doUpdate(TRole role){
		return roleService.updateRole(role);
	}
	
	@ResponseBody
	@RequestMapping("/role/doDelete")
	public int doDelete(Integer id){
		return roleService.deleteRole(id);
	}
	
	@ResponseBody
	@RequestMapping("/role/assignRoleToAdmin")
	public int assignRoleToAdmin(Integer adminId, Integer[] roleIds){
		return roleService.assignRoleToAdmin(adminId, roleIds);
	}
	
	@ResponseBody
	@RequestMapping("/role/revokeRoleFromAdmin")
	public int revokeRoleFromAdmin(Integer adminId, Integer[] roleIds){
		return roleService.revokeRoleFromAdmin(adminId, roleIds);
	}
	
}
