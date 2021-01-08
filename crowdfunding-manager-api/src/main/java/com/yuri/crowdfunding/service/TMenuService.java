package com.yuri.crowdfunding.service;

import java.util.List;

import com.yuri.crowdfunding.bean.TMenu;

public interface TMenuService {

	List<TMenu> listAllMenu();
	
	List<TMenu> listMenuParent();

	int addMenu(TMenu menu);

	int updateMenu(TMenu menu);

	int deleteMenu(Integer id);

	List<Integer> listPermissionByMenuId(Integer menuId);

	int assignPermissionToMenu(Integer menuId, Integer[] permissionIds);

}
