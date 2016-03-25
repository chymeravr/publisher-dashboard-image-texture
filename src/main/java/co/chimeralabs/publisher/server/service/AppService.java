package co.chimeralabs.publisher.server.service;

import java.util.List;

import co.chimeralabs.publisher.server.model.App;

public interface AppService {
	public App getApp(Long appId);
	public List<App> getApps(Long publisherId);
	public List<App> getAppTree(Long publisherId);
	public App save(App app, Long publisherId);
	public Integer deleteApps(List<Long> ids);
}
