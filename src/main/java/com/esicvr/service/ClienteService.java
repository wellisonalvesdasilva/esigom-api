package com.esicvr.service;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Cliente;

@Service
public interface ClienteService {

	public Boolean save(Cliente cliente);

}
