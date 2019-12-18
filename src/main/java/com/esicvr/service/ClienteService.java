package com.esicvr.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Cliente;
import com.esicvr.service.dto.ClientePesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.UsuarioPesquisaDTO;

@Service
public interface ClienteService {

	public Boolean save(Cliente cliente);

	public GenericoRetornoPaginadoDTO<ClientePesquisaDTO> getAllPaginated(Map<String, String> parameters);

}
