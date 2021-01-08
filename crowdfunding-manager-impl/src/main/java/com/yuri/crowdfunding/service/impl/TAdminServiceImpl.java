package com.yuri.crowdfunding.service.impl;

import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.github.pagehelper.PageInfo;
import com.yuri.crowdfunding.bean.TAdmin;
import com.yuri.crowdfunding.bean.TAdminExample;
import com.yuri.crowdfunding.bean.TAdminExample.Criteria;
import com.yuri.crowdfunding.exception.LoginException;
import com.yuri.crowdfunding.mapper.TAdminMapper;
import com.yuri.crowdfunding.service.TAdminService;
import com.yuri.crowdfunding.util.Const;
import com.yuri.crowdfunding.util.MD5Util;

@Service
public class TAdminServiceImpl implements TAdminService {

	@Autowired
	TAdminMapper adminMapper;

	Logger log = LoggerFactory.getLogger(TAdminServiceImpl.class);

	@Override
	public TAdmin getTAdminByLogin(Map<String, Object> params) {
		String loginAccount = (String) params.get("account");
		String loginPassword = (String) params.get("password");

		// 1.密码加密
		String pwd = MD5Util.digest(loginPassword.trim());
		// 2.查询用户
		TAdminExample example = new TAdminExample();
		Criteria criteria = example.createCriteria();
		criteria.andLoginacctEqualTo(loginAccount.trim());

		List<TAdmin> list = adminMapper.selectByExample(example);

		// 3.判断用户名、密码
		if (list == null || list.size() == 0) {
			throw new LoginException(Const.LOGIN_LOGINACCT_ERROR);
		}
		TAdmin admin = list.get(0);
		if (!admin.getUserpswd().equals(pwd)) {
			throw new LoginException(Const.LOGIN_USERPSWD_ERROR);
		}
		// 4.返回结果
		log.debug(admin.toString());

		return admin;
	}

	@Override
	public PageInfo<TAdmin> listAdminPage(Map<String, Object> params) {

		String condition = (String) params.get("condition");

		TAdminExample example = new TAdminExample();
		Criteria criteria = example.createCriteria().andIdNotEqualTo(-1);
		if (!StringUtils.isEmpty(condition.trim())) {

			criteria.andUsernameLike("%" + condition + "%");

			Criteria criteria2 = example.createCriteria();
			criteria2.andIdNotEqualTo(-1).andLoginacctLike("%" + condition + "%");

			Criteria criteria3 = example.createCriteria();
			criteria3.andIdNotEqualTo(-1).andEmailLike("%" + condition + "%");

			example.or(criteria2);
			example.or(criteria3);
		}

		List<TAdmin> list = adminMapper.selectByExample(example);

		log.debug("查询结果：{}",list);
		
		PageInfo<TAdmin> pInfo = new PageInfo<TAdmin>(list,6);

		log.debug("pInfo:{}",pInfo);

		return pInfo;
	}

	@Override
	public void saveTAdmin(TAdmin admin) {
		adminMapper.insertSelective(admin);
	}

	@Override
	public TAdmin selectTAdminById(Integer id) {
		return adminMapper.selectByPrimaryKey(id);
	}

	@Override
	public void updateTAdminById(TAdmin admin) {
		adminMapper.updateByPrimaryKeySelective(admin);
	}

	@Override
	public void deleteTAdminById(Integer id) {
		adminMapper.deleteByPrimaryKey(id);
	}
	
	@Override
	public void deleteTAdminBatchById(List<Integer> idList) {
		adminMapper.deleteBatchByPrimaryKey(idList);
	}
}
