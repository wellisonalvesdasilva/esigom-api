package com.esicvr.security;

import java.io.IOException;
import java.nio.charset.Charset;
import java.sql.SQLException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.rowset.serial.SerialException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import com.esicvr.domain.Usuario;
import com.esicvr.repository.UsuarioRepository;
import com.esicvr.service.dto.RetornoSpringSecurityDTO;
import com.esicvr.util.ApplicationLoadContext;
import com.fasterxml.jackson.databind.ObjectMapper;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

@Service
@Component

public class JWTTokenAutenticacaoService {

	/* Tem de validade do Token 2 dias */
	private static final long EXPIRATION_TIME = 172800000;

	/* Uma senha unica para compor a autenticacao e ajudar na segurança */
	private static final String SECRET = "SenhaExtremamenteSecreta";

	/* Prefixo padrão de Token */
	private static final String TOKEN_PREFIX = "Bearer";

	private static final String HEADER_STRING = "Authorization";

	/* Gerando token de autenticado e adiconando ao cabeçalho e resposta Http */
	public void addAuthentication(HttpServletResponse response, String username)
			throws IOException, SerialException, SQLException {

		/* Montagem do Token */
		String JWT = Jwts.builder() /* Chama o gerador de Token */
				.setSubject(username) /* Adicona o usuario */
				.setExpiration(new Date(System.currentTimeMillis()
						+ EXPIRATION_TIME)) /* Tempo de expiração */
				.signWith(SignatureAlgorithm.HS512, SECRET)
				.compact(); /* Compactação e algoritmos de geração de senha */

		/* Junta token com o prefixo */
		String token = TOKEN_PREFIX + " " + JWT;

		/* Adiciona no cabeçalho http */
		response.addHeader(HEADER_STRING, token);

		liberacaoCors(response);

		// Objeto de Retorno
		RetornoSpringSecurityDTO obj = new RetornoSpringSecurityDTO();

		Usuario usuario = ApplicationLoadContext.getApplicationContext().getBean(UsuarioRepository.class)
				.findUserByLogin(username);

		if (usuario != null) {
			obj.setAccess_token(JWT);
			obj.setExpires_in(EXPIRATION_TIME);
			obj.setToken_type(TOKEN_PREFIX);
			obj.setLogin(usuario.getLogin());
			obj.setNome(usuario.getNome().toUpperCase());
			obj.setFuncao(usuario.getFuncao());
			obj.setCod_pessoa(usuario.getId());
			obj.setRoles(usuario.getPerfis());
			obj.setImg_perfil_base64(new String(usuario.getImg(), Charset.forName("UTF-8")));

		}

		/* Disponibilizar DTO para Retorno em formato JSON com Charset UTF-8 */
		ObjectMapper mapper = new ObjectMapper();
		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().write(mapper.writerWithDefaultPrettyPrinter().writeValueAsString(obj));
	}

	/*
	 * Retorna o usuário validado com token ou caso não sejá valido retorna null
	 */
	public Authentication getAuhentication(HttpServletRequest request, HttpServletResponse response) {

		/* Pega o token enviado no cabeçalho http */
		String token = request.getHeader(HEADER_STRING);

		if (token != null) {

			/* Faz a validação do token do usuário na requisição */
			String user = Jwts.parser()
					.setSigningKey(
							SECRET) /* Bearer 87878we8we787w8e78w78e78w7e87w */
					.parseClaimsJws(token.replace(TOKEN_PREFIX, "")) /* 87878we8we787w8e78w78e78w7e87w */
					.getBody().getSubject(); /* João Silva */
			if (user != null) {

				Usuario usuario = ApplicationLoadContext.getApplicationContext().getBean(UsuarioRepository.class)
						.findUserByLogin(user);

				if (usuario != null) {
					return new UsernamePasswordAuthenticationToken(usuario.getLogin(), usuario.getSenha(),
							usuario.getAuthorities());
				}
			}
		}

		liberacaoCors(response);
		return null; /* Não autorizado */
	}

	private void liberacaoCors(HttpServletResponse response) {
		if (response.getHeader("Access-Control-Allow-Origin") == null) {
			response.addHeader("Access-Control-Allow-Origin", "*");
		}

		if (response.getHeader("Access-Control-Allow-Methods") == null) {
			response.addHeader("Access-Control-Allow-Methods", "DELETE, POST, GET, PUT, OPTIONS");
		}

		if (response.getHeader("Access-Control-Allow-Headers") == null) {
			response.addHeader("Access-Control-Allow-Headers",
					"Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
		}

		if (response.getHeader("Access-Control-Request-Headers") == null) {
			response.addHeader("Access-Control-Request-Headers", "*");
		}
	}
}
