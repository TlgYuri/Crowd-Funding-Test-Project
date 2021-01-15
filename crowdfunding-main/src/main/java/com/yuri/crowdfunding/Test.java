package com.yuri.crowdfunding;

import java.util.ArrayList;
import java.util.List;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;

public class Test {

	public static void main(String[] args) {
		List<String> list = new ArrayList<String>();
		System.out.println(list.size());
		BCryptPasswordEncoder bcpe = new BCryptPasswordEncoder();
		System.out.println(bcpe.encode("123456"));
	}

}