package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import com.esicvr.domain.Conta;

@Repository
public interface ContaRepository extends PagingAndSortingRepository<Conta, Long> {
	Page<Conta> findAll(Specification<Conta> spec, Pageable pageable);
	Conta findContaById(Integer id);

}