package com.yuri.crowdfunding.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class CrowdFundingSecurityConfig extends WebSecurityConfigurerAdapter {

	@Autowired
	UserDetailsService securityUserDetailsServiceImpl;
	
	@Autowired
	AccessDeniedHandler accessDeniedHandler;

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(securityUserDetailsServiceImpl)
			.passwordEncoder(new BCryptPasswordEncoder());
	}

	/**
	 * 1、自定义请求授权访问规则
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests()
			.antMatchers("/static/**", "/welcome.jsp", "/index", "/toLogin", "/toRegist").permitAll()
			.anyRequest().authenticated();// 剩下都需要认证

		http.formLogin()
			.loginPage("/toLogin")
			.loginProcessingUrl("/login")
			.usernameParameter("loginAccount")
			.passwordParameter("loginPassword")
			.defaultSuccessUrl("/main")
			.permitAll();

		//http.csrf().disable();

		http.logout()
			.logoutSuccessUrl("/index");

		http.exceptionHandling().accessDeniedHandler(accessDeniedHandler);
	}
}