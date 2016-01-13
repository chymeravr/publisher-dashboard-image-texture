package co.chimeralabs.publisher.server.repository;

import java.io.Serializable;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import co.chimeralabs.publisher.server.model.App;

@Repository
@Transactional
public interface AppRepository extends JpaRepository<App, Serializable>{
	@Query("select a from "
			+ "App a where a.publisher.publisherId=?1")
	public List<App> getAppsByPublisherId(Long publisherId);
}
