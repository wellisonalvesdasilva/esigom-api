package com.esicvr.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "compra")
public class Compra implements Serializable {

	private static final long serialVersionUID = -4699416460433948067L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@OneToOne
	Fornecedor fornecedor;

	@OneToOne
	CentroCusto centroCusto;

	@OneToOne
	FormaPagamento formaPagamento;

	@Column(name = "data_entrada")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataEntrada;

	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonManagedReference
	@JoinColumn(name = "compra_id")
	private Set<CompraParcela> parcelas;

	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonManagedReference
	@JoinColumn(name = "compra_id")
	private Set<CompraProduto> produtos;

	@Column(name = "notaFiscal")
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

	public Date getDataEntrada() {
		return dataEntrada;
	}

	public void setDataEntrada(Date dataEntrada) {
		this.dataEntrada = dataEntrada;
	}

	public Set<CompraParcela> getParcelas() {
		return parcelas;
	}

	public void setParcelas(Set<CompraParcela> parcelas) {
		this.parcelas = parcelas;
	}

	public Set<CompraProduto> getProdutos() {
		return produtos;
	}

	public void setProdutos(Set<CompraProduto> produtos) {
		this.produtos = produtos;
	}

	public String getNotaFiscal() {
		return notaFiscal;
	}

	public void setNotaFiscal(String notaFiscal) {
		this.notaFiscal = notaFiscal;
	}

	public FormaPagamento getFormaPagamento() {
		return formaPagamento;
	}

	public void setFormaPagamento(FormaPagamento formaPagamento) {
		this.formaPagamento = formaPagamento;
	}
	
	

}
