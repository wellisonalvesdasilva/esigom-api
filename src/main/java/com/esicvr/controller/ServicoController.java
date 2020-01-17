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

import com.esicvr.domain.Servico;
import com.esicvr.service.ServicoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ServicoPesquisaDTO;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/servicos")
public class ServicoController {

	@Autowired
	ServicoService _servicoService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<ServicoPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _servicoService.getAllPaginated(parameters);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Servico> getById(@PathVariable(value = "id") Integer id) {
		Servico servico = _servicoService.findPecaById(id);
		return ResponseEntity.ok().body(servico);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Servico dto) {
		_servicoService.save(dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Servico dto, @PathVariable("id") Integer id) {
		_servicoService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _servicoService.delete(id);
	}

}
