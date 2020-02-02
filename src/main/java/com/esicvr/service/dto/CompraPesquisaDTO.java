package com.esicvr.service.dto;

import java.util.Date;

import com.esicvr.domain.CentroCusto;
import com.esicvr.domain.FormaPagamento;
import com.esicvr.domain.Fornecedor;

public class CompraPesquisaDTO {

	private int id;
	private Date dataEntrada;
	private Fornecedor fornecedor;
	private FormaPagamento formaPagamento;
	private Integer quantidadeProdutos;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDataEntrada() {
		return dataEntrada;
	}

	public void setDataEntrada(Date dataEntrada) {
		this.dataEntrada = dataEntrada;
	}

	public Fornecedor getFornecedor() {
		return fornecedor;
	}

	public void setFornecedor(Fornecedor fornecedor) {
		this.fornecedor = fornecedor;
	}

	public FormaPagamento getFormaPagamento() {
		return formaPagamento;
	}

	public void setFormaPagamento(FormaPagamento formaPagamento) {
		this.formaPagamento = formaPagamento;
	}

	public Integer getQuantidadeProdutos() {
		return quantidadeProdutos;
	}

	public void setQuantidadeProdutos(Integer quantidadeProdutos) {
		this.quantidadeProdutos = quantidadeProdutos;
	}

}
