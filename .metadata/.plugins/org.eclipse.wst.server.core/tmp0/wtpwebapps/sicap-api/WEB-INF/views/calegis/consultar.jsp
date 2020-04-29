<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
.loader {
	position: absolute;
	opacity: 0.5;
	top: 0;
	width: 100%;
	height: 100%;
	background: #222222;
	left: 0;
	z-index: 9999;
}
</style>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Gerenciar Legislações</span>
		</h1>
		<div class="space-20"></div>
		<div class="row">
			<div id="error" class="alert alert-danger" style="display: none;">
				<span id="errorMessage"></span>
			</div>
		</div>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='intimacao' id="formPesquisa">
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Data</label>
					<div class="input-group">
						<input type='text' name='dataInicioVigencia'
							id='dataInicioVigencia' class="form-control dataMask"
							placeholder="DD/MM/AAAA"
							value='${(fn:escapeXml(param.dataInicioVigencia))}' /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-6 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Ementa</label> <input placeholder='Título' type='text'
							name='titulo' id='titulo' class="form-control"
							value='${(fn:escapeXml(param.titulo))}' />
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
					<button id="reset" onclick="limparImportacao()" type="button"
						class="btn btn-default btn-block btn-pesquisa">
						<i class="fa fa-times"></i> Limpar
					</button>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<a class='btn btn-success btn-block btn-pesquisa'
						href='/sicap-webapp/manager/calegis/cadastrar'><i
						class='glyphicon glyphicon-plus'></i> Cadastrar</a>
				</div>
			</div>
		</form:form>
		<div class="divisor"></div>
		<br />
		<div class="row resultado">
			<h4>Resultados da pesquisa</h4>
		</div>
		<div class="row" style="margin: 0px;">
			<table class="table table-striped table-responsive"
				id="tableLegislacao">
				<thead>
					<tr>
						<th class="text-center"><strong>Identificador</strong></th>
						<th class="text-center"><strong>Emitente</strong></th>
						<th class="text-center"><strong>Tipo</strong></th>
						<th class="text-center"><strong>Número</strong></th>
						<th class="text-center"><strong>Ano</strong></th>
						<th class="text-center"><strong>Cód. Controle</strong></th>
						<th class="text-center"><strong>Data</strong></th>
						<th class="text-center"><strong>Ementa</strong></th>
						<th class="text-center"><strong>Autor</strong></th>
						<th class="text-center"><strong>Status</strong></th>
						<th class="text-center"><strong>Ações</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="it" items="${retornoConsultaCalegis}"
						varStatus="status">
						<tr>
							<td class="text-center">${it.cod}</td>
							<td class="text-center">${it.codUg}</td>
							<td class="text-center">${it.codTipoAto}</td>
							<td class="text-center">${it.numeroAto}</td>
							<td class="text-center">${it.anoAto}</td>
							<td class="text-center">${it.codControle}</td>
							<td class="text-center">${it.dataLegislacao}</td>
							<td class="text-center">${it.assunto}</td>
							<td class="text-center">-</td>
							<td class="text-center"><span
								class='label ellipsis_150 ng-isolate-scope ng-binding label-success'
								title='Admissão Inativa'><i
									class='label ellipsis_150 ng-isolate-scope ng-binding label-success'></i>
									Validado</span></td>
							<td class="text-center"><a id='editarFuncionario' href='#'
								class='btn btn btn-primary'> <i
									class='glyphicon glyphicon-pencil'></i>
							</a>
								<button id="excluir" class="btn btn-danger" type="button"
									onclick="excluirFuncionario(${funcionario.cod})">
									<i class="glyphicon glyphicon-trash"></i>
								</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<script>
		
			var sucessoMessage = "${message}";
			if (sucessoMessage != "") {
				toastr.success("${message}");
			}
			
			
			var table = $('#tableLegislacao')
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