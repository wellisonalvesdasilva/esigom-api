package com.esicvr.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Telefone;

@Repository
public interface TelefoneRepository extends JpaRepository<Telefone, Long> {

}