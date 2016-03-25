package co.chimeralabs.publisher.server.service;

import java.util.List;

import co.chimeralabs.publisher.server.model.AdUnit;

public interface AdUnitService {
	AdUnit save(AdUnit adUnit);
	List<AdUnit> getAdUnits(Long appId);
	Integer deleteAdUnits(List<Long> ids);
}
