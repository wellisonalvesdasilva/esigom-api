package com.esicvr.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name = "orcamento_servico")
public class OrcamentoServico implements Serializable {

	@Id
	@Column(name = "orcamento_id")
	private int orcamento_id;

	@Id
	@Column(name = "servico_id")
	private int servico_id;

	@Column(name = "quantidade")
	private int quantidade;

	public int getOrcamento_id() {
		return orcamento_id;
	}

	public void setOrcamento_id(int orcamento_id) {
		this.orcamento_id = orcamento_id;
	}

	public int getServico_id() {
		return servico_id;
	}

	public void setServico_id(int servico_id) {
		this.servico_id = servico_id;
	}

	public int getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(int quantidade) {
		this.quantidade = quantidade;
	}

}
