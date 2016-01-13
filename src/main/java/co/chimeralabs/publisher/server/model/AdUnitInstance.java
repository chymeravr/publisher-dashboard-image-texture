package co.chimeralabs.publisher.server.model;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class AdUnitInstance implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2548716311800459036L;

	@Id
	@GeneratedValue
	private Long adUnitInstanceId;
	
	private String name;
	
	@ManyToOne
	@JoinColumn(name="ad_unit_id")
	private AdUnit adUnit;

	public Long getAdUnitInstanceId() {
		return adUnitInstanceId;
	}

	public void setAdUnitInstanceId(Long adUnitInstanceId) {
		this.adUnitInstanceId = adUnitInstanceId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public AdUnit getAdUnit() {
		return adUnit;
	}

	public void setAdUnit(AdUnit adUnit) {
		this.adUnit = adUnit;
	}
	
}
