package com.esicvr.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Compra;
import com.esicvr.domain.CompraParcela;

@Repository
public interface CompraParcelaRepository extends JpaRepository<CompraParcela, Long> {

	List<CompraParcela> findAllCompraParcelaByCompra(Compra compra);

	List<CompraParcela> findAllByCompra(Compra p);

	CompraParcela findById(Integer id);

}