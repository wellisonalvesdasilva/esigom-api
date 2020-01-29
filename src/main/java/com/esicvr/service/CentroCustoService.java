package com.esicvr.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.CentroCusto;
import com.esicvr.service.dto.CentroCustoPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Service
public interface CentroCustoService {

	public List<CentroCusto> getAll();

	public GenericoRetornoPaginadoDTO<CentroCustoPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public Boolean save(CentroCusto centroCusto);

	public CentroCusto findCentroCustoById(Integer id);

	public boolean update(Integer id, CentroCusto dto);

	public boolean delete(Integer id);

}
