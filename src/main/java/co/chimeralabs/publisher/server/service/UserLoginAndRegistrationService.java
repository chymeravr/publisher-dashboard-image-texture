package co.chimeralabs.publisher.server.service;

import co.chimeralabs.publisher.server.model.UserLogin;

public interface UserLoginAndRegistrationService {
	public UserLogin registerUser(UserLogin userLogin);
}
