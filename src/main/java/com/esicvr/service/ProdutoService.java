package com.esicvr.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Produto;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ProdutoPesquisaDTO;

@Service
public interface ProdutoService {

	public Boolean save(Produto perfil);

	public Produto findPecaById(Integer id);

	public boolean delete(Integer id);

	public boolean update(Integer id, Produto dto);

	public GenericoRetornoPaginadoDTO<ProdutoPesquisaDTO> getAllPaginated(Map<String, String> parameters);

}
