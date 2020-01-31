package com.esicvr.service;

import java.util.Map;

import org.springframework.stereotype.Service;
import com.esicvr.domain.Compra;
import com.esicvr.service.dto.CompraPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Service
public interface CompraService {

	public GenericoRetornoPaginadoDTO<CompraPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public Boolean save(Compra compra);

	public Compra findCompraById(Integer id);

	public boolean update(Integer id, Compra dto);

	public boolean delete(Integer id);

}
