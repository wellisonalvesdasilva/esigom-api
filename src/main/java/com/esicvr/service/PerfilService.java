package com.esicvr.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Perfil;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.PerfilPesquisaDTO;

@Service
public interface PerfilService {

	public List<Perfil> findAll();

	public Perfil save(Perfil perfil);

	public Perfil findPerfilById(Integer id);

	public Boolean delete(Integer id);

	public Boolean update(Integer id, Perfil dto);

	public GenericoRetornoPaginadoDTO<PerfilPesquisaDTO> getAllPaginated(Map<String, String> parameters);

}
