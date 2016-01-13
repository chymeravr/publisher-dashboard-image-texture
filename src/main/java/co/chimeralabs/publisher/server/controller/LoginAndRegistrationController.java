package co.chimeralabs.publisher.server.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import co.chimeralabs.publisher.server.model.UserLogin;
import co.chimeralabs.publisher.server.service.UserLoginAndRegistrationService;


@Controller
public class LoginAndRegistrationController {
	@Autowired
	UserLoginAndRegistrationService userLoginAndRegistration;
	
	@RequestMapping(value="/register", method=RequestMethod.GET)
	public String register(Model m){
		return "jsp/register";
	}
	
	@RequestMapping(value="/register", method=RequestMethod.POST)
	public String register(@RequestParam Map<String, String> params){
		UserLogin userLogin = new UserLogin();
		userLogin.setUserId(params.get("username"));
		userLogin.setPasswordHash(params.get("password"));
		userLoginAndRegistration.registerUser(userLogin);
		return "redirect:/login";
	}
	
	@RequestMapping(value="/login/{error}", method = RequestMethod.GET)
	  public String errorInLogin(Model model ,@PathVariable final String error){
	    model.addAttribute("error", error);
	    return "jsp/login";
	  }

	  @RequestMapping(value="/login", method = RequestMethod.GET)
	  public String login(Model m){
	    return "jsp/login";
	  }
}
