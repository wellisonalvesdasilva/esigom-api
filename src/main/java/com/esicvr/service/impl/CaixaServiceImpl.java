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
import com.esicvr.domain.Caixa;
import com.esicvr.repository.CaixaRepository;
import com.esicvr.service.CaixaService;
import com.esicvr.service.dto.CaixaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Component
public class CaixaServiceImpl implements CaixaService {

	@Autowired
	CaixaRepository _caixaRepository;

	public Boolean save(Caixa caixa) {
		if (_caixaRepository.save(caixa) != null) {
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<CaixaPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<Caixa> objPredicates = new Specification<Caixa>() {
			public Predicate toPredicate(Root<Caixa> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
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
		Page<Caixa> listEntity = _caixaRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<CaixaPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<CaixaPesquisaDTO>();
		List<CaixaPesquisaDTO> listaDto = new ArrayList<CaixaPesquisaDTO>();
		for (Caixa item : listEntity) {
			CaixaPesquisaDTO obj = new CaixaPesquisaDTO();
			if (item.getTipo() == 1) {
				obj.setTipo("ENTRADA");
			} else {
				obj.setTipo("SAIDA");
			}

			BeanUtils.copyProperties(item, obj);
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listEntity.getTotalElements());
		return retorno;
	}

}
