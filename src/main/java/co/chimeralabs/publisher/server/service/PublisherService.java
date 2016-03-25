package co.chimeralabs.publisher.server.service;

import co.chimeralabs.publisher.server.model.Publisher;

public interface PublisherService {
	public Publisher savePublisher(Publisher publisher);
	public Publisher getPublisher(Long publisherId);
}
