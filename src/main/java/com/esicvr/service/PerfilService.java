package com.esicvr.service;

import java.util.List;
import org.springframework.stereotype.Service;

import com.esicvr.domain.Perfil;

@Service
public interface PerfilService {

	public List<Perfil> findAll();

	public Perfil save(Perfil perfil);

	public Perfil findPerfilById(Long id);

	public Boolean delete(Long id);

	public Boolean update(Long id, Perfil dto);

}
