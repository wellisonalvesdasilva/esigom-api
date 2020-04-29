<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Remessas Recusadas</span>
		</h1>
		<div class="space-20"></div>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='recusa' id="formPesquisa">
			<div class="row">
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Cód. Importação</label> <input
							placeholder='Cód. Importação' max='99999' type='number'
							id='importacaoCod' name='importacaoCod' class="form-control"
							value='${(fn:escapeXml(param.importacaoCod))}' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Cód. Remessa</label> <input placeholder='Cód. Remessa'
							max='999999' type='number' id='remessaCod' name='remessaCod'
							class="form-control" value='${(fn:escapeXml(param.remessaCod))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Nome</label> <input id='nome' placeholder='Nome'
							name='nome' class="form-control"
							value='${(fn:escapeXml(param.nome))}' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>CPF</label> <input id='cpf' name='cpf' placeholder='CPF'
							class="form-control" value='${(fn:escapeXml(param.cpf))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Cargo/Função</label> <input placeholder='Cargo/Função'
							id='cargoFuncao' name='cargoFuncao' class="form-control"
							value='${(fn:escapeXml(param.cargoFuncao))}' />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-4">
					<button type="submit"
						class="btn btn-primary btn-block btn-pesquisa">
						<i class="fa fa-search"></i> Pesquisar
					</button>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<button id="reset" type="button"
						class="btn btn-default btn-block btn-pesquisa">
						<i class="fa fa-times"></i> Limpar Campos
					</button>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a data-toggle="tooltip" title="Voltar à Consulta de Importação"
						class='btn btn-default btn-block btn-pesquisa'
						href='/sicap-webapp/manager/remessa'><i
						class='glyphicon glyphicon-eye-open'></i> Voltar à Consulta de
						Importação</a>
				</div>
			</div>
		</form:form>
		<div class="divisor"></div>
		<br />
		<div class="row resultado">
			<h4>Resultados da pesquisa</h4>
		</div>
		<div class="row" style="margin: 0px;">
			<table class="table table-striped table-responsive" id="tableRecusa">
				<thead>
					<tr>
						<th class="text-center"><strong>Cód. Importação</strong></th>
						<th class="text-center"><strong>Cód. Remessa</strong></th>
						<th><strong>Nome</strong></th>
						<th class="text-center"><strong>CPF</strong></th>
						<th class="text-center"><strong>Cargo/Função</strong></th>
						<th class="text-center"><strong>Motivo</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="recusa" items="${recusas}" varStatus="status">
						<tr>
							<td class="text-center">${recusa.importacaoCod}</td>
							<td class="text-center">${recusa.cod}</td>
							<td>${recusa.nome}</td>

							<td class="text-center"><c:choose>
									<c:when test="${recusa.cpf == NULL}">
										-
									</c:when>
									<c:otherwise>
  						 			${recusa.cpf}
      							</c:otherwise>
								</c:choose></td>

							<td><c:choose>
									<c:when test="${recusa.cargoFuncao == NULL}">
									-
								</c:when>
									<c:otherwise>
  						 			${recusa.cargoFuncao}
      							</c:otherwise>
								</c:choose></td>
							<td class="text-center"><button class="btn btn-danger"
									onclick="abrirPdf('${recusa.caminho}')">
									<i class="glyphicon glyphicon-search"></i>
								</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<script>
			function abrirPdf(caminho) {
				if (caminho) {
					window.open(caminho, '_blank');

				} else {
					toastr.warning("Arquivo não encontrado.");
				}
			}

			$(document).ready(function() {
				$('#cpf').mask('00000000000');
				$("#reset").click(function() {
					$("#importacaoCod").val("");
					$("#remessaCod").val("");
					$(":text").each(function() {
						$(this).val("");
					});
					$("select").each(function() {
						$(this).val("0");
					});
				});
			});
			var table = $('#tableRecusa')
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
		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>