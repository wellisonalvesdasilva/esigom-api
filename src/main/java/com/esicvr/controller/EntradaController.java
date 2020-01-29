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

import com.esicvr.domain.Entrada;
import com.esicvr.service.EntradaService;
import com.esicvr.service.dto.EntradaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/entradas")
public class EntradaController {

	@Autowired
	EntradaService _entradaService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<EntradaPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _entradaService.getAllPaginated(parameters);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public void created(@RequestBody Entrada entrada) throws NoSuchAlgorithmException {
		_entradaService.save(entrada);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Entrada> getById(@PathVariable(value = "id") Integer id) {
		Entrada entrada = _entradaService.findEntradaById(id);
		return ResponseEntity.ok().body(entrada);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Entrada entrada, @PathVariable("id") Integer id) {
		_entradaService.update(id, entrada);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _entradaService.delete(id);
	}

}
