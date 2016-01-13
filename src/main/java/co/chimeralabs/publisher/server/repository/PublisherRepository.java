package co.chimeralabs.publisher.server.repository;

import java.io.Serializable;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import co.chimeralabs.publisher.server.model.Publisher;

@Repository
@Transactional
public interface PublisherRepository extends JpaRepository<Publisher, Serializable>{
	
}
