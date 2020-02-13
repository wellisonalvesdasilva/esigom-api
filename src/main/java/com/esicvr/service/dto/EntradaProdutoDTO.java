package com.esicvr.service.dto;

import com.esicvr.domain.Entrada;
import com.esicvr.domain.Produto;

public class EntradaProdutoDTO {
	private int id;
	private Produto produto;
	private Entrada entrada;
	private Integer quantidade;
	private Double valorUnitario;
	private boolean desabilitarEdicao;

	public EntradaProdutoDTO() {
		this.desabilitarEdicao = true;
	}

	public Entrada getEntrada() {
		return entrada;
	}

	public void setEntrada(Entrada entrada) {
		this.entrada = entrada;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Produto getProduto() {
		return produto;
	}

	public void setProduto(Produto produto) {
		this.produto = produto;
	}

	public Integer getQuantidade() {
		return quantidade;
	}

	public void setQuantidade(Integer quantidade) {
		this.quantidade = quantidade;
	}

	public Double getValorUnitario() {
		return valorUnitario;
	}

	public void setValorUnitario(Double valorUnitario) {
		this.valorUnitario = valorUnitario;
	}

	public boolean isDesabilitarEdicao() {
		return desabilitarEdicao;
	}

	public void setDesabilitarEdicao(boolean desabilitarEdicao) {
		this.desabilitarEdicao = desabilitarEdicao;
	}

}
