package co.chimeralabs.publisher.server.service;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import co.chimeralabs.publisher.server.model.SecurityGroup;
import co.chimeralabs.publisher.server.model.UserLogin;
import co.chimeralabs.publisher.server.model.UserPrincipal;
import co.chimeralabs.publisher.server.repository.UserLoginRepository;


@Service(value="userDetailsService")
public class UserDetailsServiceImpl implements UserDetailsService{

	@Autowired
	private UserLoginRepository userLoginRepository;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserLogin userLogin = userLoginRepository.findByUserId(username);
		if(userLogin == null)
			throw new UsernameNotFoundException(username);
		 Set<GrantedAuthority> grantedAuthorities = new HashSet<GrantedAuthority>();
		    Collection<SecurityGroup> securityGroups = userLogin.getSecurityGroups();
		    
		    for(SecurityGroup sg: securityGroups) {
		      for(String authority: sg.getAuthorities()) {
		        grantedAuthorities.add(new SimpleGrantedAuthority(authority));
		      }
		    }
		    UserPrincipal userPrincipal = new UserPrincipal(username, userLogin.getPasswordHash(), grantedAuthorities, userLogin.getPublisher().getPublisherId());
		return userPrincipal;
	}

}
