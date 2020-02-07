package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.CentroCusto;

@Repository
public interface CentroCustoRepository extends JpaRepository<CentroCusto, Long> {

	CentroCusto findCentroCustoById(Integer id);

	Page<CentroCusto> findAll(Specification<CentroCusto> objPredicates, Pageable paging);

}