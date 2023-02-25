package com.demo.validators;

import org.springframework.stereotype.Component;
import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.demo.entities.Contacts;

@Component("contactValidator")
public class ContactValidator implements Validator {

	@Override
	public boolean supports(Class<?> clazz) {
		boolean result = clazz.equals(Contacts.class);
		return result;
	}

	@Override
	public void validate(Object target, Errors errors) {
	}

}
