package com.esicvr.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.esicvr.domain.FormaPagamento;
import com.esicvr.service.FormaPagamentoService;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/formasPagamento")
public class FormaPagamentoController {

	@Autowired
	FormaPagamentoService _formaPagamentoService;

	@RequestMapping(method = RequestMethod.GET)
	public List<FormaPagamento> getAll() {
		return _formaPagamentoService.getAll();
	}

}
