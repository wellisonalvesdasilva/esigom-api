package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.esicvr.domain.Caixa;
import com.esicvr.service.CaixaService;
import com.esicvr.service.dto.CaixaPesquisaDTO;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
@RestController
@CrossOrigin
@RequestMapping(value = "/api/caixas")
public class CaixaController {

	@Autowired
	CaixaService _caixaService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<CaixaPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _caixaService.getAllPaginated(parameters);
	}

	@RequestMapping(method = RequestMethod.POST)
	public void created(@RequestBody Caixa caixa) throws NoSuchAlgorithmException {
		_caixaService.save(caixa);
	}

}
