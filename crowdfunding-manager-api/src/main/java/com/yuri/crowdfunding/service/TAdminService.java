package com.yuri.crowdfunding.service;

import java.util.List;
import java.util.Map;

import com.github.pagehelper.PageInfo;
import com.yuri.crowdfunding.bean.TAdmin;

public interface TAdminService {

	TAdmin getTAdminByLogin(Map<String, Object> params);

	PageInfo<TAdmin> listAdminPage(Map<String, Object> params);

	void saveTAdmin(TAdmin admin);

	TAdmin selectTAdminById(Integer id);

	void updateTAdminById(TAdmin admin);

	void deleteTAdminById(Integer id);

	void deleteTAdminBatchById(List<Integer> idList);
	
}