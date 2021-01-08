package com.yuri.crowdfunding.controller;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.yuri.crowdfunding.bean.TMenu;
import com.yuri.crowdfunding.service.TMenuService;

@Controller
public class TMenuController {

	@Autowired
	TMenuService menuService;

	Logger log = LoggerFactory.getLogger(TMenuController.class);

	@RequestMapping("/menu/index")
	public String index() {

		return "menu/index";
	}

	@ResponseBody
	@RequestMapping("/menu/loadZTree")
	public List<TMenu> loadZTree() {

		return menuService.listAllMenu();
	}

	@ResponseBody
	@RequestMapping("/menu/addMenu")
	public int addMenu(TMenu menu) {
		return menuService.addMenu(menu);
	}

	@ResponseBody
	@RequestMapping("/menu/updateMenu")
	public int updateMenu(TMenu menu) {
		return menuService.updateMenu(menu);
	}

	@ResponseBody
	@RequestMapping("/menu/deleteMenu")
	public int deleteMenu(Integer id) {
		return menuService.deleteMenu(id);
	}
	
	@ResponseBody
	@RequestMapping("/menu/listPermissionByMenuId")
	public List<Integer> listPermissionByMenuId(Integer menuId){
		return menuService.listPermissionByMenuId(menuId);
	}
	
	@ResponseBody
	@RequestMapping("/menu/doAssignPermissionToMenu")
	public int assignPermissionToMenu(Integer menuId, String idStr){
		String[] idString = idStr.split(",");
		Integer[] permissionIds = new Integer[idString.length];
		for (int i = 0 ; i< idString.length ; i++) {
			permissionIds[i] = Integer.parseInt(idString[i]);
		}
		return menuService.assignPermissionToMenu(menuId, permissionIds);
	}

}
