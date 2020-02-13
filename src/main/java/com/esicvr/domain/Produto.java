package com.esicvr.domain;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "produto")
public class Produto implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private int id;

	@Column(name = "descricao")
	private String descricao;

	@Column(name = "valor")
	private Double valor;

	@JsonIgnore
	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "produto_id")
	private Set<OrcamentoProduto> produtos;

	@JsonIgnore
	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "produto_id")
	private Set<CompraProduto> products;

	@JsonIgnore
	@OneToMany(cascade = CascadeType.ALL, orphanRemoval = true)
	@JoinColumn(name = "entrada_id")
	private Set<EntradaProduto> productss;

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

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

	public Set<OrcamentoProduto> getProdutos() {
		return produtos;
	}

	public void setProdutos(Set<OrcamentoProduto> produtos) {
		this.produtos = produtos;
	}

	public Set<CompraProduto> getProducts() {
		return products;
	}

	public void setProducts(Set<CompraProduto> products) {
		this.products = products;
	}

	public Set<EntradaProduto> getProductss() {
		return productss;
	}

	public void setProductss(Set<EntradaProduto> productss) {
		this.productss = productss;
	}

}
