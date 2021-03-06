package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.esicvr.domain.Servico;
@Repository
public interface ServicoRepository extends JpaRepository<Servico, Long> {

	Servico findServicoById(Integer id);

	Page<Servico> findAll(Specification<Servico> objPredicates, Pageable paging);

}