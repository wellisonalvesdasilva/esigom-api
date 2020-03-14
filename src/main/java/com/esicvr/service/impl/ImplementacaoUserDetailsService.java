package com.esicvr.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.esicvr.domain.Usuario;
import com.esicvr.repository.UsuarioRepository;

@Service
public class ImplementacaoUserDetailsService implements UserDetailsService {

	@Autowired
	private UsuarioRepository usuarioRepository;

	@Override
	public User loadUserByUsername(String username) throws UsernameNotFoundException {

		/* Consulta no banco o usuario */

		Usuario usuario = usuarioRepository.findUserByLogin(username);

		if (usuario == null) {
			throw new UsernameNotFoundException("Usuário não foi encontrado");
		}

		//return usuario;
		return new User(usuario.getLogin(), usuario.getPassword(), usuario.getAuthorities());
	}

}
