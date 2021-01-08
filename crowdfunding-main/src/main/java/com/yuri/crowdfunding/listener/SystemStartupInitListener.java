package com.yuri.crowdfunding.listener;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;


import com.yuri.crowdfunding.util.Const;

public class SystemStartupInitListener implements ServletContextListener {

	public void contextInitialized(ServletContextEvent sce) {
		ServletContext sc = sce.getServletContext();
		sc.setAttribute(Const.PATH, sc.getContextPath());
	}

	public void contextDestroyed(ServletContextEvent sce) {

	}
}
