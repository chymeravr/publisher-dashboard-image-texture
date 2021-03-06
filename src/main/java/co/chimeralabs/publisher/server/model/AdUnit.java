package co.chimeralabs.publisher.server.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import co.chimeralabs.publisher.server.model.AdType;

@Entity
public class AdUnit implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 2387579422134728024L;

	@Id
	@GeneratedValue
	private Long adUnitId;
	
	private String name;
	
	@ManyToOne
	@JoinColumn(name="app_id")
	private App app;
	
	@OneToMany(mappedBy="adUnit", fetch=FetchType.LAZY, cascade={CascadeType.ALL})
	@Fetch(value=FetchMode.SUBSELECT)
	private List<AdUnitInstance> adUnitInstances;
	
	private AdType adType;
	
	private Integer resolutionWidth;
	private Integer resolutionHeight;
	
	public Long getAdUnitId() {
		return adUnitId;
	}

	public void setAdUnitId(Long adUnitId) {
		this.adUnitId = adUnitId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public App getApp() {
		return app;
	}

	public void setApp(App app) {
		this.app = app;
	}

	public List<AdUnitInstance> getAdUnitInstances() {
		return adUnitInstances;
	}

	public void setAdUnitInstances(List<AdUnitInstance> adUnitInstances) {
		this.adUnitInstances = adUnitInstances;
	}

	public AdType getAdType() {
		return adType;
	}

	public void setAdType(AdType adType) {
		this.adType = adType;
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
	
}
