package co.chimeralabs.publisher.server.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;

import co.chimeralabs.publisher.server.model.UserLogin;

@Entity
public class Publisher implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4299840805059232804L;

	@Id
	@GeneratedValue
	public Long publisherId;
	
	@OneToOne(mappedBy="publisher")
	UserLogin userLogin;
	
	@OneToMany(mappedBy="publisher", fetch=FetchType.LAZY, cascade={CascadeType.ALL})
	@Fetch(value=FetchMode.SUBSELECT)
	private List<App> apps;

	public Long getPublisherId() {
		return publisherId;
	}

	public void setPublisherId(Long publisherId) {
		this.publisherId = publisherId;
	}

	public UserLogin getUserLogin() {
		return userLogin;
	}

	public void setUserLogin(UserLogin userLogin) {
		this.userLogin = userLogin;
	}

	public List<App> getApps() {
		return apps;
	}

	public void setApps(List<App> apps) {
		this.apps = apps;
	}
	
	
}
