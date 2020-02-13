package com.esicvr.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.esicvr.domain.EntradaProduto;

@Repository
public interface EntradaProdutoRepository extends JpaRepository<EntradaProduto, Long> {
	EntradaProduto findEntradaProdutoById(Integer id);

}