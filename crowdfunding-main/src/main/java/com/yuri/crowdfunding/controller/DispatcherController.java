package com.yuri.crowdfunding.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.yuri.crowdfunding.bean.TAdmin;
import com.yuri.crowdfunding.bean.TMenu;
import com.yuri.crowdfunding.component.TSecurityAdmin;
import com.yuri.crowdfunding.service.TAdminService;
import com.yuri.crowdfunding.service.TMenuService;
import com.yuri.crowdfunding.util.Const;

@Controller
public class DispatcherController {

	Logger log = LoggerFactory.getLogger(DispatcherController.class);

	@Autowired
	TMenuService menuService;

	@Autowired
	TAdminService adminService;

	@RequestMapping("/index")
	public String index() {
		log.debug("跳转到主页面");
		return "index";
	}

	@RequestMapping("/toLogin")
	public String login() {
		log.debug("跳转到登录页面");
		return "login";
	}

	@RequestMapping("/toRegist")
	public String regist() {
		log.debug("跳转到注册页面");
		return "regist";
	}

	@RequestMapping("/main")
	public String main(HttpSession session) {
		log.debug("跳转到管理员后台页面");
		if (session != null) {
			if(session.getAttribute("menus") == null) {
				SecurityContextImpl sc = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
				TSecurityAdmin admin = (TSecurityAdmin) sc.getAuthentication().getPrincipal();
				Integer adminId = admin.getAdmin().getId();
				List<TMenu> menus = menuService.listMenuParentByAdminId(adminId);
				log.debug("查询到的管理员信息：{}",menus);
				session.setAttribute("menus", menus);
				return "main";
			} else {
				return "main";
			}
		} else {
			return "redirect:/toLogin";
		}
	}
	
	@RequestMapping("/doLogin")
	public String doLogin(String loginAccount, String loginPassword, HttpSession session, HttpServletRequest request) {
		log.debug("用户登录,account={},password={}", loginAccount, loginPassword);

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("account", loginAccount);
			params.put("password", loginPassword);
			TAdmin admin = adminService.getTAdminByLogin(params);
			log.debug("匹配到的用户信息{}",admin);
			log.debug("登录成功");
			session.setAttribute(Const.LOGIN_ADMIN, admin);
			return "redirect:/main";
		} catch (Exception e) {
			e.printStackTrace();
			log.debug("登陆失败{}",e.getMessage());
			request.setAttribute(Const.LOGIN_ERROR, e.getMessage());
			return "toLogin";
		}
	}

	@RequestMapping("/doLogout")
	public String logout(HttpSession session) {
		log.debug("注销");
		if (session != null) {
			session.invalidate();
		}
		return "redirect:/index";
	}
}
