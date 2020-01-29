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

import com.esicvr.domain.CentroCusto;
import com.esicvr.domain.Cliente;
import com.esicvr.domain.Fornecedor;
import com.esicvr.domain.Perfil;
import com.esicvr.repository.CentroCustoRepository;
import com.esicvr.repository.ClienteRepository;
import com.esicvr.repository.FornecedorRepository;
import com.esicvr.service.CentroCustoService;
import com.esicvr.service.ClienteService;
import com.esicvr.service.FornecedorService;
import com.esicvr.service.dto.CentroCustoPesquisaDTO;
import com.esicvr.service.dto.ClientePesquisaDTO;
import com.esicvr.service.dto.FornecedorPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Component
public class CentroCustoServiceImpl implements CentroCustoService {

	@Autowired
	CentroCustoRepository _centroCustoRepository;

	public Boolean save(CentroCusto entity) {
		if (_centroCustoRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<CentroCustoPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<CentroCusto> objPredicates = new Specification<CentroCusto>() {
			public Predicate toPredicate(Root<CentroCusto> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<CentroCusto> listEntity = _centroCustoRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<CentroCustoPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<CentroCustoPesquisaDTO>();
		List<CentroCustoPesquisaDTO> listaDto = new ArrayList<CentroCustoPesquisaDTO>();
		for (CentroCusto item : listEntity) {
			CentroCustoPesquisaDTO obj = new CentroCustoPesquisaDTO();
			BeanUtils.copyProperties(item, obj);
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listEntity.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		CentroCusto centroCusto = _centroCustoRepository.findCentroCustoById(id);
		if (centroCusto != null) {
			_centroCustoRepository.delete(centroCusto);
			return true;
		}
		return false;
	}

	public boolean update(Integer id, CentroCusto dto) {
		CentroCusto centroCusto = _centroCustoRepository.findCentroCustoById(id);
		if (centroCusto != null) {
			centroCusto = dto;
			_centroCustoRepository.save(centroCusto);
			return true;
		}
		return false;
	}

	public CentroCusto findCentroCustoById(Integer id) {
		CentroCusto centroCusto = _centroCustoRepository.findCentroCustoById(id);
		if (centroCusto != null) {
			return centroCusto;
		}
		return null;
	}

	public List<CentroCusto> getAll() {
		return _centroCustoRepository.findAll();
	}
}
