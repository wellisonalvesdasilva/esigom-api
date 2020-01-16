package com.esicvr.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Cliente;
import com.esicvr.service.dto.ClientePesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Service
public interface ClienteService {

	public Boolean save(Cliente cliente);

	public GenericoRetornoPaginadoDTO<ClientePesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public boolean delete(Integer id);

	public boolean update(Integer id, Cliente dto);

	public Cliente findClienteById(Integer id);

}
