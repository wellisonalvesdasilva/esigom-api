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

import com.esicvr.domain.Cliente;
import com.esicvr.service.ClienteService;
import com.esicvr.service.dto.ClientePesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@RestController
//@CrossOrigin
@RequestMapping(value = "/operador/clientes")
public class ClienteController {

	@Autowired
	ClienteService _clienteService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<ClientePesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _clienteService.getAllPaginated(parameters);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Cliente cliente) throws NoSuchAlgorithmException {
		_clienteService.save(cliente);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Cliente> getById(@PathVariable(value = "id") Integer id) {
		Cliente cliente = _clienteService.findClienteById(id);
		return ResponseEntity.ok().body(cliente);
	}
	
	
	@RequestMapping(value = "/getByCpf/{cpf}", method = RequestMethod.GET)
	public ResponseEntity<Cliente> getByCpf(@PathVariable(value = "cpf") String cpf) {
		Cliente cliente = _clienteService.findClienteByCpf(cpf);
		return ResponseEntity.ok().body(cliente);
	}


	
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody Cliente dto, @PathVariable("id") Integer id) {
		_clienteService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _clienteService.delete(id);
	}

}
