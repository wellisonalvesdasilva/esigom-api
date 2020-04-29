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
				<div class="panel-heading">Informações do Concurso</div>
				<div class="panel-body">

					<div class="col-md-4">
						<div class="form-group">
							<label for="email">Data Protocolo</label> <label
								class="form-control background"> <fmt:formatDate
									pattern="dd/MM/yyyy" value="${concurso.remessa.dthInicio}" />
							</label>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label for="email">Regime Jurídico</label> <label
								class="form-control background">${concurso.regimeJuridico.descricao}</label>
						</div>
					</div>
					<div class="col-md-4">
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
				<div class="panel-heading">Dados do Cargo</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-12">
							<table id="tableEspecificacao"
								class="table table-striped table-responsive">
								<thead>
									<tr>
										<th>Descrição Cargo</th>
										<th>Código CBO</th>
										<c:if test="${antigo == true}">
											<th>Ordem</th>
											<th>Função</th>
										</c:if>
										<th>Especialidade</th>
										<th>Vagas de Concurso</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="concursoVagas"
										items="${concurso.concursoVagas}" varStatus="status">
										<tr>
											<td>${concursoVagas.cargo.descricao}</td>
											<td>${concursoVagas.cargo.codCbo}</td>
											<c:if test="${antigo == true}">
												<td>${concursoVagas.cargoAtributo.ordem}</td>
												<td>${concursoVagas.cargoAtributo.funcao}</td>
											</c:if>
											<td>${concursoVagas.especialidade}</td>
											<td>${concursoVagas.numeroVagas}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Inscritos</div>
				<div class="panel-body">
					<table id="tableInscrito"
						class="table table-striped table-responsive">
						<thead>
							<tr>
								<!--<th>Admissão</th> 
								<th>Cargo</th>-->
								<th class="text-center">Código</th>
								<th class="text-center">Número de Inscrição</th>
								<th>Nome</th>
								<th class="text-center">CPF</th>
								<th class="text-center">RG</th>
								<th>Situação</th>
								<th class="text-center">Classificação</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="inscrito" items="${inscritos}" varStatus="status">
								<tr>
									<%--<td><tce:admissaoInscrito value="${inscrito.admissao}" /></td>
									<td>${inscrito.cargo}</td>--%>
									<td class="text-center">${inscrito.cod}</td>
									<td class="text-center">${inscrito.numero}</td>
									<td>${inscrito.nome}</td>
									<td>${inscrito.cpf}</td>
									<c:choose>
										<c:when test="${inscrito.rgNumero == null}">
											<td class="text-center">-</td>
										</c:when>
										<c:otherwise>

											<td>${inscrito.rgNumero}</td>
										</c:otherwise>
									</c:choose>
									<td><tce:situacaoInscrito value="${inscrito.situacao}" /></td>
									<c:choose>
										<c:when test="${inscrito.classificacao == null}">
											<td class="text-center">-</td>
										</c:when>
										<c:otherwise>
											<td class="text-center">${inscrito.classificacao}</td>
										</c:otherwise>
									</c:choose>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
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

		<script>
			table = $('#tableInscrito')
					.DataTable(
							{
								responsive : true,
								searching : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,
								language : {
									"sEmptyTable" : "Nenhum registro encontrado",
									"sInfo" : "Mostrando de _START_ até _END_ de _TOTAL_ registros",
									"sInfoEmpty" : "Mostrando 0 até 0 de 0 registros",
									"sInfoFiltered" : "(Filtrados de _MAX_ registros)",
									"sInfoPostFix" : "",
									"sInfoThousands" : ".",
									"sLengthMenu" : "_MENU_ resultados por página",
									"sLoadingRecords" : "Carregando...",
									"sProcessing" : "Processando...",
									"sZeroRecords" : "Nenhum registro encontrado",
									"sSearch" : "Localizar: ",
									"oPaginate" : {
										"sNext" : "Próximo",
										"sPrevious" : "Anterior",
										"sFirst" : "Primeiro",
										"sLast" : "Último"
									},
									"oAria" : {
										"sSortAscending" : ": Ordenar colunas de forma ascendente",
										"sSortDescending" : ": Ordenar colunas de forma descendente"
									}
								}
							});
		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>
