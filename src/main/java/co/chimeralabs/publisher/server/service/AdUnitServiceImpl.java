package co.chimeralabs.publisher.server.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.chimeralabs.publisher.server.model.AdUnit;
import co.chimeralabs.publisher.server.repository.AdUnitRepository;

@Service
public class AdUnitServiceImpl implements AdUnitService{

	@Autowired
	AdUnitRepository adUnitRepository;
	
	@Override
	public AdUnit save(AdUnit adUnit) {
		return adUnitRepository.save(adUnit);
	}

	@Override
	public List<AdUnit> getAdUnits(Long appId) {
		return adUnitRepository.getAdUnitsByAppId(appId);
	}

	@Override
	@Transactional
	public Integer deleteAdUnits(List<Long> ids) {
		for (Long id : ids) {
			adUnitRepository.delete(id);
		}
		return null;
	}

}
