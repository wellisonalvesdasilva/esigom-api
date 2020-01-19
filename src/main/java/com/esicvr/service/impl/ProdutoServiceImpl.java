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

import com.esicvr.domain.Produto;

import com.esicvr.repository.ProdutoRepository;
import com.esicvr.service.ProdutoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ProdutoPesquisaDTO;

@Component
public class ProdutoServiceImpl implements ProdutoService {

	@Autowired
	ProdutoRepository _pecaRepository;

	public GenericoRetornoPaginadoDTO<ProdutoPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Produto> objPredicates = new Specification<Produto>() {
			public Predicate toPredicate(Root<Produto> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Produto> listaEmEntidade = _pecaRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<ProdutoPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<ProdutoPesquisaDTO>();
		List<ProdutoPesquisaDTO> listaDto = new ArrayList<ProdutoPesquisaDTO>();
		for (Produto item : listaEmEntidade) {
			ProdutoPesquisaDTO obj = new ProdutoPesquisaDTO();
			obj.setId(item.getId());
			obj.setDescricao(item.getDescricao());
			obj.setValor(item.getValor());
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Produto p = _pecaRepository.findPecaById(id);
		if (p != null) {
			_pecaRepository.delete(p);
			return true;
		}
		return false;
	}

	public Boolean save(Produto entity) {
		if (_pecaRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Produto dto) {
		Produto p = _pecaRepository.findPecaById(id);
		if (p != null) {
			p = dto;
			_pecaRepository.save(p);
			return true;
		}
		return false;
	}

	public Produto findPecaById(Integer id) {
		Produto peca = _pecaRepository.findPecaById(id);
		if (peca != null) {
			return peca;
		}
		return null;
	}

	public List<Produto> getAll() {
		return _pecaRepository.findAll();
	}
}
