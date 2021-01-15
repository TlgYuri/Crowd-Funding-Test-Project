package com.yuri.crowdfunding.service;

import java.util.List;

import com.yuri.crowdfunding.bean.TMenu;

public interface TMenuService {
	
	int addMenu(TMenu menu);

	int updateMenu(TMenu menu);

	int deleteMenu(Integer id);
	
	int assignPermissionToMenu(Integer menuId, Integer[] permissionIds);
	
	List<TMenu> listAllMenu();
	
	List<TMenu> listMenuByAdminId(Integer adminId);

	List<Integer> listPermissionByMenuId(Integer menuId);

	List<TMenu> listMenuParentByAdminId(Integer adminId);

}
