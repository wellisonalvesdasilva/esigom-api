package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;
import com.esicvr.domain.ContaParcela;

@Repository
public interface ContaParcelaRepository extends PagingAndSortingRepository<ContaParcela, Long> {
	Page<ContaParcela> findAll(Specification<ContaParcela> spec, Pageable pageable);
	ContaParcela findContaParcelaById(Integer id);

}