package com.esicvr.service;

import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Usuario;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.UsuarioPesquisaDTO;

@Service
public interface UsuarioService {

	public GenericoRetornoPaginadoDTO<UsuarioPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public Usuario findUsuarioById(Integer id);

	public void save(Usuario dto) throws NoSuchAlgorithmException;

	public void updatedUsuarioById(Integer id, Usuario dto);

	public boolean deleteUsuarioById(Integer id);

	public boolean updateUsuarioByPassword(Integer id, String novaSenha) throws NoSuchAlgorithmException;

}
