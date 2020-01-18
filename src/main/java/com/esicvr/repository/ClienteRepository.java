package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Cliente;
import com.esicvr.domain.Perfil;

@Repository
public interface ClienteRepository extends PagingAndSortingRepository<Cliente, Long> {
	Page<Cliente> findAll(Specification<Cliente> spec, Pageable pageable);

	Cliente findUsuarioById(Integer id);

	Cliente findClienteById(Integer id);

	Cliente findClienteByCpf(String cpf);
}