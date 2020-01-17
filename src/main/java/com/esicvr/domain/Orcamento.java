package com.esicvr.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "orcamento")
public class Orcamento implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private int id;

	@Column(name = "dth_inclusao")
	@Temporal(TemporalType.TIMESTAMP)
	private Date data;

	@Column(name = "veiculo_placa")
	private String veiculoPlaca;

	@Column(name = "obs")
	private String obs;

	@Column(name = "marca")
	private String marca;

	@Column(name = "cor")
	private String cor;

	@Column(name = "modelo")
	private String modelo;

	@Column(name = "ano")
	private Integer ano;

	@Column(name = "km")
	private Integer km;

	@Column(name = "gerou_os")
	private Boolean gerouOs;

	@ManyToOne
	@JoinColumn(name = "cliente_id", insertable = false, updatable = false)
	private Cliente cliente;

	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "orcamento_produto", joinColumns = @JoinColumn(name = "orcamento_id"), inverseJoinColumns = @JoinColumn(name = "produto_id"))
	private Set<Produto> produtos;

	@ManyToMany(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinTable(name = "orcamento_servico", joinColumns = @JoinColumn(name = "orcamento_id"), inverseJoinColumns = @JoinColumn(name = "servico_id"))
	private Set<Servico> servicos;

	@Column(name = "cod_status")
	private Integer codStatus;

	@Column(name = "forma_pagamento")
	private Integer formaPagamento;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getData() {
		return data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public String getVeiculoPlaca() {
		return veiculoPlaca;
	}

	public void setVeiculoPlaca(String veiculoPlaca) {
		this.veiculoPlaca = veiculoPlaca;
	}

	public String getObs() {
		return obs;
	}

	public void setObs(String obs) {
		this.obs = obs;
	}

	public String getMarca() {
		return marca;
	}

	public void setMarca(String marca) {
		this.marca = marca;
	}

	public String getCor() {
		return cor;
	}

	public void setCor(String cor) {
		this.cor = cor;
	}

	public String getModelo() {
		return modelo;
	}

	public void setModelo(String modelo) {
		this.modelo = modelo;
	}

	public Integer getAno() {
		return ano;
	}

	public void setAno(Integer ano) {
		this.ano = ano;
	}

	public Integer getKm() {
		return km;
	}

	public void setKm(Integer km) {
		this.km = km;
	}

	public Boolean getGerouOs() {
		return gerouOs;
	}

	public void setGerouOs(Boolean gerouOs) {
		this.gerouOs = gerouOs;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public Set<Produto> getProdutos() {
		return produtos;
	}

	public void setProdutos(Set<Produto> produtos) {
		this.produtos = produtos;
	}

	public Set<Servico> getServicos() {
		return servicos;
	}

	public void setServicos(Set<Servico> servicos) {
		this.servicos = servicos;
	}

	public Integer getCodStatus() {
		return codStatus;
	}

	public void setCodStatus(Integer codStatus) {
		this.codStatus = codStatus;
	}

	public Integer getFormaPagamento() {
		return formaPagamento;
	}

	public void setFormaPagamento(Integer formaPagamento) {
		this.formaPagamento = formaPagamento;
	}

}
