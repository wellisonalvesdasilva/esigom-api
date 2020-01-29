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
import com.esicvr.domain.Fornecedor;
import com.esicvr.domain.Perfil;
import com.esicvr.repository.ClienteRepository;
import com.esicvr.repository.FornecedorRepository;
import com.esicvr.service.ClienteService;
import com.esicvr.service.FornecedorService;
import com.esicvr.service.dto.ClientePesquisaDTO;
import com.esicvr.service.dto.FornecedorPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Component
public class FornecedorServiceImpl implements FornecedorService {

	@Autowired
	FornecedorRepository _fornecedorRepository;

	public Boolean save(Fornecedor entity) {
		if (_fornecedorRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<FornecedorPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Fornecedor> objPredicates = new Specification<Fornecedor>() {
			public Predicate toPredicate(Root<Fornecedor> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Fornecedor> listEntity = _fornecedorRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<FornecedorPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<FornecedorPesquisaDTO>();
		List<FornecedorPesquisaDTO> listaDto = new ArrayList<FornecedorPesquisaDTO>();
		for (Fornecedor item : listEntity) {
			FornecedorPesquisaDTO obj = new FornecedorPesquisaDTO();
			BeanUtils.copyProperties(item, obj);
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listEntity.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Fornecedor fornecedor = _fornecedorRepository.findFornecedorById(id);
		if (fornecedor != null) {
			_fornecedorRepository.delete(fornecedor);
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Fornecedor dto) {
		Fornecedor fornecedor = _fornecedorRepository.findFornecedorById(id);
		if (fornecedor != null) {
			fornecedor = dto;
			_fornecedorRepository.save(fornecedor);
			return true;
		}
		return false;
	}

	public Fornecedor findFornecedorById(Integer id) {
		Fornecedor fornecedor = _fornecedorRepository.findFornecedorById(id);
		if (fornecedor != null) {
			return fornecedor;
		}
		return null;
	}
}
