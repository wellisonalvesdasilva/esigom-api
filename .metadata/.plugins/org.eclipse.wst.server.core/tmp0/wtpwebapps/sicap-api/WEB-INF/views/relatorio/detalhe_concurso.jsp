<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>


<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<style>
svg {
	background-color: none;
}

@media print {
	body {
		font-size: 10px !important;
	}
	h2, h1 {
		font-size: 18px !important;
	}
	.btn-group, footer, nav {
		display: none !important;
	}
	.space-20 {
		height: 0px;
	}
}
</style>
		<h1 class="one">
			<span>Detalhe Concurso</span>
		</h1>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Dados do Concurso</div>
				<div class="panel-body">
					<div class="col-md-3">
						<div class="form-group">
							<label for="email">Data Protocolo</label> <label
								class="form-control background"> <fmt:formatDate
									pattern="dd/MM/yyyy" value="${concurso.remessa.dthInicio}" />
							</label>
						</div>
					</div>
					<div class="col-md-3">
						<div class="form-group">
							<label for="email">Regime Jurídico</label> <label
								class="form-control background">${concurso.regimeJuridico.descricao}</label>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="email">Modalidade</label> <label
								class="form-control background"><tce:modalidadeConcurso
									value="${concurso.codModalidaConcurso}" /></label>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label for="cpf">Descrição</label> <label
								class="form-control background">${concurso.descricao}</label>
						</div>
					</div>
					<div class="space-20"></div>
				</div>
			</div>
		</div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Cargos do Concurso</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<c:choose>
								<c:when test="${antigo == true}">
									<table id="tableEspecificacao"
										class="table table-striped table-responsive">
										<thead>
											<tr>
												<th>Descrição Cargo</th>
												<th>Código CBO</th>
												<th>Especialidade</th>
												<th>Vagas de Concurso</th>
												<th>Ação</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="concursoVagas"
												items="${concurso.concursoVagas}" varStatus="status">
												<tr>
													<td>${concursoVagas.cargo.descricao}</td>
													<td>${concursoVagas.cargo.codCbo}</td>
													<td>${concursoVagas.especialidade}</td>
													<td>${concursoVagas.numeroVagas}</td>
													<td><a class='btn btn-primary'
														href='/sicap-webapp/manager/relatorio/detalhe_inscrito?cod_concurso_vagas=${concursoVagas.cod}&cod_concurso=${concurso.cod}'><i
															class='fa fa-list'></i> Informações Complementares</a></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</c:when>
								<c:otherwise>
									<div>
										<c:forEach var="item" items="${lista}" varStatus="status">
											<div class="row">
												<div class="col-md-12">
													<span><strong>${item.descricaoCargo}</strong></span>
												</div>
											</div>
											<table id="tableEspecificacao"
												class="table table-striped table-responsive">

												<thead>
													<tr>
														<th class="text-center" style="width: 10.00%">Ordem</th>
														<th style="width: 25.00%">Função</th>
														<th style="width: 30.00%">Especialidade</th>
														<th class="text-center" style="width: 15.00%">Vagas
															de Concurso</th>
														<th style="width: 20.00%">Ação</th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="iti" items="${item.listaEspecificacao}"
														varStatus="status">
														<tr>
															<td class="text-center" style="width: 10.00%">${iti.ordem}</td>
															<td style="width: 25.00%">${iti.funcao}</td>
															<td style="width: 30.00%">${iti.especialidade}</td>
															<td class="text-center" style="width: 15.00%">${iti.vagas}</td>
															<td style="width: 20.00%"><a class='btn btn-primary'
																href='/sicap-webapp/manager/relatorio/detalhe_inscrito?cod_concurso_vagas=${iti.codConcursoVagas}&cod_concurso=${concurso.cod}'><i
																	class='fa fa-search-plus'></i> Informações
																	Complementares</a></td>
														</tr>
													</c:forEach>
												</tbody>

											</table>
										</c:forEach>
									</div>
								</c:otherwise>
							</c:choose>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="space-20"></div>
		<div class="row align-left" style="margin: 0px;">
			<div class="btn-group" role="group">
				<button onclick="window.print(); return false;" type="button"
					class="btn btn-info">
					<i class="fa fa-print"></i> Imprimir
				</button>
			</div>
			<div class="btn-group" role="group">
				<button onclick="history.go(-1); return false;" type="button"
					class="btn btn-default">
					<i class="fa fa-undo"></i> Voltar
				</button>
			</div>
		</div>
		<div class="space-20"></div>

	</tiles:putAttribute>
</tiles:insertDefinition>
