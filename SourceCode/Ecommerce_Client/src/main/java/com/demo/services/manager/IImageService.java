package com.demo.services.manager;

import org.springframework.http.ResponseEntity;

import com.demo.models.ImageInfo;

public interface IImageService {

	public ResponseEntity<Iterable<ImageInfo>> findAllInfo();
	
	public ResponseEntity<Iterable<ImageInfo>> findAllInfoByBannerId(int id);

	public ResponseEntity<ImageInfo> findInfoById(int id);

	public ResponseEntity<ImageInfo> create(ImageInfo img);
	
	public ResponseEntity<Void> update(ImageInfo img);
	
	public ResponseEntity<Void> delete(int id);
	
	public ResponseEntity<Void> deleteByBannerId(int bannerId);
}
