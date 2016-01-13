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

@Entity
public class App implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = -753080956665923078L;
	
	@Id
	@GeneratedValue
	private Long appId;
	
	private String name;
	
	private String appUrl;
	
	private String platform;
	
	@ManyToOne
	@JoinColumn(name="publisher_id")
	private Publisher publisher;
	
	@OneToMany(mappedBy="app", fetch=FetchType.LAZY, cascade={CascadeType.ALL})
	@Fetch(value=FetchMode.SUBSELECT)
	private List<AdUnit> adUnits;

	public Long getAppId() {
		return appId;
	}

	public void setAppId(Long appId) {
		this.appId = appId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Publisher getPublisher() {
		return publisher;
	}

	public void setPublisher(Publisher publisher) {
		this.publisher = publisher;
	}

	public List<AdUnit> getAdUnits() {
		return adUnits;
	}

	public void setAdUnits(List<AdUnit> adUnits) {
		this.adUnits = adUnits;
	}
	
	
}
