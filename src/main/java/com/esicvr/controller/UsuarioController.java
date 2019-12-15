package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
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

import com.esicvr.domain.Usuario;
import com.esicvr.service.UsuarioService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.UserWithoutProfileDTO;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/usuarios")
public class UsuarioController {

	@Autowired
	UsuarioService _usuarioService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<UserWithoutProfileDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _usuarioService.getAllPaginated(parameters);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Usuario> getById(@PathVariable(value = "id") Integer id) {
		Usuario usuario = _usuarioService.findUsuarioById(id);
		return ResponseEntity.ok().body(usuario);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Usuario dto) throws NoSuchAlgorithmException {
		_usuarioService.save(dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Usuario dto, @PathVariable("id") Integer id) {
		_usuarioService.updatedUsuarioById(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _usuarioService.deleteUsuarioById(id);
	}

	@RequestMapping(value = "/alterarSenha/{id}", method = RequestMethod.PUT)
	public boolean updatePassword(@RequestBody(required=false) String novaSenha, @PathVariable("id") Integer id)
			throws NoSuchAlgorithmException {
		return _usuarioService.updateUsuarioByPassword(id, novaSenha);
	}

}
