package com.esicvr.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.esicvr.domain.Perfil;
import com.esicvr.repository.PerfilRepository;
import com.esicvr.service.PerfilService;

@Component
public class PerfilServiceImpl implements PerfilService {

	@Autowired
	PerfilRepository _perfilRepository;

	public List<Perfil> findAll() {
		List<Perfil> listPerfis = _perfilRepository.findAll();
		return listPerfis;
	}

	public Perfil save(Perfil perfil) {
		return _perfilRepository.save(perfil);
	}

	public Perfil findPerfilById(Long id) {
		return _perfilRepository.findPerfilById(id);
	}

	public Boolean delete(Long id) {
		Perfil p = _perfilRepository.findPerfilById(id);
		if (p != null) {
			_perfilRepository.delete(p);
			return true;
		}
		return false;
	}

	public Boolean update(Long id, Perfil dto) {
		Perfil p = _perfilRepository.findPerfilById(id);
		if (p != null) {
			p = dto;
			_perfilRepository.save(p);
			return true;
		}
		return false;
	}
}
