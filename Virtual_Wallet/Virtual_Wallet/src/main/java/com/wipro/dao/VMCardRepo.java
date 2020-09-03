package com.wipro.dao;


import java.util.Optional;

import org.springframework.data.repository.CrudRepository;


import com.wipro.model.CardEntity;

public interface VMCardRepo extends CrudRepository<CardEntity, String> {
	Iterable<CardEntity> findAll();	
	Optional<CardEntity> findById(String cardNumber);
}
