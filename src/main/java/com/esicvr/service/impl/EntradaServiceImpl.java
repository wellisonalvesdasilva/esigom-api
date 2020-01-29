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
import com.esicvr.domain.Entrada;
import com.esicvr.repository.EntradaRepository;
import com.esicvr.service.EntradaService;
import com.esicvr.service.dto.EntradaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Component
public class EntradaServiceImpl implements EntradaService {

	@Autowired
	EntradaRepository _entradaRepository;

	public Boolean save(Entrada entity) {
		if (_entradaRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<EntradaPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Entrada> objPredicates = new Specification<Entrada>() {
			public Predicate toPredicate(Root<Entrada> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Entrada> listEntity = _entradaRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<EntradaPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<EntradaPesquisaDTO>();
		List<EntradaPesquisaDTO> listaDto = new ArrayList<EntradaPesquisaDTO>();
		for (Entrada item : listEntity) {
			EntradaPesquisaDTO obj = new EntradaPesquisaDTO();
			BeanUtils.copyProperties(item, obj);
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listEntity.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		Entrada entrada = _entradaRepository.findEntradaById(id);
		if (entrada != null) {
			_entradaRepository.delete(entrada);
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Entrada dto) {
		Entrada entrada = _entradaRepository.findEntradaById(id);
		if (entrada != null) {
			entrada = dto;
			_entradaRepository.save(entrada);
			return true;
		}
		return false;
	}

	public Entrada findEntradaById(Integer id) {
		Entrada entrada = _entradaRepository.findEntradaById(id);
		if (entrada != null) {
			return entrada;
		}
		return null;
	}

	public List<Entrada> getAll() {
		return _entradaRepository.findAll();
	}
}
