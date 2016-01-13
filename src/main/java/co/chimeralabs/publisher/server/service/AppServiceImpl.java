package co.chimeralabs.publisher.server.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import co.chimeralabs.publisher.server.model.AdUnit;
import co.chimeralabs.publisher.server.model.App;
import co.chimeralabs.publisher.server.repository.AppRepository;

@Service
public class AppServiceImpl implements AppService{

	@Autowired
	AppRepository appRepository;
	
	@Override
	public App getApp(Long appId) {
		return appRepository.getOne(appId);
	}

	@Override
	public List<App> getApps(Long publisherId) {
		return appRepository.getAppsByPublisherId(publisherId);
	}

	@Override
	@Transactional
	public List<App> getAppTree(Long publisherId) {
		List<App> apps = appRepository.getAppsByPublisherId(publisherId);
		for (App app : apps) {
			List<AdUnit> adUnits = app.getAdUnits();
			adUnits.size();
		}
		return apps;
	}

	@Override
	public App save(App app) {
		return appRepository.save(app);
	}

}
