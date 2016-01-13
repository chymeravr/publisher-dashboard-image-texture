package co.chimeralabs.publisher.server.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import co.chimeralabs.publisher.server.model.App;
import co.chimeralabs.publisher.server.model.UserPrincipal;
import co.chimeralabs.publisher.server.service.AppService;

@Controller
public class PublisherDashboard {

	@Autowired
	AppService appService;
	
	@RequestMapping(value="/dashboard/am/ui/_ac/{actionId}", method = RequestMethod.GET)
	public String mainDashboard(Model m, @PathVariable final String actionId, @RequestParam Map<String, String> params){
		UserPrincipal user = (UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long publisherId = user.getPublisherId();
		
		if(actionId.equals("gamt")){
			List<App> appTree = appService.getAppTree(publisherId);
			m.addAttribute("appTree", appTree);
			return "jsp/appManagementDashboard";
		}
		
		if(actionId.equals("gapf")){
			
		}
		
		return "";
	}
}
