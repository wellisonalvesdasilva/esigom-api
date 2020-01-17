package com.esicvr.service;

import java.util.Map;
import org.springframework.stereotype.Service;
import com.esicvr.domain.Orcamento;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.OrcamentoPesquisaDTO;

@Service
public interface OrcamentoService {

	public Boolean save(Orcamento orcamento);

	public Orcamento findOrcamentoById(Integer id);

	public boolean delete(Integer id);

	public boolean update(Integer id, Orcamento dto);

	public GenericoRetornoPaginadoDTO<OrcamentoPesquisaDTO> getAllPaginated(Map<String, String> parameters);

}
