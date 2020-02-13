package com.esicvr.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import com.fasterxml.jackson.annotation.JsonBackReference;
import com.esicvr.domain.Produto;

@Entity
@Table(name = "orcamento_produto")

public class OrcamentoProduto implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	@Column(name = "quantidade")
	private int quantidade;

	@ManyToOne
	@JoinColumn(name = "orcamento_id")
	@JsonBackReference
	private Orcamento orcamento;

	@ManyToOne
	@JoinColumn(name = "produto_id")
	private Produto produto;

	@Column(name = "cliente_leva_peca")
	private Boolean clienteLevaPeca;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public int getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}

	public Orcamento getOrcamento() {
		return orcamento;
	}

	public void setOrcamento(Orcamento orcamento) {
		this.orcamento = orcamento;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}

	public Boolean getClienteLevaPeca() {
		return clienteLevaPeca;
	}

	public void setClienteLevaPeca(Boolean clienteLevaPeca) {
		this.clienteLevaPeca = clienteLevaPeca;
	}

}
