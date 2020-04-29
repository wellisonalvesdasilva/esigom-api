<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Admissão Retificada</span>
		</h1>
		<div class="space-20"></div>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='vacancia' id="formPesquisa">
			<div class="row">
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Remessa</label> <input type='number' id='codRemessa'
							max="999999" name='codRemessa' class="form-control"
							placeholder="Cód. Remessa"
							value='${(fn:escapeXml(param.codRemessa))}' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Motivo</label> <select name="motivo" id="motivo"
							class="form-control">
							<option value="">Selecione</option>
							<option value="1">Duplicidade</option>
							<option value="2">Erro XML</option>
						</select>
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<label>Data do Descarte</label>
					<div class="input-group">
						<input type='text' name='dataDescarte' id='dataDescarte'
							autocomplete="off" class="form-control dataMask"
							placeholder="DD/MM/AAAA"
							value='${(fn:escapeXml(param.dataDescarte))}' /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Solicitante</label> <input id='solicitante'
							name='solicitante' type="text" maxlength="60"
							placeholder="Solicitante" class="form-control"
							value='${(fn:escapeXml(param.solicitante))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Tipo Admissão</label> <select name="tipoAdmissao"
							id="tipoAdmissao" class="form-control">
							<option value="">Selecione</option>
							<option value="1">Concursado</option>
							<option value="2">Comissionado</option>
							<option value="3">Contratado</option>
							<option value="4">Convocado</option>
							<option value="5">Membro de Poder</option>
							<option value="6">Agente Político</option>
							<option value="8">Conselheiro Tutelar</option>
						</select>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Servidor Admissão</label> <input id='servidorAdmissao'
							name='servidorAdmissao' maxlength="60"
							placeholder="Servidor Admissão" class="form-control"
							value='${(fn:escapeXml(param.servidorAdmissao))}' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Matrícula/DV</label> <input id='matricula' maxlength="10"
							name='matricula' placeholder="Digite a Matrícula-DV"
							class="form-control" value='${(fn:escapeXml(param.matricula))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a href='/sicap-webapp/manager/retificacaoRemessa' type="button"
						class="btn btn-default btn-block btn-pesquisa"> <i
						class="glyphicon glyphicon-backward"></i> Voltar à Consulta de
						Retificação
					</a>
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
			</div>
		</form:form>
		<div class="divisor"></div>
		<br />
		<div class="row resultado">
			<h4>Resultados da pesquisa</h4>
		</div>
		<div class="row" style="margin: 0px;">
			<table class="table table-striped table-responsive"
				id="tableVacancia">
				<thead>
					<tr>
						<th><strong>Remessa</strong></th>
						<th><strong>Motivo</strong></th>
						<th><strong>Data Solicitação</strong></th>
						<th><strong>Solicitante</strong></th>
						<th><strong>Tipo Admissão</strong></th>
						<th><strong>Servidor Admissão</strong></th>
						<th><strong>Matrícula/DV</strong></th>
						<th class="text-center"><strong>Ações</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="it" items="${lista}" varStatus="status">
						<tr>
							<td class="text-center">${it.codRemessa}</td>
							<td class="text-center">${it.motivo}</td>
							<td class="text-center"><fmt:formatDate pattern="dd/MM/yyyy"
									value="${it.dataDescarte}" /></td>
							<td>${it.solicitante}</td>
							<td>${it.tipoAdmissao}</td>
							<td>${it.servidorAdmissao}</td>
							<td class="text-center">${it.matricula}</td>

							<td class="text-center"><a id="viewDescarte"
								name="viewDescarte" class="btn btn-default" type="button"
								data-toggle="tooltip" title="Ver Solicitação de Descarte"
								href="/sicap-webapp/manager/retificacaoRemessa?codSolicitacao=${it.codSolicitacaoRetificacao}">
									<i class="glyphicon glyphicon-search"></i>
							</a> <a class="btn btn-primary" type="button" data-toggle="tooltip"
								title="Download Justificativa" href="${it.arquivo}"
								target="_blank"> <i class="glyphicon glyphicon-download-alt"></i>
							</a></td>

						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<script>
		
		
		$(document).ready(function() {		
		
			// Mantem selecionado os dados dos dropdowns quando o usuário clica sobre o botão [Pesquisar]
			var valor = JSON.stringify(${(fn:escapeXml(param.tipoAdmissao))});
			valor ? document.getElementById("tipoAdmissao").value = valor : document.getElementById("tipoAdmissao").value = '';
			var valor = JSON.stringify(${(fn:escapeXml(param.motivo))});
			valor ? document.getElementById("motivo").value = valor : document.getElementById("motivo").value = '';
			
			// evento que limpa os valores preenchidos nos campos quando o usuário clica sobre o botão [Limpar]
			$("#reset").click(function() {
				$(":text").each(function() {
					$(this).val("");
				});
				
				$("input[name='codRemessa']").val('');
				
				$("select").each(function() {
					$(this).val("");
				});
			});
			
			
		});
		
			/// <===== DataTable ===>
			var table = $('#tableVacancia')
					.DataTable(
							{
								responsive : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,
								columnDefs : [ {
									"width" : "7",
									"targets" : 0
								}, {
									"width" : "9%",
									"targets" : 1
								}, {
									"width" : "14%",
									"targets" : 2
								}, {
									"width" : "20%",
									"targets" : 3
								}, {
									"width" : "13%",
									"targets" : 4
								}, {
									"width" : "21%",
									"targets" : 5
								}, {
									"width" : "6%",
									"targets" : 6
								}, {
									"width" : "10%",
									"targets" : 7
								}, ],
								order : [ [ 1, "desc" ] ],
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
			});

			// class = .
			$('.dataMask').mask('00/00/0000');
			$('.dataMask')
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