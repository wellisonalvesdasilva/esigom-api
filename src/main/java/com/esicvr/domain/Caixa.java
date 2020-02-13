package com.esicvr.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "caixa")
public class Caixa implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "descricao")
	private String descricao;

	@Column(name = "data_pagamento")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataPagamento;

	@Column(name = "valor")
	private Double valor;

	@Column(name = "tipo")
	private int tipo;

	// optional
	@OneToOne
	CentroCusto centroCusto;

	// optional
	@OneToOne
	Orcamento orcamento;

	// optional
	@OneToOne
	CompraParcela compraParcela;

	// optional
	@OneToOne
	ContaParcela contaParcela;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Date getDataPagamento() {
		return dataPagamento;
	}

	public void setDataPagamento(Date dataPagamento) {
		this.dataPagamento = dataPagamento;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

	public int getTipo() {
		return tipo;
	}

	public void setTipo(int tipo) {
		this.tipo = tipo;
	}

	public CentroCusto getCentroCusto() {
		return centroCusto;
	}

	public void setCentroCusto(CentroCusto centroCusto) {
		this.centroCusto = centroCusto;
	}

	public Orcamento getOrcamento() {
		return orcamento;
	}

	public void setOrcamento(Orcamento orcamento) {
		this.orcamento = orcamento;
	}

	public CompraParcela getCompraParcela() {
		return compraParcela;
	}

	public void setCompraParcela(CompraParcela compraParcela) {
		this.compraParcela = compraParcela;
	}

	public ContaParcela getContaParcela() {
		return contaParcela;
	}

	public void setContaParcela(ContaParcela contaParcela) {
		this.contaParcela = contaParcela;
	}

}
