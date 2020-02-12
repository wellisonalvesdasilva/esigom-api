package com.esicvr.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.esicvr.domain.Caixa;
import com.esicvr.domain.CompraParcela;
import com.esicvr.domain.ContaParcela;
import com.esicvr.domain.Orcamento;

@Repository
public interface CaixaRepository extends JpaRepository<Caixa, Long> {

	Caixa findCaixaById(Integer id);

	Page<Caixa> findAll(Specification<Caixa> objPredicates, Pageable paging);

	Caixa findCaixaByOrcamento(Orcamento orcamento);

	Caixa findCaixaByContaParcela(ContaParcela contaParcela);

	Caixa findCaixaByCompraParcela(CompraParcela compraParcela);

	void deleteAllByCompraParcela(List<CompraParcela> parcelas);

}