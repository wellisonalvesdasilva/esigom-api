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
import javax.persistence.OneToOne;
import javax.persistence.Table;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "conta")
public class Conta implements Serializable {

	private static final long serialVersionUID = -6625912966887161639L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private int id;

	@OneToMany(cascade = CascadeType.ALL)
	@JsonManagedReference
	@JoinColumn(name = "conta_id")
	private Set<ContaParcela> parcelas;

	@OneToOne
	private Fornecedor fornecedor;

	@OneToOne
	private Cliente cliente;

	@Column(name = "numero_documento")
	private String numeroDocumento;

	@Column(name = "valor")
	private Double valor;

	@Column(name = "valor_pago")
	private Double valorPago;

	@Column(name = "situacao")
	private Integer situacao;

	@Column(name = "tipo")
	private Integer tipo;

	@OneToOne
	CentroCusto centroCusto;

	public Set<ContaParcela> getParcelas() {
		return parcelas;
	}

	public void setParcelas(Set<ContaParcela> parcelas) {
		this.parcelas = parcelas;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Fornecedor getFornecedor() {
		return fornecedor;
	}

	public void setFornecedor(Fornecedor fornecedor) {
		this.fornecedor = fornecedor;
	}

	public String getNumeroDocumento() {
		return numeroDocumento;
	}

	public void setNumeroDocumento(String numeroDocumento) {
		this.numeroDocumento = numeroDocumento;
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

	public Integer getSituacao() {
		return situacao;
	}

	public void setSituacao(Integer situacao) {
		this.situacao = situacao;
	}

	public Integer getTipo() {
		return tipo;
	}

	public void setTipo(Integer tipo) {
		this.tipo = tipo;
	}

	public CentroCusto getCentroCusto() {
		return centroCusto;
	}

	public void setCentroCusto(CentroCusto centroCusto) {
		this.centroCusto = centroCusto;
	}

}
