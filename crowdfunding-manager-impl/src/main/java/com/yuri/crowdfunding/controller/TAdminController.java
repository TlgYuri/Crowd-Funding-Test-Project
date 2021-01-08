package com.yuri.crowdfunding.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.yuri.crowdfunding.bean.TAdmin;
import com.yuri.crowdfunding.bean.TRole;
import com.yuri.crowdfunding.service.TAdminService;
import com.yuri.crowdfunding.service.TRoleService;
import com.yuri.crowdfunding.util.AppDateUtils;
import com.yuri.crowdfunding.util.Const;
import com.yuri.crowdfunding.util.MD5Util;

@Controller
public class TAdminController {

	@Autowired
	TAdminService adminService;

	@Autowired
	TRoleService roleService;
	
	Logger log = LoggerFactory.getLogger(TAdminController.class);

	@RequestMapping("/admin/index")
	public String main(@RequestParam(value = "pageNum", required = false, defaultValue = "1") Integer pageNum, 
						@RequestParam(value = "pageSize", required = false, defaultValue = "3") Integer pageSize, 
						@RequestParam(value = "condition", required = false, defaultValue = "") String condition, 
					Model model) {

		log.debug("跳转到管理员页面");
		log.debug("pageNum{},pageSize{},condition{}", pageNum, pageSize, condition);

		PageHelper.startPage(pageNum, pageSize);

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("condition", condition);
		PageInfo<TAdmin> pInfo = adminService.listAdminPage(params);

		log.debug("获取的PageInfo对象{}", pInfo);
		model.addAttribute("pInfo", pInfo);

		return "admin/index";
	}

	@RequestMapping("/admin/toAdd")
	public String toAdd() {
		log.debug("跳转到添加页面");

		return "/admin/add";
	}

	@RequestMapping("/admin/doAdd")
	public String doAdd(TAdmin admin) {
		log.debug("执行添加操作，接收到的用户信息：{}", admin);

		admin.setUserpswd(MD5Util.digest(Const.DEFAULT_USERPSWD));
		admin.setCreatetime(AppDateUtils.getFormatTime());
		adminService.saveTAdmin(admin);

		return "redirect:/admin/index?pageNum=" + Integer.MAX_VALUE;
	}

	@RequestMapping("/admin/toUpdate")
	public String toUpdate(Integer id, Integer pageNum, Model model) {

		log.debug("跳转到修改页面，id{}，pageNum{}",id, pageNum);
		
		TAdmin admin = adminService.selectTAdminById(id);
		
		log.debug("获取到的admin对象{}",admin);
		
		model.addAttribute("admin", admin);
		model.addAttribute("pageNum", pageNum);

		return "/admin/update";
	}

	@RequestMapping("/admin/doUpdate")
	public String doUpdate(TAdmin admin, Integer pageNum) {

		adminService.updateTAdminById(admin);

		return "redirect:/admin/index?pageNum=" + pageNum;
	}

	@RequestMapping("/admin/doDelete")
	public String doDelete(Integer id, Integer pageNum) {

		adminService.deleteTAdminById(id);

		return "redirect:/admin/index?pageNum=" + pageNum;
	}

	@RequestMapping("/admin/doDeleteBatch")
	public String doDeleteBatch(String ids, Integer pageNum) {

		String[] idStrings = ids.split(",");

		List<Integer> idList = new ArrayList<Integer>();
		for (String idStr : idStrings) {
			idList.add(Integer.parseInt(idStr));
		}

		adminService.deleteTAdminBatchById(idList);

		return "redirect:/admin/index?pageNum=" + pageNum;
	}
	
	@RequestMapping("/admin/assignRole")
	public String assignRole(@RequestParam(value = "adminId" , required = false , defaultValue = "-1")Integer adminId, Model model) {
		List<TRole> assignedRoles = new ArrayList<TRole>();
		List<TRole> unassignedRoles = new ArrayList<TRole>();
		
		
		List<TRole> roleList = roleService.listAllRoles(null);
		
		List<Integer> assignedRolesId = roleService.listAssignedRoles(adminId);
		
		if (assignedRolesId.size() > 0) {
			for(TRole temp: roleList) {
				if(assignedRolesId.contains(temp.getId())) {
					assignedRoles.add(temp);
				} else {
					unassignedRoles.add(temp);
				}
			}
		} else {
			unassignedRoles = roleList;
		}
		
		model.addAttribute("assignedRoles", assignedRoles);
		model.addAttribute("unassignedRoles", unassignedRoles);
		
		return "/admin/assignRole";
	}

}