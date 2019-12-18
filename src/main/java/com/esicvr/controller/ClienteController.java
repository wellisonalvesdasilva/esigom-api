package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
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
@CrossOrigin
@RequestMapping(value = "/api/clientes")
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

}
