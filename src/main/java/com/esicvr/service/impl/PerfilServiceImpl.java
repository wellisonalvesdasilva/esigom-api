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

import com.esicvr.domain.Perfil;
import com.esicvr.domain.Usuario;
import com.esicvr.repository.PerfilRepository;
import com.esicvr.service.PerfilService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.PerfilPesquisaDTO;
import com.esicvr.service.dto.UsuarioPesquisaDTO;

@Component
public class PerfilServiceImpl implements PerfilService {

	@Autowired
	PerfilRepository _perfilRepository;

	public List<Perfil> findAll() {
		List<Perfil> listPerfis = _perfilRepository.findAll();
		return listPerfis;
	}

	public Perfil save(Perfil perfil) {
		return _perfilRepository.save(perfil);
	}

	public Perfil findPerfilById(Integer id) {
		return _perfilRepository.findPerfilById(id);
	}

	public Boolean delete(Integer id) {
		Perfil p = _perfilRepository.findPerfilById(id);
		if (p != null) {
			_perfilRepository.delete(p);
			return true;
		}
		return false;
	}

	public Boolean update(Integer id, Perfil dto) {
		Perfil p = _perfilRepository.findPerfilById(id);
		if (p != null) {
			p = dto;
			_perfilRepository.save(p);
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<PerfilPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Perfil> objPredicates = new Specification<Perfil>() {
			public Predicate toPredicate(Root<Perfil> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
				List<Predicate> filtros = new ArrayList<Predicate>();
				if (parameters.get("descricao") != null && parameters.get("descricao") != "") {
					filtros.add(cb.like(root.get("descricao"), "%" + parameters.get("descricao") + "%"));
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
		Page<Perfil> listaEmEntidade = _perfilRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<PerfilPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<PerfilPesquisaDTO>();
		List<PerfilPesquisaDTO> listaDto = new ArrayList<PerfilPesquisaDTO>();
		for (Perfil item : listaEmEntidade) {
			PerfilPesquisaDTO obj = new PerfilPesquisaDTO();
			obj.setDescricao(item.getDescricao());
			obj.setId(item.getId());
			listaDto.add(obj);
		}

		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}
}
