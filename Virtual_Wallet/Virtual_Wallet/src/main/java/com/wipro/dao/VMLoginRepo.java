package com.wipro.dao;

import java.util.Optional;

import org.springframework.data.repository.CrudRepository;

import com.wipro.model.LoginEntity;



public interface VMLoginRepo extends CrudRepository<LoginEntity,String> {
	Optional<LoginEntity> findByUsername(String username);

}
