package co.chimeralabs.publisher.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.chimeralabs.publisher.server.model.Publisher;
import co.chimeralabs.publisher.server.model.SecurityGroup;
import co.chimeralabs.publisher.server.model.UserLogin;
import co.chimeralabs.publisher.server.repository.SecurityGroupRepository;
import co.chimeralabs.publisher.server.repository.UserLoginRepository;

@Service
public class UserLoginAndRegistrationServiceImpl implements UserLoginAndRegistrationService{

	@Autowired
	PublisherService publisherService;
	
	@Autowired
	SecurityGroupRepository securityGroupRepository;
	
	@Autowired
	UserLoginRepository userLoginRepository;
	
	@Override
	public UserLogin registerUser(UserLogin userLogin) {
		Publisher publisher = new Publisher();
		publisher = publisherService.savePublisher(publisher);
		userLogin.setPublisher(publisher);
		SecurityGroup securityGroup = securityGroupRepository.findByName("publisher");
		userLogin.addSecurityGroup(securityGroup);
		userLogin = userLoginRepository.save(userLogin);
		return userLogin;
	}

}
