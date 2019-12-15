package com.esicvr.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.esicvr.domain.Perfil;
import com.esicvr.service.PerfilService;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/perfis")
public class PerfilController {

	@Autowired
	PerfilService _perfilService;

	@RequestMapping(method = RequestMethod.GET)
	public List<Perfil> getAll() {
		return _perfilService.findAll();
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Perfil> getById(@PathVariable(value = "id") Long id) {
		Perfil perfil = _perfilService.findPerfilById(id);
		return ResponseEntity.ok().body(perfil);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Perfil dto) {
		_perfilService.save(dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Perfil dto, @PathVariable("id") Long id) {
		_perfilService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Long id) {
		return _perfilService.delete(id);
	}

}
