package co.chimeralabs.publisher.server.formDTO;

import java.util.ArrayList;
import java.util.List;

import co.chimeralabs.publisher.server.model.App;

public class AppPerformanceDataDTO {
	private Long appId;
	private String appName;
	private Double impressions;
	private Double effectiveImpressions;
	private Double earnings;
	
	public AppPerformanceDataDTO(){
		
	}
	
	public static List<AppPerformanceDataDTO> getListOfDTOs(List<App> apps){
		if(apps==null) return null;
		List<AppPerformanceDataDTO> dtos = new ArrayList<AppPerformanceDataDTO>(apps.size());
		for(int i=0; i<apps.size(); i++){
			AppPerformanceDataDTO dto = new AppPerformanceDataDTO();
			App app = apps.get(i);
			dto.setAppId(app.getAppId());
			dto.setAppName(app.getName());
			dto.setImpressions(0.0);
			dto.setEarnings(0.0);
			dto.setEffectiveImpressions(0.0);
			dtos.add(dto);
		}
		return dtos;
	}
	
	public Long getAppId() {
		return appId;
	}
	public void setAppId(Long appId) {
		this.appId = appId;
	}
	public String getAppName() {
		return appName;
	}
	public void setAppName(String appName) {
		this.appName = appName;
	}
	public Double getEffectiveImpressions() {
		return effectiveImpressions;
	}
	public void setEffectiveImpressions(Double effectiveImpressions) {
		this.effectiveImpressions = effectiveImpressions;
	}
	public Double getEarnings() {
		return earnings;
	}
	public void setEarnings(Double earnings) {
		this.earnings = earnings;
	}

	public Double getImpressions() {
		return impressions;
	}

	public void setImpressions(Double impressions) {
		this.impressions = impressions;
	}
	
}
