package com.esicvr.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "orcamento_produto")
public class OrcamentoProduto implements Serializable {

	@Id
	@Column(name = "orcamento_id")
	private int orcamento_id;

	@Id
	@Column(name = "produto_id")
	private int produto_id;

	@Column(name = "quantidade")
	private int quantidade;

	public int getOrcamento_id() {
		return orcamento_id;
	}

	public void setOrcamento_id(int orcamento_id) {
		this.orcamento_id = orcamento_id;
	}

	public int getProduto_id() {
		return produto_id;
	}

	public void setProduto_id(int produto_id) {
		this.produto_id = produto_id;
	}

	public int getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}

}
