package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.esicvr.domain.Conta;
import com.esicvr.domain.ContaParcela;
import com.esicvr.service.ContaService;
import com.esicvr.service.dto.ContaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;

@RestController
//@CrossOrigin
@RequestMapping(value = "/operador/contas")
public class ContaController {

	@Autowired
	ContaService _contaService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<ContaPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _contaService.getAllPaginated(parameters);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Conta conta) throws NoSuchAlgorithmException {
		_contaService.save(conta);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<Conta> getById(@PathVariable(value = "id") Integer id) {
		Conta conta = _contaService.findContaById(id);
		return ResponseEntity.ok().body(conta);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public boolean updatedById(@RequestBody Conta conta, @PathVariable("id") Integer id) {
		return _contaService.update(id, conta);
	}
	
	@RequestMapping(value = "/alterarContaParcela/{id}", method = RequestMethod.PUT)
	public boolean updatedByContaParcelaId(@RequestBody ContaParcela conta, @PathVariable("id") Integer id) {
		return _contaService.updatedByContaParcelaId(id, conta);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _contaService.delete(id);
	}

}
