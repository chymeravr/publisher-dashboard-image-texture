package co.chimeralabs.publisher.server.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.chimeralabs.publisher.server.model.Publisher;
import co.chimeralabs.publisher.server.repository.PublisherRepository;

@Service
public class PublisherServiceImpl implements PublisherService{

	@Autowired
	PublisherRepository publisherRepository;
	
	@Override
	public Publisher savePublisher(Publisher publisher) {
		return publisherRepository.save(publisher);
	}

	@Override
	public Publisher getPublisher(Long publisherId) {
		return publisherRepository.findOne(publisherId);
	}

}
