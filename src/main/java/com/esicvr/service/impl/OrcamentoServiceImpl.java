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

import com.esicvr.domain.Orcamento;
import com.esicvr.repository.OrcamentoRepository;
import com.esicvr.service.OrcamentoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.OrcamentoPesquisaDTO;

@Component
public class OrcamentoServiceImpl implements OrcamentoService {

	@Autowired
	OrcamentoRepository _orcamentoRepository;

	public GenericoRetornoPaginadoDTO<OrcamentoPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Orcamento> objPredicates = new Specification<Orcamento>() {
			public Predicate toPredicate(Root<Orcamento> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Orcamento> listaEmEntidade = _orcamentoRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<OrcamentoPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<OrcamentoPesquisaDTO>();
		List<OrcamentoPesquisaDTO> listaDto = new ArrayList<OrcamentoPesquisaDTO>();
		for (Orcamento item : listaEmEntidade) {
			OrcamentoPesquisaDTO obj = new OrcamentoPesquisaDTO();
			obj.setId(item.getId());
			obj.setCliente(item.getCliente().getNome());
			obj.setCodStatus(item.getCodStatus());
			obj.setDthInclusao(item.getDataInclusao());
			obj.setGerouOs(item.getGerouOs());
			// TODO:
			obj.setValorTotal("R$50.000,00");
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Orcamento p = _orcamentoRepository.findOrcamentoById(id);
		if (p != null) {
			_orcamentoRepository.delete(p);
			return true;
		}
		return false;
	}

	public Boolean save(Orcamento entity) {
		if (_orcamentoRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Orcamento dto) {
		Orcamento p = _orcamentoRepository.findOrcamentoById(id);
		if (p != null) {
			p = dto;
			_orcamentoRepository.save(p);
			return true;
		}
		return false;
	}

	public Orcamento findOrcamentoById(Integer id) {
		Orcamento orcamento = _orcamentoRepository.findOrcamentoById(id);
		if (orcamento != null) {
			return orcamento;
		}
		return null;
	}
}
