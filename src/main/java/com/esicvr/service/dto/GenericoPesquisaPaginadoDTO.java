package com.esicvr.service.dto;

import java.util.List;

public class GenericoPesquisaPaginadoDTO<T> {
	public int offset;
	public int limit;
	public String sort;
	public String order;
	public List<T> objPesquisa;

	public int getOffset() {
		return offset;
	}

	public void setOffset(int offset) {
		this.offset = offset;
	}

	public int getLimit() {
		return limit;
	}

	public void setLimit(int limit) {
		this.limit = limit;
	}

	public String getSort() {
		return sort;
	}

	public void setSort(String sort) {
		this.sort = sort;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public List<T> getObjPesquisa() {
		return objPesquisa;
	}

	public void setObjPesquisa(List<T> objPesquisa) {
		this.objPesquisa = objPesquisa;
	}

}
