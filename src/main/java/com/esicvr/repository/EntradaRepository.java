package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Entrada;

@Repository
public interface EntradaRepository extends JpaRepository<Entrada, Long> {

	Entrada findEntradaById(Integer id);

	Page<Entrada> findAll(Specification<Entrada> objPredicates, Pageable paging);

}