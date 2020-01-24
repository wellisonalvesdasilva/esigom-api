package com.esicvr.service;

import java.util.Map;
import org.springframework.stereotype.Service;
import com.esicvr.domain.Orcamento;
import com.esicvr.domain.OrdemServico;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.OrcamentoPesquisaDTO;
import com.esicvr.service.dto.OrdemServicoPesquisaDTO;

@Service
public interface OrdemServicoService {

	public Boolean save(OrdemServico orcamento);

	public OrdemServico findOrdemServicoById(Integer id);

	public boolean delete(Integer id);

	public boolean update(Integer id, OrdemServico dto);

	public GenericoRetornoPaginadoDTO<OrdemServicoPesquisaDTO> getAllPaginated(Map<String, String> parameters);

}
