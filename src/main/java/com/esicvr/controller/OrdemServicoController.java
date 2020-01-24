package com.esicvr.controller;

import java.security.NoSuchAlgorithmException;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import com.esicvr.domain.OrdemServico;
import com.esicvr.service.OrdemServicoService;
import com.esicvr.service.dto.GenericoRetornoPaginadoDTO;
import com.esicvr.service.dto.OrdemServicoPesquisaDTO;

@RestController
@CrossOrigin
@RequestMapping(value = "/api/os")
public class OrdemServicoController {

	@Autowired
	OrdemServicoService _ordemServicoService;

	@RequestMapping(method = RequestMethod.GET)
	public GenericoRetornoPaginadoDTO<OrdemServicoPesquisaDTO> getAll(@RequestParam Map<String, String> parameters) {
		return _ordemServicoService.getAllPaginated(parameters);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	public void created(@RequestBody OrdemServico entity) throws NoSuchAlgorithmException {
		_ordemServicoService.save(entity);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	public ResponseEntity<OrdemServico> getById(@PathVariable(value = "id") Integer id) {
		OrdemServico entity = _ordemServicoService.findOrdemServicoById(id);
		return ResponseEntity.ok().body(entity);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT)
	public void updatedById(@RequestBody OrdemServico dto, @PathVariable("id") Integer id) {
		_ordemServicoService.update(id, dto);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	public boolean deleteById(@PathVariable("id") Integer id) {
		return _ordemServicoService.delete(id);
	}

}
