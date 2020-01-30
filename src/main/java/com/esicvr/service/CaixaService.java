package com.esicvr.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Caixa;
import com.esicvr.service.dto.CaixaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Service
public interface CaixaService {

	public GenericoRetornoPaginadoDTO<CaixaPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public Boolean save(Caixa caixa);

}
