package com.esicvr.service.impl;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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

import com.esicvr.domain.Caixa;
import com.esicvr.domain.Compra;
import com.esicvr.domain.CompraParcela;
import com.esicvr.domain.CompraProduto;
import com.esicvr.domain.ContaParcela;
import com.esicvr.domain.Entrada;
import com.esicvr.domain.EntradaProduto;
import com.esicvr.repository.CaixaRepository;
import com.esicvr.repository.CompraParcelaRepository;
import com.esicvr.repository.CompraRepository;
import com.esicvr.repository.EntradaRepository;
import com.esicvr.service.CompraService;
import com.esicvr.service.dto.CompraPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.ListaParcelasCompraDTO;
import com.esicvr.util.FormatValues;

@Component
public class CompraServiceImpl implements CompraService {

	@Autowired
	CompraRepository _compraRepository;

	@Autowired
	CompraParcelaRepository _compraParcelaRepository;

	@Autowired
	EntradaRepository _entradaRepository;

	@Autowired
	CaixaRepository _caixaRepository;

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

	@Transactional
	public boolean delete(Integer id) {
		Compra p = _compraRepository.findCompraById(id);
		List<CompraParcela> parcelas = _compraParcelaRepository.findAllByCompra(p);
		if (p != null) {
			_caixaRepository.deleteAllByCompraParcela(parcelas);
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

	public Boolean incluirEmEstoque(Integer id) {

		Compra compra = _compraRepository.findCompraById(id);
		if (compra != null) {

			Entrada entrada = new Entrada();
			entrada.setDataEntrada(compra.getDataEntrada());
			entrada.setNotaFiscal(compra.getNotaFiscal());
			entrada.setFornecedor(compra.getFornecedor());

			Set<EntradaProduto> listProdutos = new HashSet<>();

			for (CompraProduto item : compra.getProdutos()) {
				EntradaProduto entradaProduto = new EntradaProduto();
				//entradaProduto.setProduto(item.getProduto());
				entradaProduto.setQuantidade(item.getQuantidade());
				entradaProduto.setEntrada(entrada);
				listProdutos.add(entradaProduto);
			}
			entrada.setProdutos(listProdutos);

			_entradaRepository.save(entrada);
			return true;
		}
		return null;
	}

	public List<ListaParcelasCompraDTO> obterListaParcelasCompra(Integer idCompra) throws ParseException {
		Compra compra = _compraRepository.findCompraById(idCompra);
		if (compra != null) {
			List<CompraParcela> _compraParcela = _compraParcelaRepository.findAllCompraParcelaByCompra(compra);

			List<ListaParcelasCompraDTO> listaDto = new ArrayList<ListaParcelasCompraDTO>();
			for (CompraParcela item : _compraParcela) {
				ListaParcelasCompraDTO obj = new ListaParcelasCompraDTO();
				BeanUtils.copyProperties(item, obj);
				obj.setSituacao(item.getDataPagamento() != null && item.getValorPago() != null ? "Pago" : "Aberto");
				listaDto.add(obj);
			}

			return listaDto;
		}
		return null;
	}

	public boolean updatedByListCompraParcela(List<CompraParcela> lista) {

		if (_compraParcelaRepository.saveAll(lista) != null) {
			for (CompraParcela compraParcela : lista) {

				// verificar se existe registro em caixa
				Caixa caixa = _caixaRepository.findCaixaByCompraParcela(compraParcela);

				// criar
				if (caixa == null && compraParcela.getDataPagamento() != null && compraParcela.getValorPago() != null) {
					Caixa novoObjetoCaixa = new Caixa();
					novoObjetoCaixa.setDescricao("Pagamento à vista de compra cód: " + compraParcela.getCompra().getId()
							+ " - parcela cód: " + compraParcela.getId());
					novoObjetoCaixa.setDataPagamento(new Date());
					// TODO
					novoObjetoCaixa.setValor(compraParcela.getValorPago());
					novoObjetoCaixa.setTipo(2);
					novoObjetoCaixa.setCentroCusto(compraParcela.getCompra().getCentroCusto());
					novoObjetoCaixa.setCompraParcela(compraParcela);
					_caixaRepository.save(novoObjetoCaixa);
				}

				// atualizar
				if (caixa != null && compraParcela.getDataPagamento() != null && compraParcela.getValorPago() != null) {
					// TODO:
					caixa.setValor(1994.0);
					_caixaRepository.save(caixa);
				}

				// remover
				if (caixa != null
						&& (compraParcela.getDataPagamento() == null || compraParcela.getValorPago() == null)) {
					_caixaRepository.delete(caixa);
				}

			}
			return true;

		}
		return false;
	}
}