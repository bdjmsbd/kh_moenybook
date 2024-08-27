package kr.kh.app.controller;

import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import kr.kh.app.service.MemberService;

@Controller
public class HomeController {
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/")
	public String home(Locale locale, Model model) {
		System.out.println(memberService.getEmail("peace123"));
		return "home";
	}
	
}
