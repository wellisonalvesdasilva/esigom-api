package com.esicvr.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.esicvr.domain.FormaPagamento;


@Service
public interface FormaPagamentoService {

	public List<FormaPagamento> getAll();

}
