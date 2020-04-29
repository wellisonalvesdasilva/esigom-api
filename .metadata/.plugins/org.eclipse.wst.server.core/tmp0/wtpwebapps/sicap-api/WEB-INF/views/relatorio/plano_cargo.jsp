<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Relatório Plano de Cargo</span>
		</h1>
		<div class="space-20"></div>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='cargo' id="formPesquisa">
			<div class="row">
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Cód. CBO</label>
						<form:input id='codCbo' path='codCbo' placeholder='Cód. CBO'
							cssErrorClass='input-error null' cssClass="form-control" min="1"
							max="9999999" />
					</div>
				</div>
				<div class="col-lg-4 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Descrição</label>
						<form:input id='descricao' path='descricao'
							placeholder='Cód. Descrição' cssErrorClass='input-error null'
							cssClass="form-control" />
					</div>
				</div>

				<div class="col-lg-2 col-md-2 col-sm-4">
					<button type="submit"
						class="btn btn-primary btn-block btn-pesquisa">
						<i class="fa fa-search"></i> Pesquisar
					</button>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<button id="reset" type="button"
						class="btn btn-default btn-block btn-pesquisa">
						<i class="fa fa-times"></i> Limpar
					</button>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<a href="/sicap-webapp/manager/remessa" type="button"
						class="btn btn-default btn-block btn-pesquisa"> <i
						class="fa fa-search"></i> Consulta Importação
					</a>
				</div>
			</div>
		</form:form>
		<div class="divisor"></div>
		<br />
		<div class="row">
			<div class="col-lg-4 col-md-3 col-sm-4">
				<div class="row resultado">
					<h4>Resultados da pesquisa</h4>
				</div>
			</div>
			<div class="col-lg-6 col-md-3 col-sm-4"></div>
			<div class="col-lg-2 col-md-3 col-sm-4">
				<c:choose>
					<c:when test="${lei != null}">
						<a class="btn btn-info" data-toggle="tooltip"
							title="Lei que criou ou alterou o último Plano de Cargos enviado."
							href="${lei.caminhoArquivo}" target="_blank"><i
							class="glyphicon glyphicon-download-alt"></i> Download Lei</a>
					</c:when>
				</c:choose>
			</div>
		</div>
		<div class="row" style="margin: 0px;">
			<table class="table table-striped table-responsive" id="tableCargo">
				<thead>
					<tr>
						<th><strong>Cód.</strong></th>
						<th><strong>Número Importação</strong></th>
						<th><strong>Tipo Cargo</strong></th>
						<th><strong>Código CBO</strong></th>
						<th><strong>Descrição</strong></th>
						<th><strong>Ação</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="cargo" items="${cargos}" varStatus="status">
						<tr>
							<td>${cargo.cod}</td>
							<td>${cargo.remessa.importacao.cod}</td>
							<td><tce:tipoCargo value="${cargo.grupo.categoria}" /></td>
							<td>${cargo.codCbo}</td>
							<td>${cargo.descricao}</td>
							<td><a class='btn btn-primary'
								href='/sicap-webapp/manager/relatorio/detalhe_cargo?cod_cargo=${cargo.cod}&cod_cbo=${cargo.codCbo}'><i
									class='fa fa-search-plus'></i> Informações Complementares</a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>

		</div>
		<script>
			$(document).ready(function() {
				$("#reset").click(function() {

					$("#cod").val("");

					$(":text").each(function() {
						$(this).val("");
					});

					$("select").each(function() {
						$(this).val("0");
					});
				});
			});
			var table = $('#tableCargo')
					.DataTable(
							{
								responsive : true,
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
									"sSearch" : "Pesquisar por CPF: ",
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

			$(function() {
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>