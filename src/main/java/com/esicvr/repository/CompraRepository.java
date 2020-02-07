package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Compra;

@Repository
public interface CompraRepository extends JpaRepository<Compra, Long> {

	Compra findCompraById(Integer id);

	Page<Compra> findAll(Specification<Compra> objPredicates, Pageable paging);

}