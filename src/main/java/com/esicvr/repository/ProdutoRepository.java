package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.esicvr.domain.Produto;
@Repository
public interface ProdutoRepository extends JpaRepository<Produto, Long> {

	Produto findPecaById(Integer id);

	Page<Produto> findAll(Specification<Produto> objPredicates, Pageable paging);

}