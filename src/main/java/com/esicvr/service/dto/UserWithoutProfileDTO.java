package com.esicvr.service.dto;

import java.util.Date;

public class UserWithoutProfileDTO {
	private Integer id;
	private String nome;
	private String login;
	private String email;
	private Date dthInclusao;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getDthInclusao() {
		return dthInclusao;
	}

	public void setDthInclusao(Date dthInclusao) {
		this.dthInclusao = dthInclusao;
	}

}
