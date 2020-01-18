package com.esicvr.service.impl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import com.esicvr.domain.FormaPagamento;
import com.esicvr.repository.FormaPagamentoRepository;
import com.esicvr.service.FormaPagamentoService;

@Component
public class FormaPagamentoServiceImpl implements FormaPagamentoService {

	@Autowired
	FormaPagamentoRepository _formaPagamentoRepository;

	public List<FormaPagamento> getAll() {
		return _formaPagamentoRepository.findAll();
	}
}
