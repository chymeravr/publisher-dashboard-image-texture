package co.chimeralabs.publisher.server.formDTO;

import java.util.ArrayList;
import java.util.List;

import co.chimeralabs.publisher.server.model.AdUnit;

public class AdUnitPerformanceDataDTO {
	private Long appId;
	private String appName;
	private Long adUnitId;
	private String adUnitName;
	private Double impressions;
	private Double effectiveImpressions;
	private Double earnings;
	private String adUnitType;
	private Integer resolutionWidth;
	private Integer resolutionHeight;
	
	public AdUnitPerformanceDataDTO(){
		
	}
	
	public static List<AdUnitPerformanceDataDTO> getListOfDTOs(List<AdUnit> adUnits){
		if(adUnits == null)
			return null;
		List<AdUnitPerformanceDataDTO> dtos = new ArrayList<AdUnitPerformanceDataDTO>(adUnits.size());
		for(int index=0; index<adUnits.size(); index++){
			AdUnitPerformanceDataDTO dto = new AdUnitPerformanceDataDTO();
			AdUnit adUnit = adUnits.get(index);
			dto.setAppId(adUnit.getApp().getAppId());
			dto.setAppName(adUnit.getApp().getName());
			dto.setAdUnitId(adUnit.getAdUnitId());
			dto.setAdUnitName(adUnit.getName());
			dto.setImpressions(0.0);
			dto.setEffectiveImpressions(0.0);
			dto.setEarnings(0.0);
			dto.setAdUnitType(adUnit.getAdType().toString());
			dto.setResolutionHeight(adUnit.getResolutionHeight());
			dto.setResolutionWidth(adUnit.getResolutionWidth());
			dtos.add(dto);
		}
		return dtos;
	}
	
	public Long getAdUnitId() {
		return adUnitId;
	}
	public void setAdUnitId(Long adUnitId) {
		this.adUnitId = adUnitId;
	}
	public String getAdUnitName() {
		return adUnitName;
	}
	public void setAdUnitName(String adUnitName) {
		this.adUnitName = adUnitName;
	}
	public Double getImpressions() {
		return impressions;
	}
	public void setImpressions(Double impressions) {
		this.impressions = impressions;
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

	public String getAdUnitType() {
		return adUnitType;
	}

	public void setAdUnitType(String adUnitType) {
		this.adUnitType = adUnitType;
	}

	public Integer getResolutionWidth() {
		return resolutionWidth;
	}

	public void setResolutionWidth(Integer resolutionWidth) {
		this.resolutionWidth = resolutionWidth;
	}

	public Integer getResolutionHeight() {
		return resolutionHeight;
	}

	public void setResolutionHeight(Integer resolutionHeight) {
		this.resolutionHeight = resolutionHeight;
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
	
	
}
