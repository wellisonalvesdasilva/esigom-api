package com.esicvr.controller;

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

import com.esicvr.domain.Produto;
import com.esicvr.service.ProdutoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ProdutoPesquisaDTO;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/produtos")
public class ProdutoController {

	@Autowired
	ProdutoService _pecaService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<ProdutoPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _pecaService.getAllPaginated(parameters);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Produto> getById(@PathVariable(value = "id") Integer id) {
		Produto peca = _pecaService.findPecaById(id);
		return ResponseEntity.ok().body(peca);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Produto dto) {
		_pecaService.save(dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Produto dto, @PathVariable("id") Integer id) {
		_pecaService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _pecaService.delete(id);
	}

}
