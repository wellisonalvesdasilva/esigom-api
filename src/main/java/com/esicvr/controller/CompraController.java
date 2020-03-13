package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.util.List;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.esicvr.domain.Compra;
import com.esicvr.domain.CompraParcela;
import com.esicvr.domain.EntradaProduto;
import com.esicvr.service.CompraService;
import com.esicvr.service.dto.CompraPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ListaParcelasCompraDTO;

@RestController
//@CrossOrigin
@RequestMapping(value = "/operador/compras")
public class CompraController {

	@Autowired
	CompraService _compraService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<CompraPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _compraService.getAllPaginated(parameters);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Compra compra) throws NoSuchAlgorithmException {
		_compraService.save(compra);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Compra> getById(@PathVariable(value = "id") Integer id) {
		Compra compra = _compraService.findCompraById(id);
		return ResponseEntity.ok().body(compra);
	}

	@RequestMapping(value = "/incluirEmEstoque/{id}", method = RequestMethod.POST)
	public Boolean incluirEmEstoque(@PathVariable(value = "id") Integer id) {
		Boolean retorno = _compraService.incluirEmEstoque(id);
		return retorno;
	}

	@RequestMapping(value = "/obterListaParcelasCompra/{id}", method = RequestMethod.GET)
	public List<ListaParcelasCompraDTO> obterListaParcelasCompra(@PathVariable(value = "id") Integer idCompra)
			throws ParseException {
		List<ListaParcelasCompraDTO> retorno = _compraService.obterListaParcelasCompra(idCompra);
		return retorno;
	}

	@RequestMapping(value = "/alterarListaCompraParcelas", method = RequestMethod.PUT)
	public boolean updatedByListCompraParcela(@RequestBody List<CompraParcela> lista) {
		return _compraService.updatedByListCompraParcela(lista);
	}
	
	@RequestMapping(value = "/adicionarAlterarCompraParcela", method = RequestMethod.POST)
	public void createdCompraParcela(@RequestBody CompraParcela compraParcela) {
		_compraService.saveOrUpdateCompraParcela(compraParcela);
	}

	@RequestMapping(value = "/excluirCompraParcela/{id}", method = RequestMethod.DELETE)
	public boolean deleteCompraParcelaById(@PathVariable("id") Integer id) {
		return _compraService.deleteCompraParcela(id);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Compra dto, @PathVariable("id") Integer id) {
		_compraService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _compraService.delete(id);
	}

}
