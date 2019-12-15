package com.esicvr.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import com.esicvr.domain.Usuario;

@Repository
public interface UsuarioRepository extends PagingAndSortingRepository<Usuario, Long> {

	Page<Usuario> findAll(Specification<Usuario> spec, Pageable pageable);
	Usuario findUsuarioById(Integer id);
}