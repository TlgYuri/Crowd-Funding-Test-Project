package com.yuri.crowdfunding.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.yuri.crowdfunding.bean.TMenu;
import com.yuri.crowdfunding.bean.TPermissionMenuExample;
import com.yuri.crowdfunding.mapper.TMenuMapper;
import com.yuri.crowdfunding.mapper.TPermissionMenuMapper;
import com.yuri.crowdfunding.service.TMenuService;

@Service
public class TMenuServiceImpl implements TMenuService {

	@Autowired
	TMenuMapper menuMapper;

	@Autowired
	TPermissionMenuMapper pmMapper;

	@Override
	public List<TMenu> listAllMenu() {
		return menuMapper.selectByExample(null);
	}
	
	@Override
	public List<TMenu> listMenuParent() {
		List<TMenu> menuList = listAllMenu();

		List<TMenu> parentMenus = new ArrayList<TMenu>();
		for(TMenu menu : menuList) {
			if(menu.getPid() == 0) {
				parentMenus.add(menu);
			}
		}

		for(TMenu parent : parentMenus) {
			List<TMenu> childrenMenus = new ArrayList<TMenu>();
			for(TMenu menu : menuList) {
				if(menu.getPid() == parent.getId()) {
					childrenMenus.add(menu);
				}
			}
			parent.setMenus(childrenMenus);
		}
		
		return parentMenus;
	}

	@Override
	public int addMenu(TMenu menu) {
		return menuMapper.insertSelective(menu);
	}

	@Override
	public int updateMenu(TMenu menu) {
		return menuMapper.updateByPrimaryKeySelective(menu);
	}

	@Override
	public int deleteMenu(Integer id) {
		return menuMapper.deleteByPrimaryKey(id);
	}
	
	@Override
	public List<Integer> listPermissionByMenuId(Integer menuId) {
		return pmMapper.selectPermissionByMenuId(menuId);
	}

	@Override
	public int assignPermissionToMenu(Integer menuId, Integer[] permissionIds) {
		TPermissionMenuExample example = new TPermissionMenuExample();
		example.createCriteria().andMenuidEqualTo(menuId);
		pmMapper.deleteByExample(example);
		return pmMapper.assignPermissionToMenu(menuId, permissionIds);
	}
}
