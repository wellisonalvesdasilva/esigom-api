package com.esicvr.service.dto;

import java.util.Date;

import com.esicvr.domain.Orcamento;

public class OrdemServicoPesquisaDTO {

	private Integer id;
	private Orcamento orcamento;
	private Date dataAbertura;
	private Date dataEntrega;
	private String tempoGarantia;
	private Integer codStatus;
	private String relatorioTecnico;
	private boolean levarPecaSubstituida;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Orcamento getOrcamento() {
		return orcamento;
	}

	public void setOrcamento(Orcamento orcamento) {
		this.orcamento = orcamento;
	}

	public Date getDataAbertura() {
		return dataAbertura;
	}

	public void setDataAbertura(Date dataAbertura) {
		this.dataAbertura = dataAbertura;
	}

	public Date getDataEntrega() {
		return dataEntrega;
	}

	public void setDataEntrega(Date dataEntrega) {
		this.dataEntrega = dataEntrega;
	}

	public String getTempoGarantia() {
		return tempoGarantia;
	}

	public void setTempoGarantia(String tempoGarantia) {
		this.tempoGarantia = tempoGarantia;
	}

	public Integer getCodStatus() {
		return codStatus;
	}

	public void setCodStatus(Integer codStatus) {
		this.codStatus = codStatus;
	}

	public String getRelatorioTecnico() {
		return relatorioTecnico;
	}

	public void setRelatorioTecnico(String relatorioTecnico) {
		this.relatorioTecnico = relatorioTecnico;
	}

	public boolean isLevarPecaSubstituida() {
		return levarPecaSubstituida;
	}

	public void setLevarPecaSubstituida(boolean levarPecaSubstituida) {
		this.levarPecaSubstituida = levarPecaSubstituida;
	}

}
