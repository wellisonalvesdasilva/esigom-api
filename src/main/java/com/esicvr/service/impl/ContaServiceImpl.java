package com.esicvr.service.impl;

import java.util.ArrayList;
import java.util.Date;
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
import com.esicvr.domain.CentroCusto;
import com.esicvr.domain.Conta;
import com.esicvr.domain.ContaParcela;
import com.esicvr.repository.CaixaRepository;
import com.esicvr.repository.CentroCustoRepository;
import com.esicvr.repository.ContaParcelaRepository;
import com.esicvr.repository.ContaRepository;
import com.esicvr.service.ContaService;
import com.esicvr.service.dto.ContaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Component
public class ContaServiceImpl implements ContaService {

	@Autowired
	ContaRepository _contaRepository;

	@Autowired
	ContaParcelaRepository _contaParcelaRepository;

	@Autowired
	CaixaRepository _caixaRepository;

	@Autowired
	CentroCustoRepository _centroCustoRepository;

	public Boolean save(Conta entity) {
		if (_contaRepository.save(entity) != null) {
			return true;
		}
		return false;
	}

	public GenericoRetornoPaginadoDTO<ContaPesquisaDTO> getAllPaginated(Map<String, String> parameters) {

		/* FILTROS */
		Specification<ContaParcela> objPredicates = new Specification<ContaParcela>() {
			public Predicate toPredicate(Root<ContaParcela> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
				List<Predicate> filtros = new ArrayList<Predicate>();
				/*
				 * if (parameters.get("nome") != null && parameters.get("nome") != "") {
				 * 
				 * filtros.add(cb.like(root.get("nome"), "%" + parameters.get("nome") + "%")); }
				 * if (parameters.get("cpf") != null && parameters.get("cpf") != "") {
				 * filtros.add(cb.equal(root.get("cpf"), parameters.get("cpf"))); } if
				 * (parameters.get("email") != null && parameters.get("email") != "") {
				 * filtros.add(cb.equal(root.get("email"), parameters.get("email"))); }
				 */

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
		Page<ContaParcela> listaEmEntidade = _contaParcelaRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<ContaPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<ContaPesquisaDTO>();
		List<ContaPesquisaDTO> listaDto = new ArrayList<ContaPesquisaDTO>();
		for (ContaParcela item : listaEmEntidade) {
			ContaPesquisaDTO obj = new ContaPesquisaDTO();
			BeanUtils.copyProperties(item, obj);
			obj.setSituacao(retornarSituacao(item.getSituacao()));
			obj.setTipo((item.getConta().getTipo() == 1) ? ("À Pagar") : ("À Receber"));
			obj.setSituacao(retornarSituacao(item.getSituacao()));
			obj.setPessoa((item.getConta().getFornecedor() != null) ? (item.getConta().getFornecedor().getDescricao())
					: (item.getConta().getCliente().getNome()));
			obj.setSituacaoId(item.getSituacao());
			listaDto.add(obj);
		}
		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public boolean delete(Integer id) {
		ContaParcela contaParcela = _contaParcelaRepository.findContaParcelaById(id);
		if (contaParcela != null) {
			_contaParcelaRepository.delete(contaParcela);
			return true;
		}
		return false;
	}

	public boolean update(Integer id, Conta dto) {
		Conta p = _contaRepository.findContaById(id);
		if (p != null) {
			p = dto;
			_contaRepository.save(p);
			return true;
		}
		return false;
	}

	public Conta findContaById(Integer id) {
		Conta c = _contaRepository.findContaById(id);
		if (c != null) {
			return c;
		}
		return null;
	}

	public String retornarSituacao(Integer codSituacao) {
		String descricaoStatus = null;
		switch (codSituacao) {
		case 1:
			descricaoStatus = "Em Aberto";
			break;
		case 2:
			descricaoStatus = "Paga";
			break;
		case 3:
			descricaoStatus = "Cancelada";
			break;
		}
		return descricaoStatus;
	}

	public boolean updatedByContaParcelaId(Integer id, ContaParcela conta) {
		ContaParcela contaParcela = _contaParcelaRepository.findContaParcelaById(id);
		if (contaParcela != null) {
			contaParcela = conta;
			_contaParcelaRepository.save(contaParcela);

			/* Inserção/Remoção de Informação em Acompanhar Caixa */
			Caixa caixa = _caixaRepository.findCaixaByContaParcela(contaParcela);
			if (caixa != null && contaParcela.getDataPagamento() == null && contaParcela.getValorPago() == null) {
				_caixaRepository.delete(caixa);
			} else if (caixa == null && contaParcela.getDataPagamento() != null
					&& contaParcela.getValorPago() != null) {
				Caixa novoObjetoCaixa = new Caixa();
				novoObjetoCaixa
						.setDescricao(((contaParcela.getConta().getTipo() == 1) ? ("Pagamento ") : ("Recebimento "))
								+ "à vista de conta cód: " + contaParcela.getConta().getId() + " - parcela cód: "
								+ contaParcela.getId());
				novoObjetoCaixa.setDataPagamento(new Date());
				// TODO
				novoObjetoCaixa.setValor(contaParcela.getValorPago());
				novoObjetoCaixa.setTipo(((contaParcela.getConta().getTipo() == 1) ? 2 : 1));
				novoObjetoCaixa.setCentroCusto(contaParcela.getConta().getCentroCusto());
				novoObjetoCaixa.setContaParcela(contaParcela);
				_caixaRepository.save(novoObjetoCaixa);
			}
			return true;
		}
		return false;
	}

}
