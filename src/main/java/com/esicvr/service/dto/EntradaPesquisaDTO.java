package com.esicvr.service.dto;

import java.util.Date;

import com.esicvr.domain.Fornecedor;

public class EntradaPesquisaDTO {
	private int id;
	private Date dataInclusao;
	private Double valorEntrada;
	private int qtdeProdutos;
	private String notaFiscal;
	private Fornecedor fornecedor;

	public EntradaPesquisaDTO() {
		this.valorEntrada = 0.0;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDataInclusao() {
		return dataInclusao;
	}

	public void setDataInclusao(Date dataInclusao) {
		this.dataInclusao = dataInclusao;
	}

	public Double getValorEntrada() {
		return valorEntrada;
	}

	public void setValorEntrada(Double valorEntrada) {
		this.valorEntrada = valorEntrada;
	}

	public int getQtdeProdutos() {
		return qtdeProdutos;
	}

	public void setQtdeProdutos(int qtdeProdutos) {
		this.qtdeProdutos = qtdeProdutos;
	}

	public String getNotaFiscal() {
		return notaFiscal;
	}

	public void setNotaFiscal(String notaFiscal) {
		this.notaFiscal = notaFiscal;
	}

	public Fornecedor getFornecedor() {
		return fornecedor;
	}

	public void setFornecedor(Fornecedor fornecedor) {
		this.fornecedor = fornecedor;
	}

}
