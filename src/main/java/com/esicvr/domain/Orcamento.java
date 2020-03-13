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
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.annotations.Cascade;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "orcamento")
public class Orcamento implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 3599069602899275921L;

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "dth_inclusao")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataInclusao;

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

	@Column(name = "cod_status")
	private Integer codStatus;

	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonManagedReference
	@JoinColumn(name = "orcamento_id")
	private Set<OrcamentoProduto> produtos;

	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonManagedReference
	@JoinColumn(name = "orcamento_id")
	private Set<OrcamentoServico> servicos;

	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JsonManagedReference
	@JoinColumn(name = "orcamento_id")
	private Set<OrcamentoParcela> parcelas;

	@OneToOne
	private Cliente cliente;

	public Set<OrcamentoParcela> getParcelas() {
		return parcelas;
	}

	public void setParcelas(Set<OrcamentoParcela> parcelas) {
		this.parcelas = parcelas;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDataInclusao() {
		return dataInclusao;
	}

	public void setDataInclusao(Date dataInclusao) {
		this.dataInclusao = dataInclusao;
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

	public Integer getCodStatus() {
		return codStatus;
	}

	public void setCodStatus(Integer codStatus) {
		this.codStatus = codStatus;
	}

	public Set<OrcamentoProduto> getProdutos() {
		return produtos;
	}

	public void setProdutos(Set<OrcamentoProduto> produtos) {
		this.produtos = produtos;
	}

	public Set<OrcamentoServico> getServicos() {
		return servicos;
	}

	public void setServicos(Set<OrcamentoServico> servicos) {
		this.servicos = servicos;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

}
