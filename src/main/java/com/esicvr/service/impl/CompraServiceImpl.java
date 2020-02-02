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
import com.esicvr.domain.Compra;
import com.esicvr.repository.CompraRepository;
import com.esicvr.service.CompraService;
import com.esicvr.service.dto.CompraPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Component
public class CompraServiceImpl implements CompraService {

	@Autowired
	CompraRepository _compraRepository;

	public Boolean save(Compra compra) {
		if (_compraRepository.save(compra) != null) {
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<CompraPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Compra> objPredicates = new Specification<Compra>() {
			public Predicate toPredicate(Root<Compra> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Compra> listaEmEntidade = _compraRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<CompraPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<CompraPesquisaDTO>();
		List<CompraPesquisaDTO> listaDto = new ArrayList<CompraPesquisaDTO>();
		for (Compra item : listaEmEntidade) {
			CompraPesquisaDTO obj = new CompraPesquisaDTO();
			obj.setQuantidadeProdutos(item.getProdutos().size());
			BeanUtils.copyProperties(item, obj);
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Compra p = _compraRepository.findCompraById(id);
		if (p != null) {
			_compraRepository.delete(p);
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Compra dto) {
		Compra p = _compraRepository.findCompraById(id);
		if (p != null) {
			p = dto;
			_compraRepository.save(p);
			return true;
		}
		return false;
	}

	public Compra findCompraById(Integer id) {
		Compra c = _compraRepository.findCompraById(id);
		if (c != null) {
			return c;
		}
		return null;
	}

}
