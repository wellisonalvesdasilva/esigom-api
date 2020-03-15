package com.esicvr.service.dto;

import java.util.List;

import com.esicvr.domain.Perfil;

public class RetornoSpringSecurityDTO {

	public String access_token;
	// public String refresh_token;
	public Long expires_in;
	public String token_type;
	public String login;
	public int cod_pessoa;
	public String nome;
	public String funcao;
	private String img_perfil_base64;
	private List<Perfil> roles;

	public String getImg_perfil_base64() {
		return img_perfil_base64;
	}

	public void setImg_perfil_base64(String img_perfil_base64) {
		this.img_perfil_base64 = img_perfil_base64;
	}

	public String getFuncao() {
		return funcao;
	}

	public void setFuncao(String funcao) {
		this.funcao = funcao;
	}

	public String getAccess_token() {
		return access_token;
	}

	public void setAccess_token(String access_token) {
		this.access_token = access_token;
	}

	public Long getExpires_in() {
		return expires_in;
	}

	public void setExpires_in(Long expires_in) {
		this.expires_in = expires_in;
	}

	public String getToken_type() {
		return token_type;
	}

	public void setToken_type(String token_type) {
		this.token_type = token_type;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public int getCod_pessoa() {
		return cod_pessoa;
	}

	public void setCod_pessoa(int cod_pessoa) {
		this.cod_pessoa = cod_pessoa;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public List<Perfil> getRoles() {
		return roles;
	}

	public void setRoles(List<Perfil> roles) {
		this.roles = roles;
	}

}
