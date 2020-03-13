package com.esicvr.service;

import java.text.ParseException;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Compra;
import com.esicvr.domain.CompraParcela;
import com.esicvr.service.dto.CompraPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ListaParcelasCompraDTO;

@Service
public interface CompraService {

	public GenericoRetornoPaginadoDTO<CompraPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public Boolean save(Compra compra);

	public Compra findCompraById(Integer id);

	public boolean update(Integer id, Compra dto);

	public boolean delete(Integer id);

	public Boolean incluirEmEstoque(Integer id);

	public List<ListaParcelasCompraDTO> obterListaParcelasCompra(Integer idCompra) throws ParseException;

	public boolean updatedByListCompraParcela(List<CompraParcela> lista);

	public boolean deleteCompraParcela(Integer id);

	public void saveOrUpdateCompraParcela(CompraParcela compraParcela);

}
