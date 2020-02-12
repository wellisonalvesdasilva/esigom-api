package com.esicvr.service.dto;

import java.util.Date;

import com.esicvr.domain.Compra;

public class ListaParcelasCompraDTO {
	private int id;
	private Compra compra;
	private Date dataVencimento;
	private Date dataPagamento;
	private String documento;
	private Integer ordem;
	private Double valor;
	private Double valorPago;
	private String dataPagamentoFormatada;
	private boolean desabilitarEdicao;
	private String situacao;

	public ListaParcelasCompraDTO() {
		this.desabilitarEdicao = true;
	}

	public boolean isDesabilitarEdicao() {
		return desabilitarEdicao;
	}

	public void setDesabilitarEdicao(boolean desabilitarEdicao) {
		this.desabilitarEdicao = desabilitarEdicao;
	}

	public String getDataPagamentoFormatada() {
		return dataPagamentoFormatada;
	}

	public void setDataPagamentoFormatada(String dataPagamentoFormatada) {
		this.dataPagamentoFormatada = dataPagamentoFormatada;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Compra getCompra() {
		return compra;
	}

	public void setCompra(Compra compra) {
		this.compra = compra;
	}

	public Date getDataVencimento() {
		return dataVencimento;
	}

	public void setDataVencimento(Date dataVencimento) {
		this.dataVencimento = dataVencimento;
	}

	public Date getDataPagamento() {
		return dataPagamento;
	}

	public void setDataPagamento(Date dataPagamento) {
		this.dataPagamento = dataPagamento;
	}

	public String getDocumento() {
		return documento;
	}

	public void setDocumento(String documento) {
		this.documento = documento;
	}

	public Integer getOrdem() {
		return ordem;
	}

	public void setOrdem(Integer ordem) {
		this.ordem = ordem;
	}

	public Double getValor() {
		return valor;
	}

	public void setValor(Double valor) {
		this.valor = valor;
	}

	public Double getValorPago() {
		return valorPago;
	}

	public void setValorPago(Double valorPago) {
		this.valorPago = valorPago;
	}

	public String getSituacao() {
		return situacao;
	}

	public void setSituacao(String situacao) {
		this.situacao = situacao;
	}

}
