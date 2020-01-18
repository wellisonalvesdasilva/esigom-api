package com.esicvr.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.esicvr.domain.Cliente;
import com.esicvr.domain.Perfil;
import com.esicvr.repository.ClienteRepository;
import com.esicvr.service.ClienteService;
import com.esicvr.service.dto.ClientePesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

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

	public GenericoRetornoPaginadoDTO<ClientePesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Cliente> objPredicates = new Specification<Cliente>() {
			public Predicate toPredicate(Root<Cliente> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
				List<Predicate> filtros = new ArrayList<Predicate>();
				if (parameters.get("nome") != null && parameters.get("nome") != "") {
					filtros.add(cb.like(root.get("nome"), "%" + parameters.get("nome") + "%"));
				}
				if (parameters.get("cpf") != null && parameters.get("cpf") != "") {
					filtros.add(cb.equal(root.get("cpf"), parameters.get("cpf")));
				}
				if (parameters.get("email") != null && parameters.get("email") != "") {
					filtros.add(cb.equal(root.get("email"), parameters.get("email")));
				}

				Predicate finalQuery = cb.and(filtros.toArray(new Predicate[filtros.size()]));
				return finalQuery;
			}
		};

		/* ORDER BY AND PAGINATION */
		Sort sort = Sort.by(parameters.get("coluna"));
		if (parameters.get("tipoOrdenacao").equals("asc")) {
			sort = sort.ascending();
		} else {
			sort = sort.descending();
		}
		Pageable paging = PageRequest.of(Integer.parseInt(parameters.get("offset")),
				Integer.parseInt(parameters.get("limit")), sort);

		/* BUSCAR E RETORNAR AO REST EM DTO */
		Page<Cliente> listaEmEntidade = _clienteRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<ClientePesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<ClientePesquisaDTO>();
		List<ClientePesquisaDTO> listaDto = new ArrayList<ClientePesquisaDTO>();
		for (Cliente item : listaEmEntidade) {
			ClientePesquisaDTO obj = new ClientePesquisaDTO();
			obj.setId(item.getId());
			obj.setCpf(item.getCpf());
			obj.setNome(item.getNome());
			obj.setEmail(item.getEmail());
			obj.setDthInclusao(item.getDthInclusao());
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Cliente p = _clienteRepository.findClienteById(id);
		if (p != null) {
			_clienteRepository.delete(p);
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Cliente dto) {
		Cliente p = _clienteRepository.findClienteById(id);
		if (p != null) {
			p = dto;
			_clienteRepository.save(p);
			return true;
		}
		return false;
	}

	public Cliente findClienteById(Integer id) {
		Cliente cliente = _clienteRepository.findClienteById(id);
		if (cliente != null) {
			return cliente;
		}
		return null;
	}


	public Cliente findClienteByCpf(String cpf) {
		Cliente cliente = _clienteRepository.findClienteByCpf(cpf);
		if (cliente != null) {
			return cliente;
		}
		return null;
	}
}
