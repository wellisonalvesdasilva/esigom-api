/*package com.esicvr.service.impl;

import java.math.BigInteger;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Component;

import com.esicvr.domain.Usuario;
import com.esicvr.repository.UsuarioRepository;
import com.esicvr.service.UsuarioService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.UsuarioPesquisaDTO;
import com.esicvr.util.FormatValues;

@Component
public class UsuarioServiceImpl implements UsuarioService {

	@Autowired
	UsuarioRepository _usuarioRepository;
	FormatValues _formatDate = new FormatValues();

	public GenericoRetornoPaginadoDTO<UsuarioPesquisaDTO> getAllPaginated(Map<String, String> parameters)
			throws ParseException {

		// FILTROS
		Specification<Usuario> objPredicates = new Specification<Usuario>() {
			public Predicate toPredicate(Root<Usuario> root, CriteriaQuery<?> cq, CriteriaBuilder cb) {
				List<Predicate> filtros = new ArrayList<Predicate>();
				if (parameters.get("nome") != null && parameters.get("nome") != "") {
					filtros.add(cb.like(root.get("nome"), "%" + parameters.get("nome") + "%"));
				}

				if (parameters.get("login") != null && parameters.get("login") != "") {
					filtros.add(cb.equal(root.get("login"), parameters.get("login")));
				}

				if (parameters.get("email") != null && parameters.get("email") != "") {
					filtros.add(cb.equal(root.get("email"), parameters.get("email")));
				}

				// Data de Inclusão
				if (parameters.get("dthInclusao") != null && parameters.get("dthInclusao") != "") {

					String[] data = null;
					data = parameters.get("dthInclusao").split("/");

					int dia, mes, ano;
					dia = Integer.parseInt(data[0]);
					mes = Integer.parseInt(data[1]);
					ano = Integer.parseInt(data[2]);

					filtros.add(cb.equal(cb.function("year", Integer.class, root.get("dthInclusao")), ano));
					filtros.add(cb.equal(cb.function("month", Integer.class, root.get("dthInclusao")), mes));
					filtros.add(cb.equal(cb.function("day", Integer.class, root.get("dthInclusao")), dia));

				}

				Predicate finalQuery = cb.and(filtros.toArray(new Predicate[filtros.size()]));
				return finalQuery;
			}
		};

		// ORDER BY AND PAGINATION
		Sort sort = Sort.by(parameters.get("coluna"));
		if (parameters.get("tipoOrdenacao").equals("asc")) {
			sort = sort.ascending();
		} else {
			sort = sort.descending();
		}
		Pageable paging = PageRequest.of(Integer.parseInt(parameters.get("offset")),
				Integer.parseInt(parameters.get("limit")), sort);

		// BUSCAR E RETORNAR AO REST EM DTO
		Page<Usuario> listaEmEntidade = _usuarioRepository.findAll(objPredicates, paging);
		GenericoRetornoPaginadoDTO<UsuarioPesquisaDTO> retorno = new GenericoRetornoPaginadoDTO<UsuarioPesquisaDTO>();
		List<UsuarioPesquisaDTO> listaDto = new ArrayList<UsuarioPesquisaDTO>();
		for (Usuario item : listaEmEntidade) {
			UsuarioPesquisaDTO obj = new UsuarioPesquisaDTO();
			obj.setNome(item.getNome());
			obj.setEmail(item.getEmail());
			obj.setId(item.getId());
			obj.setDthInclusao(item.getDthInclusao());
			obj.setLogin(item.getLogin());
			listaDto.add(obj);
		}

		retorno.setLista(listaDto);
		retorno.setRecordsTotal(listaEmEntidade.getTotalElements());
		return retorno;
	}

	public Usuario findUsuarioById(Integer id) {
		return _usuarioRepository.findUsuarioById(id);
	}

	public void save(Usuario entity) throws NoSuchAlgorithmException {

		// Armazenar a Senha em MD5
		String s = entity.getSenha();
		MessageDigest m = MessageDigest.getInstance("MD5");
		m.update(s.getBytes(), 0, s.length());
		entity.setSenha(new BigInteger(1, m.digest()).toString(16));

		_usuarioRepository.save(entity);
	}

	public void updatedUsuarioById(Integer id, Usuario entity) {
		Usuario objParaEdicao = _usuarioRepository.findUsuarioById(id);
		if (objParaEdicao != null) {
			objParaEdicao = entity;
			_usuarioRepository.save(objParaEdicao);
		}
	}

	public boolean deleteUsuarioById(Integer id) {
		Usuario objParaExclusao = _usuarioRepository.findUsuarioById(id);
		if (objParaExclusao != null) {
			_usuarioRepository.delete(objParaExclusao);
			return true;
		}
		return false;
	}

	public boolean updateUsuarioByPassword(Integer id, String novaSenha) throws NoSuchAlgorithmException {
		Usuario objParaAlterarSenha = _usuarioRepository.findUsuarioById(id);

		if (objParaAlterarSenha != null) {

			// Armazenar a Senha em MD5
			String s = "";
			if (novaSenha == null) {
				s = "1234567";
			} else {
				s = novaSenha;
			}
			MessageDigest m = MessageDigest.getInstance("MD5");
			m.update(s.getBytes(), 0, s.length());
			objParaAlterarSenha.setSenha(new BigInteger(1, m.digest()).toString(16));
			_usuarioRepository.save(objParaAlterarSenha);

			return true;
		}
		return false;
	}
}*/