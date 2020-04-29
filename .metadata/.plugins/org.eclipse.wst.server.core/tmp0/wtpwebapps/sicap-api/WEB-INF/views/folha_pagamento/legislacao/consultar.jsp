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
			<span>Legislações Cadastradas</span>
		</h1>
		<div class="space-20"></div>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='intimacao' id="formPesquisa">
			<div class="row">
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Número Lei</label> <input placeholder='Número Lei'
							max='99999' type='number' name='numeroLei' id='numeroLei'
							class="form-control" value='${(fn:escapeXml(param.numeroLei))}' />
					</div>
				</div>

				<div class="col-lg-4 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Tipo</label> <select name="codigoTipoLegislacao"
							id="codigoTipoLegislacao" class="form-control">
							<c:forEach var="legislacao" items='${tiposDeLegislacoes}'>
								<option value='${legislacao.key}'>${legislacao.value}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Data Assinatura</label>
					<div class="input-group">
						<input type='text' name='dataAssinatura' id='dataAssinatura'
							class="form-control dataMask" placeholder="Data Assinatura"
							value='${(fn:escapeXml(param.dataAssinatura))}' /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Data Publicação</label>
					<div class="input-group">
						<input type='text' name='dataInclusaoResposta'
							id='dataInclusaoResposta' class="form-control dataMask"
							placeholder="Data Publicação"
							value='${(fn:escapeXml(param.dataInclusaoResposta))}' /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
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
						<i class="fa fa-times"></i> Limpar
					</button>
				</div>

				<div class="col-lg-2 col-md-2 col-sm-4">
					<a class='btn btn-success btn-block btn-pesquisa'
						href='/sicap-webapp/manager//folha_pagamento/cadastros/legislacao/inserir'><i
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
						<th class="text-center"><strong>Código</strong></th>
						<th class="text-center"><strong>Número Lei</strong></th>
						<th class="text-center"><strong>Data Assinatura</strong></th>
						<th class="text-center"><strong>Tipo</strong></th>
						<th class="text-center"><strong>Data Publicação</strong></th>
						<th class="text-center"><strong>Assunto</strong></th>
						<th class="text-center"><strong>Ações</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="it" items="${retornoPesquisaLegislacao}"
						varStatus="status">
						<tr>
							<td class="text-center">${it.cod}</td>
							<td class="text-center">${it.numeroLei}/${it.ano}</td>
							<td class="text-center"><fmt:formatDate pattern="dd/MM/yyyy"
									value="${it.dataAssinatura}" />
							<td class="text-center">${it.legislacao.descricao}</td>
							<td class="text-center"><fmt:formatDate pattern="dd/MM/yyyy"
									value="${it.dataPublicacao}" /></td>
							<td>${it.assunto}</td>
							<td class="text-center"><a id='editarFuncionario'
								href='/sicap-webapp/manager/folha_pagamento/cadastros/legislacao/editar/${it.cod}'
								class='btn btn-success'> <i
									class='glyphicon glyphicon-pencil'></i></a>
								<button id="excluir" class="btn btn-danger" type="button"
									onclick="excluirLegislacao(${it.cod})">
									<i class="glyphicon glyphicon-trash"></i>
								</button></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>

		<form:form id="myModal" class="modal fade" role="dialog" method="POST"
			action="excluir">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Atenção</h4>
					</div>
					<div class="modal-body">
						<p>Deseja realmente excluir esta legislação?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
						<button name="btnYes" id="btnYes" type="submit"
							class="btn btn-primary">Confirmar</button>
					</div>
				</div>
			</div>
			<input type="hidden" id="codLegislacaoExclusao" name="codLegislacao" />
		</form:form>


		<script>
		
		var codLegislacao = 0;
		function excluirLegislacao(codLegislacao)
		{
			$('#myModal').modal();
			$('#codLegislacaoExclusao').val(codLegislacao);
			codLegislacao = codLegislacao;
		}
		
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

			// DatePicker
			$('.dataMask').mask('00/00/0000');
			$(".dataMask")
					.datepicker(
							{
								dateFormat : 'dd/mm/yy',
								dayNames : [ 'Domingo', 'Segunda', 'Terça',
										'Quarta', 'Quinta', 'Sexta', 'Sábado' ],
								dayNamesMin : [ 'D', 'S', 'T', 'Q', 'Q', 'S',
										'S', 'D' ],
								dayNamesShort : [ 'Dom', 'Seg', 'Ter', 'Qua',
										'Qui', 'Sex', 'Sáb', 'Dom' ],
								monthNames : [ 'Janeiro', 'Fevereiro', 'Março',
										'Abril', 'Maio', 'Junho', 'Julho',
										'Agosto', 'Setembro', 'Outubro',
										'Novembro', 'Dezembro' ],
								monthNamesShort : [ 'Jan', 'Fev', 'Mar', 'Abr',
										'Mai', 'Jun', 'Jul', 'Ago', 'Set',
										'Out', 'Nov', 'Dez' ],
								nextText : 'Próximo',
								prevText : 'Anterior',
								onClose : function(dateText, inst) {
									if (!validaDat(dateText)) {
										$('#btnSubmit').prop("disabled",
												"disabled");
									} else {
										$('#btnSubmit').prop("disabled", "");
									}
								}
							});

			$("#dataElaboracaoIntimacao")
					.datepicker(
							{
								dateFormat : 'dd/mm/yy',
								dayNames : [ 'Domingo', 'Segunda', 'Terça',
										'Quarta', 'Quinta', 'Sexta', 'Sábado' ],
								dayNamesMin : [ 'D', 'S', 'T', 'Q', 'Q', 'S',
										'S', 'D' ],
								dayNamesShort : [ 'Dom', 'Seg', 'Ter', 'Qua',
										'Qui', 'Sex', 'Sáb', 'Dom' ],
								monthNames : [ 'Janeiro', 'Fevereiro', 'Março',
										'Abril', 'Maio', 'Junho', 'Julho',
										'Agosto', 'Setembro', 'Outubro',
										'Novembro', 'Dezembro' ],
								monthNamesShort : [ 'Jan', 'Fev', 'Mar', 'Abr',
										'Mai', 'Jun', 'Jul', 'Ago', 'Set',
										'Out', 'Nov', 'Dez' ],
								nextText : 'Próximo',
								prevText : 'Anterior',
								onClose : function(dateText, inst) {
									if (!validaDat(dateText)) {
										$('#btnSubmit').prop("disabled",
												"disabled");
									} else {
										$('#btnSubmit').prop("disabled", "");
									}
								}
							});

			function validaDat(valor) {
				var date = valor;
				var ardt = new Array;
				var ExpReg = new RegExp(
						"(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[012])/[12][0-9]{3}");
				ardt = date.split("/");
				erro = false;
				if (date.search(ExpReg) == -1) {
					erro = true;
				} else if (((ardt[1] == 4) || (ardt[1] == 6) || (ardt[1] == 9) || (ardt[1] == 11))
						&& (ardt[0] > 30))
					erro = true;
				else if (ardt[1] == 2) {
					if ((ardt[0] > 28) && ((ardt[2] % 4) != 0))
						erro = true;
					if ((ardt[0] > 29) && ((ardt[2] % 4) == 0))
						erro = true;
				}
				if (erro) {
					return false;
				}
				return true;
			}
		</script>

	</tiles:putAttribute>
</tiles:insertDefinition>