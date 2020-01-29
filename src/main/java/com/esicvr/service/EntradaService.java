package com.esicvr.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Entrada;
import com.esicvr.service.dto.EntradaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Service
public interface EntradaService {

	public List<Entrada> getAll();

	public GenericoRetornoPaginadoDTO<EntradaPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public Boolean save(Entrada entrada);

	public Entrada findEntradaById(Integer id);

	public boolean update(Integer id, Entrada dto);

	public boolean delete(Integer id);

}
