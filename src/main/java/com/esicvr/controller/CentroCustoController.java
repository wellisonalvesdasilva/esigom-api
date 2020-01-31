package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.esicvr.domain.CentroCusto;
import com.esicvr.domain.Fornecedor;
import com.esicvr.domain.Orcamento;
import com.esicvr.service.CentroCustoService;
import com.esicvr.service.dto.CentroCustoPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.OrcamentoPesquisaDTO;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/centrosCusto")
public class CentroCustoController {

	@Autowired
	CentroCustoService _centroCustoService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<CentroCustoPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _centroCustoService.getAllPaginated(parameters);
	}
	
	@RequestMapping(value="/", method = RequestMethod.GET)
	public List<CentroCusto> getAll() {
		return _centroCustoService.getAll();
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody CentroCusto centroCusto) throws NoSuchAlgorithmException {
		_centroCustoService.save(centroCusto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<CentroCusto> getById(@PathVariable(value = "id") Integer id) {
		CentroCusto centroCusto = _centroCustoService.findCentroCustoById(id);
		return ResponseEntity.ok().body(centroCusto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody CentroCusto dto, @PathVariable("id") Integer id) {
		_centroCustoService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _centroCustoService.delete(id);
	}

}
