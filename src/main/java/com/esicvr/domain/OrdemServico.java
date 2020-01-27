package com.esicvr.domain;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "ordem_servico")
public class OrdemServico implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name = "id")
	private Integer id;

	// Consigo acessar o cliente
	@OneToOne(cascade = CascadeType.REMOVE)
	private Orcamento orcamento;

	@Column(name = "dth_inclusao")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataAbertura;

	@Column(name = "dth_entrega")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataEntrega;

	@Column(name = "tempo_garantia")
	private String tempoGarantia;

	@Column(name = "cod_status")
	private Integer codStatus;

	@Column(name = "relatorio_tecnico")
	private String relatorioTecnico;

	@Column(name = "levar_peca_substituida")
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
