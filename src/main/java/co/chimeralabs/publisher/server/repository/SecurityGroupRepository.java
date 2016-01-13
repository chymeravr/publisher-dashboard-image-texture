package co.chimeralabs.publisher.server.repository;

import java.io.Serializable;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import co.chimeralabs.publisher.server.model.SecurityGroup;

@Repository
@Transactional
public interface SecurityGroupRepository extends JpaRepository<SecurityGroup, Serializable> {
	public SecurityGroup findByName(String name);
}
