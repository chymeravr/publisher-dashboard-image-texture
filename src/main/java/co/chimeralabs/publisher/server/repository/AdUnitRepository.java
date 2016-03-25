package co.chimeralabs.publisher.server.repository;

import java.io.Serializable;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import co.chimeralabs.publisher.server.model.AdUnit;

@Repository
@Transactional
public interface AdUnitRepository extends JpaRepository<AdUnit, Serializable>{
	@Query("select au from "
			+ "AdUnit au where au.app.appId=?1"
	)
	public List<AdUnit> getAdUnitsByAppId(Long appId);
}
