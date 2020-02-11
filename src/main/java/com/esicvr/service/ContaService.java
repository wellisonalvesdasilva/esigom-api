package com.esicvr.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.esicvr.domain.Conta;
import com.esicvr.domain.ContaParcela;
import com.esicvr.service.dto.ContaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@Service
public interface ContaService {

	public Boolean save(Conta conta);

	public GenericoRetornoPaginadoDTO<ContaPesquisaDTO> getAllPaginated(Map<String, String> parameters);

	public boolean delete(Integer id);

	public boolean update(Integer id, Conta conta);

	public Conta findContaById(Integer id);

	public boolean updatedByContaParcelaId(Integer id, ContaParcela conta);

}
