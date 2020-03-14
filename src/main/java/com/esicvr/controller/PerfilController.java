package com.esicvr.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.esicvr.domain.Perfil;
import com.esicvr.service.PerfilService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.PerfilPesquisaDTO;

@RestController
//@CrossOrigin
@RequestMapping(value = "/adm/perfis")
public class PerfilController {

	@Autowired
	PerfilService _perfilService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<PerfilPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _perfilService.getAllPaginated(parameters);
	}

	@RequestMapping(value = "/todos", method = RequestMethod.GET)
	public List<Perfil> getAll() {
		return _perfilService.findAll();
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Perfil> getById(@PathVariable(value = "id") Integer id) {
		Perfil perfil = _perfilService.findPerfilById(id);
		return ResponseEntity.ok().body(perfil);
	}
	/*
	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Perfil dto) {
		_perfilService.save(dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Perfil dto, @PathVariable("id") Integer id) {
		_perfilService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _perfilService.delete(id);
	}*/

}
