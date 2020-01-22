package com.esicvr.service.dto;

import java.util.Date;

public class OrcamentoPesquisaDTO {
	private int id;
	private Date dthInclusao;
	private Boolean gerouOs;
	private String cliente;
	private Integer codStatus;
	private String valorTotal;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDthInclusao() {
		return dthInclusao;
	}

	public void setDthInclusao(Date dthInclusao) {
		this.dthInclusao = dthInclusao;
	}

	public Boolean getGerouOs() {
		return gerouOs;
	}

	public void setGerouOs(Boolean gerouOs) {
		this.gerouOs = gerouOs;
	}

	public String getCliente() {
		return cliente;
	}

	public void setCliente(String cliente) {
		this.cliente = cliente;
	}

	public Integer getCodStatus() {
		return codStatus;
	}

	public void setCodStatus(Integer codStatus) {
		this.codStatus = codStatus;
	}

	public String getValorTotal() {
		return valorTotal;
	}

	public void setValorTotal(String valorTotal) {
		this.valorTotal = valorTotal;
	}

}
