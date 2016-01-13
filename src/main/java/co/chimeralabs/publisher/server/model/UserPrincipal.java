package co.chimeralabs.publisher.server.model;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

public class UserPrincipal extends User{

	/**
	 * 
	 */
	private static final long serialVersionUID = -2537878764445164458L;
	
	private Long publisherId;

	
	public UserPrincipal(String username, String password, boolean enabled, boolean accountNonExpired,
			boolean credentialsNonExpired, boolean accountNonLocked,
			Collection<? extends GrantedAuthority> authorities) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		// TODO Auto-generated constructor stub
	}
	
	public UserPrincipal(String username, String password, Collection<? extends GrantedAuthority> authorities, Long publisherId){
		super(username, password, true, true, true, true, authorities);
		this.setPublisherId(publisherId);
	}
	
	public Long getPublisherId() {
		return publisherId;
	}

	public void setPublisherId(Long publisherId) {
		this.publisherId = publisherId;
	}

}
