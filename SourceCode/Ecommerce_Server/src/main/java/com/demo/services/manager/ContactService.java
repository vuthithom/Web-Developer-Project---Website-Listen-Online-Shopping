package com.demo.services.manager;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.demo.entities.Contacts;
import com.demo.repositories.manager.IContactRepository;

@Service("contact")
public class ContactService implements IContactService {

	@Autowired
	private IContactRepository repos;

	@Override
	public Contacts getContact() {
		return repos.findById(1).get();
	}

	@Override
	public Contacts update(Contacts contact) {
		return repos.save(contact);
	}

}
