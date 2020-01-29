package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.CentroCusto;
import com.esicvr.domain.Entrada;
import com.esicvr.domain.FormaPagamento;

@Repository
public interface EntradaRepository extends JpaRepository<Entrada, Long> {

	Page<Entrada> findAll(Specification<Entrada> objPredicates, Pageable paging);

	Entrada findEntradaById(Integer id);

}