package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Fornecedor;

@Repository
public interface FornecedorRepository extends PagingAndSortingRepository<Fornecedor, Long> {

	Page<Fornecedor> findAll(Specification<Fornecedor> spec, Pageable pageable);

	Fornecedor findFornecedorById(Integer id);

}