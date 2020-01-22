package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Orcamento;

@Repository
public interface OrcamentoRepository extends PagingAndSortingRepository<Orcamento, Long> {
	Page<Orcamento> findAll(Specification<Orcamento> spec, Pageable pageable);

	Orcamento findOrcamentoById(Integer id);

}