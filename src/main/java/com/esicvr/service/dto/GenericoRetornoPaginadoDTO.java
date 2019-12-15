package com.esicvr.service.dto;

import java.util.List;

public class GenericoRetornoPaginadoDTO<T> {
	public long recordsTotal;
	public List<T> lista;

	public long getRecordsTotal() {
		return recordsTotal;
	}

	public void setRecordsTotal(long recordsTotal) {
		this.recordsTotal = recordsTotal;
	}

	public List<T> getLista() {
		return lista;
	}

	public void setLista(List<T> lista) {
		this.lista = lista;
	}
}