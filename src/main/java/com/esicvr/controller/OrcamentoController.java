package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
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
import com.esicvr.domain.Orcamento;
import com.esicvr.service.OrcamentoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.OrcamentoPesquisaDTO;

@RestController
//@CrossOrigin
@RequestMapping(value = "/operador/orcamentos")
public class OrcamentoController {

	@Autowired
	OrcamentoService _orcamentoService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<OrcamentoPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _orcamentoService.getAllPaginated(parameters);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Orcamento orcamento) throws NoSuchAlgorithmException {
		_orcamentoService.save(orcamento);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public Orcamento getById(@PathVariable(value = "id") Integer id) {
		Orcamento orcamento = _orcamentoService.findOrcamentoById(id);
		return orcamento;
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Orcamento dto, @PathVariable("id") Integer id) {
		_orcamentoService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _orcamentoService.delete(id);
	}

}
