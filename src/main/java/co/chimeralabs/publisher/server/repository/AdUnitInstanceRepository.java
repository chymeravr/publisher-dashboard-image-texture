package co.chimeralabs.publisher.server.repository;

import java.io.Serializable;
import java.util.List;

import javax.transaction.Transactional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import co.chimeralabs.publisher.server.model.AdUnitInstance;

@Repository
@Transactional
public interface AdUnitInstanceRepository extends JpaRepository<AdUnitInstance, Serializable>{
	@Query("select aui from "
			+ "AdUnitInstance aui where aui.adUnit.adUnitId=?1")
	public List<AdUnitInstance> getAdUnitInstancesByAdUnitId(Long adUnitId); 
}
