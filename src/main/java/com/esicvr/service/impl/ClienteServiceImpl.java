package com.esicvr.service.impl;
import java.util.HashSet;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.esicvr.domain.Cliente;
import com.esicvr.domain.Endereco;
import com.esicvr.domain.Telefone;
import com.esicvr.repository.ClienteRepository;
import com.esicvr.repository.EnderecoRepository;
import com.esicvr.repository.TelefoneRepository;
import com.esicvr.service.ClienteService;

@Component
public class ClienteServiceImpl implements ClienteService {

	@Autowired
	ClienteRepository _clienteRepository;

	@Autowired
	EnderecoRepository _enderecoRepository;

	@Autowired
	TelefoneRepository _telefoneRepository;

	public Boolean save(Cliente entity) {

		/* Gravar Endereço(s) */
		HashSet<Endereco> listEnderecos = new HashSet<Endereco>();
		for (Endereco item : entity.getEnderecos()) {
			if (item.getId() == 0) {
				listEnderecos.add(_enderecoRepository.save(item));
			} else {
				listEnderecos.add(item);
			}
		}
		entity.setEnderecos(listEnderecos);

		/* Gravar Telefone(s) */
		HashSet<Telefone> listTelefones = new HashSet<Telefone>();
		for (Telefone item : entity.getTelefones()) {
			if (item.getId() == 0) {
				listTelefones.add(_telefoneRepository.save(item));
			} else {
				listTelefones.add(item);
			}
		}
		entity.setTelefones(listTelefones);

		/* Gravar Entidade Cliente com Relacionamentos N x N */
		if (_clienteRepository.save(entity) != null) {
			return true;
		}
		return false;
	}
}
