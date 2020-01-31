package com.esicvr.service.dto;

import java.util.Date;

import com.esicvr.domain.CentroCusto;
import com.esicvr.domain.FormaPagamento;
import com.esicvr.domain.Fornecedor;

public class CompraPesquisaDTO {

	private int id;
	private Fornecedor fornecedor;
	private CentroCusto centroCusto;
	private FormaPagamento formaPagamento;
	private Date dataEntrada;
	private Double valor;
	private String notaFiscal;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Fornecedor getFornecedor() {
		return fornecedor;
	}

	public void setFornecedor(Fornecedor fornecedor) {
		this.fornecedor = fornecedor;
	}

	public CentroCusto getCentroCusto() {
		return centroCusto;
	}

	public void setCentroCusto(CentroCusto centroCusto) {
		this.centroCusto = centroCusto;
	}

	public FormaPagamento getFormaPagamento() {
		return formaPagamento;
	}

	public void setFormaPagamento(FormaPagamento formaPagamento) {
		this.formaPagamento = formaPagamento;
	}

	public Date getDataEntrada() {
		return dataEntrada;
	}

	public void setDataEntrada(Date dataEntrada) {
		this.dataEntrada = dataEntrada;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

	public String getNotaFiscal() {
		return notaFiscal;
	}

	public void setNotaFiscal(String notaFiscal) {
		this.notaFiscal = notaFiscal;
	}

}
