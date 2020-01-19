package com.esicvr.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import com.esicvr.domain.Servico;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ServicoPesquisaDTO;

@Service
public interface ServicoService {

	public Boolean save(Servico servico);

	public Servico findPecaById(Integer id);

	public boolean delete(Integer id);

	public boolean update(Integer id, Servico dto);

	public GenericoRetornoPaginadoDTO<ServicoPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public List<Servico> getAll();

}
