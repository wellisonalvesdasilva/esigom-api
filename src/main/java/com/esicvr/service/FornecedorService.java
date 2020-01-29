package com.esicvr.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Fornecedor;
import com.esicvr.domain.Produto;
import com.esicvr.service.dto.FornecedorPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Service
public interface FornecedorService {

	public Boolean save(Fornecedor fornecedor);

	public Fornecedor findFornecedorById(Integer id);

	public boolean delete(Integer id);

	public boolean update(Integer id, Fornecedor dto);

	public GenericoRetornoPaginadoDTO<FornecedorPesquisaDTO> getAllPaginated(Map<String, String> parameters);

}
