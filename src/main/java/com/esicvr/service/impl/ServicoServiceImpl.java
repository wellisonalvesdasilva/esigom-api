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

import com.esicvr.domain.Servico;

import com.esicvr.repository.ServicoRepository;
import com.esicvr.service.ServicoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ServicoPesquisaDTO;

@Component
public class ServicoServiceImpl implements ServicoService {

	@Autowired
	ServicoRepository _servicoRepository;

	public GenericoRetornoPaginadoDTO<ServicoPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Servico> objPredicates = new Specification<Servico>() {
			public Predicate toPredicate(Root<Servico> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Servico> listaEmEntidade = _servicoRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<ServicoPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<ServicoPesquisaDTO>();
		List<ServicoPesquisaDTO> listaDto = new ArrayList<ServicoPesquisaDTO>();
		for (Servico item : listaEmEntidade) {
			ServicoPesquisaDTO obj = new ServicoPesquisaDTO();
			obj.setId(item.getId());
			obj.setDescricao(item.getDescricao());
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Servico p = _servicoRepository.findServicoById(id);
		if (p != null) {
			_servicoRepository.delete(p);
			return true;
		}
		return false;
	}

	public Boolean save(Servico entity) {
		if (_servicoRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Servico dto) {
		Servico p = _servicoRepository.findServicoById(id);
		if (p != null) {
			p = dto;
			_servicoRepository.save(p);
			return true;
		}
		return false;
	}

	public Servico findPecaById(Integer id) {
		Servico servico = _servicoRepository.findServicoById(id);
		if (servico != null) {
			return servico;
		}
		return null;
	}
}
