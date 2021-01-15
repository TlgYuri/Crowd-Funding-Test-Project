package com.yuri.crowdfunding.component;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.stereotype.Component;

@Component
public class CrowdfundingAccessDeniedHandler implements AccessDeniedHandler {

	@Override
	public void handle(HttpServletRequest request, 
			HttpServletResponse response, AccessDeniedException accessDeniedException) 
			throws IOException, ServletException {
		request.setAttribute("errorMessage", accessDeniedException.getMessage());
		
		if("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
			response.getWriter().write("403");
		} else {
			request.getRequestDispatcher("/WEB-INF/jsp/error/403.jsp").forward(request, response);
		}
	}

}
