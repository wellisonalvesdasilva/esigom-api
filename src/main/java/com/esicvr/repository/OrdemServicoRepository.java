package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.OrdemServico;

@Repository
public interface OrdemServicoRepository extends PagingAndSortingRepository<OrdemServico, Long> {
	Page<OrdemServico> findAll(Specification<OrdemServico> spec, Pageable pageable);

	OrdemServico findOrdemServicoById(Integer id);

}