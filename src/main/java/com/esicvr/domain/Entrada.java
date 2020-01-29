package com.esicvr.domain;

import java.io.Serializable;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import com.fasterxml.jackson.annotation.JsonManagedReference;

@Entity
@Table(name = "entrada")
public class Entrada implements Serializable {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Column(name = "id")
	private int id;

	@Column(name = "data_entrada")
	@Temporal(TemporalType.TIMESTAMP)
	private Date dataEntrada;

	@OneToMany(cascade = CascadeType.ALL)
	@JsonManagedReference
	@JoinColumn(name = "entrada_id")
	private Set<EntradaProduto> produtos;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Date getDataEntrada() {
		return dataEntrada;
	}

	public void setDataEntrada(Date dataEntrada) {
		this.dataEntrada = dataEntrada;
	}

	public Set<EntradaProduto> getProdutos() {
		return produtos;
	}

	public void setProdutos(Set<EntradaProduto> produtos) {
		this.produtos = produtos;
	}

}
