package com.esicvr.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.esicvr.domain.Cliente;
import com.esicvr.repository.ClienteRepository;
import com.esicvr.service.ClienteService;

@Component
public class ClienteServiceImpl implements ClienteService {

	@Autowired
	ClienteRepository _clienteRepository;

	public Boolean save(Cliente entity) {
		if (_clienteRepository.save(entity) != null) {
			return true;
		}
		return false;
	}
}
