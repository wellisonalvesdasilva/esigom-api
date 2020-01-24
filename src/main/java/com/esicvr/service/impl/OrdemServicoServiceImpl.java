package com.esicvr.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Component;

import com.esicvr.domain.Orcamento;
import com.esicvr.domain.OrcamentoProduto;
import com.esicvr.domain.OrdemServico;
import com.esicvr.repository.OrcamentoRepository;
import com.esicvr.repository.OrdemServicoRepository;
import com.esicvr.service.OrcamentoService;
import com.esicvr.service.OrdemServicoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.OrcamentoPesquisaDTO;
import com.esicvr.service.dto.OrdemServicoPesquisaDTO;

@Component
public class OrdemServicoServiceImpl implements OrdemServicoService {

	@Autowired
	OrdemServicoRepository _orcamentoServicoRepository;

	public GenericoRetornoPaginadoDTO<OrdemServicoPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<OrdemServico> objPredicates = new Specification<OrdemServico>() {
			public Predicate toPredicate(Root<OrdemServico> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<OrdemServico> listaEmEntidade = _orcamentoServicoRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<OrdemServicoPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<OrdemServicoPesquisaDTO>();
		List<OrdemServicoPesquisaDTO> listaDto = new ArrayList<OrdemServicoPesquisaDTO>();
		for (OrdemServico item : listaEmEntidade) {
			OrdemServicoPesquisaDTO obj = new OrdemServicoPesquisaDTO();
			BeanUtils.copyProperties(item, obj);
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		OrdemServico p = _orcamentoServicoRepository.findOrdemServicoById(id);
		if (p != null) {
			_orcamentoServicoRepository.delete(p);
			return true;
		}
		return false;
	}

	public Boolean save(OrdemServico entity) {
		if (_orcamentoServicoRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public boolean update(Integer id, OrdemServico dto) {
		OrdemServico os = _orcamentoServicoRepository.findOrdemServicoById(id);
		if (os != null) {
			os = dto;
			_orcamentoServicoRepository.save(os);
			return true;
		}
		return false;
	}

	public OrdemServico findOrdemServicoById(Integer id) {
		OrdemServico os = _orcamentoServicoRepository.findOrdemServicoById(id);
		if (os != null) {
			return os;
		}
		return null;
	}

	public String retornarDescricaoStatus(Integer codStatus) {
		String descricaoStatus = null;
		switch (codStatus) {
		case 1:
			// TODO
			descricaoStatus = "X";
			break;
		case 2:
			descricaoStatus = "X";
			break;
		case 3:
			descricaoStatus = "X";
			break;
		}
		return descricaoStatus;
	}
}
