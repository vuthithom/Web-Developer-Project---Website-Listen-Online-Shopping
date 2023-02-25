package com.demo.services.manager;

import org.springframework.core.ParameterizedTypeReference;
import org.springframework.http.HttpMethod;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import com.demo.models.BranchInfo;

@Service("manager/branchService")
public class BranchService implements IBranchService {
	
	private String BASE_URL = "http://localhost:9596/api/manager/branch/";

	@Override
	public ResponseEntity<Iterable<BranchInfo>> findAllInfo() {
		try {
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.exchange(BASE_URL + "findAll",
					HttpMethod.GET,
					null , 
					new ParameterizedTypeReference<Iterable<BranchInfo>>() {} );
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}
	
	@Override
	public ResponseEntity<BranchInfo> findInfoById(int id) {
		try {
			RestTemplate restTemplate = new RestTemplate();
			return restTemplate.getForEntity(BASE_URL + "findInfoById/" + id, BranchInfo.class);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return null;
		}
	}

	@Override
	public ResponseEntity<BranchInfo> create(BranchInfo object) {
		try {
			RestTemplate restTemplate = new RestTemplate();
			
			return restTemplate.postForEntity(BASE_URL + "create", object, BranchInfo.class);
		} catch (Exception e) {
			System.out.println("Create object error: " + e.getMessage());
			return new ResponseEntity<BranchInfo>(HttpStatus.BAD_REQUEST);
		}
	}

	@Override
	public ResponseEntity<Void> update(BranchInfo object) {
		try {
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.put(BASE_URL + "update/" + object.getId(), object);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}
	}

	@Override
	public ResponseEntity<Void> delete(int id) {
		try {
			RestTemplate restTemplate = new RestTemplate();
			restTemplate.delete(BASE_URL + "delete/" + id);
			return new ResponseEntity<Void>(HttpStatus.OK);
		} catch (Exception e) {
			System.out.println(e.getMessage());
			return new ResponseEntity<Void>(HttpStatus.BAD_REQUEST);
		}
	}
}
