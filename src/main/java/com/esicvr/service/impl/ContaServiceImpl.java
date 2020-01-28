package com.esicvr.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.esicvr.domain.Cliente;
import com.esicvr.domain.Conta;
import com.esicvr.domain.Perfil;
import com.esicvr.repository.ClienteRepository;
import com.esicvr.repository.ContaRepository;
import com.esicvr.service.ClienteService;
import com.esicvr.service.ContaService;
import com.esicvr.service.dto.ClientePesquisaDTO;
import com.esicvr.service.dto.ContaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Component
public class ContaServiceImpl implements ContaService {

	@Autowired
	ContaRepository _contaRepository;

	public Boolean save(Conta entity) {
		if (_contaRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<ContaPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Conta> objPredicates = new Specification<Conta>() {
			public Predicate toPredicate(Root<Conta> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Conta> listaEmEntidade = _contaRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<ContaPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<ContaPesquisaDTO>();
		List<ContaPesquisaDTO> listaDto = new ArrayList<ContaPesquisaDTO>();
		for (Conta item : listaEmEntidade) {
			ContaPesquisaDTO obj = new ContaPesquisaDTO();
			obj.setSituacao(retornarSituacao(item.getSituacao()));
			obj.setTipo(retornarTipoConta(item.getTipo()));
			BeanUtils.copyProperties(item, obj);
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Conta p = _contaRepository.findContaById(id);
		if (p != null) {
			_contaRepository.delete(p);
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Conta dto) {
		Conta p = _contaRepository.findContaById(id);
		if (p != null) {
			p = dto;
			_contaRepository.save(p);
			return true;
		}
		return false;
	}

	public Conta findContaById(Integer id) {
		Conta c = _contaRepository.findContaById(id);
		if (c != null) {
			return c;
		}
		return null;
	}

	public String retornarSituacao(Integer codSituacao) {
		String descricaoStatus = null;
		switch (codSituacao) {
		case 1:
			descricaoStatus = "Em Aberto";
			break;
		case 2:
			descricaoStatus = "Paga";
			break;
		case 3:
			descricaoStatus = "Cancelada";
			break;
		}
		return descricaoStatus;
	}

	public String retornarTipoConta(Integer tipo) {
		String tipoConta = null;
		switch (tipo) {
		case 1:
			tipoConta = "À Pagar";
			break;
		case 2:
			tipoConta = "À Receber";
			break;

		}
		return tipoConta;
	}

}
