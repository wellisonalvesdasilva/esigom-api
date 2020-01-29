package com.esicvr.controller;

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

import com.esicvr.domain.Fornecedor;
import com.esicvr.domain.Produto;
import com.esicvr.service.FornecedorService;
import com.esicvr.service.ProdutoService;
import com.esicvr.service.dto.FornecedorPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ProdutoPesquisaDTO;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/fornecedores")
public class FornecedorController {

	@Autowired
	FornecedorService _fornecedorService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<FornecedorPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _fornecedorService.getAllPaginated(parameters);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Fornecedor> getById(@PathVariable(value = "id") Integer id) {
		Fornecedor fornecedor = _fornecedorService.findFornecedorById(id);
		return ResponseEntity.ok().body(fornecedor);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Fornecedor fornecedor) {
		_fornecedorService.save(fornecedor);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Fornecedor fornecedor, @PathVariable("id") Integer id) {
		_fornecedorService.update(id, fornecedor);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _fornecedorService.delete(id);
	}

}
