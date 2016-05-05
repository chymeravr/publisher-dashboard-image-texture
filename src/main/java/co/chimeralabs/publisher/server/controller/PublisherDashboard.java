package co.chimeralabs.publisher.server.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.chimeralabs.publisher.server.formDTO.AM_DataRowActionDTO;
import co.chimeralabs.publisher.server.formDTO.AdUnitPerformanceDataDTO;
import co.chimeralabs.publisher.server.formDTO.AppPerformanceDataDTO;
import co.chimeralabs.publisher.server.model.AdType;
import co.chimeralabs.publisher.server.model.AdUnit;
import co.chimeralabs.publisher.server.model.App;
import co.chimeralabs.publisher.server.model.TextureImageFormat;
import co.chimeralabs.publisher.server.model.UserPrincipal;
import co.chimeralabs.publisher.server.repository.TextureImageFormatRepository;
import co.chimeralabs.publisher.server.service.AdUnitService;
import co.chimeralabs.publisher.server.service.AppService;
import co.chimeralabs.publisher.server.util.TypeConversion;

@Controller
public class PublisherDashboard {

	@Autowired
	AppService appService;
	@Autowired
	TextureImageFormatRepository textureImageFormatRepository;
	@Autowired
	AdUnitService adUnitService;

	@RequestMapping(value="/", method = RequestMethod.GET)
	public String home(){
		return "redirect:/dashboard/am/ui/_ac/gamt";
	}
	
	@RequestMapping(value="/dashboard/am/ui/_ac/{actionId}", method = RequestMethod.GET)
	public String mainDashboard(Model m, @PathVariable final String actionId, @RequestParam Map<String, String> params){
		UserPrincipal user = (UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long publisherId = user.getPublisherId();

		if(actionId.equals("gamt")){//get app management
			List<App> appTree = appService.getAppTree(publisherId);
			m.addAttribute("appTree", appTree);
			return "jsp/appManagementDashboard";
		}
		else if(actionId.equals("gapf")){//get app form
			return "jsp/addAppForm";
		}
		else if(actionId.equals("gauf")){//get ad unit form
			Long appId;
			if(params.get("appid") != null){
				appId = TypeConversion.StringToLong(params.get("appid"));
				m.addAttribute("appId", appId);
			}
			else{
				List<App> apps = appService.getApps(publisherId);
				m.addAttribute("apps", apps);
			}
			m.addAttribute("adTypeValues", AdType.getEnumValues());
			m.addAttribute("adTypeNames", AdType.getEnumNames());
			List<TextureImageFormat> textureImageFormats = textureImageFormatRepository.findAll();
			m.addAttribute("textureImageFormats", textureImageFormats);
			return "jsp/addAdUnitForm";
		}
		else if(actionId.equals("gaif")){//get ad instance form

		}
		return "";
	}

	@RequestMapping(value="/dashboard/am/data/_ac/gad", method=RequestMethod.GET)
	public @ResponseBody List<AppPerformanceDataDTO> getAppPerformanceData(){
		UserPrincipal user = (UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long publisherId = user.getPublisherId();
		List<App> apps = appService.getApps(publisherId);
		List<AppPerformanceDataDTO> dtos = AppPerformanceDataDTO.getListOfDTOs(apps);
		return dtos;
	}
	
	@RequestMapping(value="/dashboard/am/data/_ac/gaud", method=RequestMethod.GET)
	public @ResponseBody List<AdUnitPerformanceDataDTO> getAdUnitPerformanceData(@RequestParam Map<String, String> params){
		UserPrincipal user = (UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long publisherId = user.getPublisherId();
		List<AdUnit> adUnits;
		if(params.get("appId")!=null){
			Long appId = TypeConversion.StringToLong(params.get("appId"));
			adUnits = adUnitService.getAdUnits(appId);
		}
		else{
			List<App> apps = appService.getAppTree(publisherId);
			adUnits = new ArrayList<AdUnit>();
			for (App app : apps) {
				adUnits.addAll(app.getAdUnits());
			}
		}
		List<AdUnitPerformanceDataDTO> dtos = AdUnitPerformanceDataDTO.getListOfDTOs(adUnits);
		return dtos;
	}
	
	@RequestMapping(value="/dashboard/am/addapp", method = RequestMethod.POST)
	public String addApp(@ModelAttribute("app") App app){
		UserPrincipal user = (UserPrincipal) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		Long publisherId = user.getPublisherId();
		app = appService.save(app, publisherId);
		return "redirect:/dashboard/am/ui/_ac/gamt";
	}
	
	@RequestMapping(value="/dashboard/am/addAdUnit", method = RequestMethod.POST)
	public String addAdUnit(@ModelAttribute("adunit") AdUnit adUnit){
		adUnitService.save(adUnit);
		return "redirect:/dashboard/am/ui/_ac/gamt";
	}
	
	@RequestMapping(value="/dashboard/am/rowaction", method = RequestMethod.POST)
	@ResponseBody
	public String dataRowAction(@RequestBody AM_DataRowActionDTO data){
		String returnMessage = ""; //success if everything goes well
		if(data.getTarget().equals("app")){
			if(data.getAction().equals("delete")){
				appService.deleteApps(data.getIdList());
				returnMessage = "success";
			}
			else if(data.getAction().equals("activate")){
				
			}
			else if(data.getAction().equals("deactivate")){
				
			}
		}
		else if(data.getTarget().equals("adunit")){
			if(data.getAction().equals("delete")){
				adUnitService.deleteAdUnits(data.getIdList());
			}
			else if(data.getAction().equals("activate")){
				
			}
			else if(data.getAction().equals("deactivate")){
				
			}
		}
		else if(data.getTarget().equals("ad")){
			if(data.getAction().equals("delete")){
				//adService.deleteAds(data.getIdList());
				//returnMessage = "success";
			}
			else if(data.getAction().equals("activate")){
				
			}
			else if(data.getAction().equals("deactivate")){
				
			}
		}
		return returnMessage;
	}
	
}
