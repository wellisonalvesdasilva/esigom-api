<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1>Pesquisa Intima��o</h1>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='intimacao' id="formPesquisa">
			<div class="row">
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>C�d. Intima��o</label>
						<form:input type="number" placeholder="C�d. Intima��o" id='cod'
							path='cod' cssErrorClass='input-error null'
							cssClass="form-control" min="1" max="9999999" />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="sel1">Protocolo</label>
						<form:input id='codProtocolo' placeholder="C�d. Protocolo"
							path='codProtocolo' cssErrorClass='input-error null'
							cssClass="form-control" type="number" min="1" max="9999999" />
					</div>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<label>Data Envio</label>
					<div class="input-group">
						<form:input id='dthInclusao' path='dthInclusao'
							cssErrorClass='input-error null' placeholder="Data Envio"
							autocomplete="off" cssClass="form-control" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<button type="submit" name="btnSubmit" id="btnSubmit"
						class="btn btn-primary btn-block btn-pesquisa">
						<i class="fa fa-search"></i> Pesquisar
					</button>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a data-toggle="tooltip" title="Voltar � Consulta de Importa��o"
						class='btn btn-default btn-block btn-pesquisa'
						href='/sicap-webapp/manager/remessa'><i
						class='glyphicon glyphicon-eye-open'></i> Voltar � Consulta de
						Importa��o</a>
				</div>
			</div>
		</form:form>
		<div class="divisor"></div>
		<br />
		<div class="row resultado">
			<h4>Resultados de Intima��o</h4>
		</div>
		<div class="space-20"></div>
		<table class="table table-striped table-responsive"
			id="tableIntimacao">
			<thead>
				<tr>
					<th><strong>C�d. Intima��o</strong></th>
					<th><strong>Protocolo </strong></th>
					<th><strong>Data Envio</strong></th>
					<th><strong>A��o </strong></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="intimacao" items="${intimacoes}" varStatus="status">
					<tr>
						<td>${intimacao.cod}</td>
						<td>${intimacao.codProtocolo}</td>
						<td><fmt:formatDate pattern="dd/MM/yyyy"
								value="${intimacao.dataRetificacao}" /></td>
						<td><a href="responder/${intimacao.cod}"
							class="btn btn-primary"> <i class="fa fa-reply"></i>
								Responder
						</a></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</tiles:putAttribute>
</tiles:insertDefinition>

<script>
	$(document)
			.ready(
					function() {

						$("#reset").click(function() {

							$(":text").each(function() {
								$(this).val("");
							});

							$('#cod').val("");

							$('#codProtocolo').val("");

							$("select").each(function() {
								$(this).val("0");
							});
						});

						$('#dthInclusao').mask('00/00/0000');
						$("#dthInclusao")
								.datepicker(
										{
											dateFormat : 'dd/mm/yy',
											dayNames : [ 'Domingo', 'Segunda',
													'Ter�a', 'Quarta',
													'Quinta', 'Sexta', 'S�bado' ],
											dayNamesMin : [ 'D', 'S', 'T', 'Q',
													'Q', 'S', 'S', 'D' ],
											dayNamesShort : [ 'Dom', 'Seg',
													'Ter', 'Qua', 'Qui', 'Sex',
													'S�b', 'Dom' ],
											monthNames : [ 'Janeiro',
													'Fevereiro', 'Mar�o',
													'Abril', 'Maio', 'Junho',
													'Julho', 'Agosto',
													'Setembro', 'Outubro',
													'Novembro', 'Dezembro' ],
											monthNamesShort : [ 'Jan', 'Fev',
													'Mar', 'Abr', 'Mai', 'Jun',
													'Jul', 'Ago', 'Set', 'Out',
													'Nov', 'Dez' ],
											nextText : 'Pr�ximo',
											prevText : 'Anterior',
											onClose : function(dateText, inst) {
												if (!validaDat(dateText)) {
													$('#btnSubmit').prop(
															"disabled",
															"disabled");
												} else {
													$('#btnSubmit').prop(
															"disabled", "");
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
							} else if (((ardt[1] == 4) || (ardt[1] == 6)
									|| (ardt[1] == 9) || (ardt[1] == 11))
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

						$("#reset").click(function() {

							$(":text").each(function() {
								$(this).val("");
							});

							$("select").each(function() {
								$(this).val("0");
							});
						});

						$('#tableIntimacao')
								.dataTable(
										{
											responsive : true,
											ordering : true,
											bFilter : false,
											bLengthChange : false,
											bAutoWidth : false,
											iDisplayLength : 10,
											order : [ [ 1, "desc" ] ],
											language : {
												lengthMenu : "Display _MENU_ records per page",
												sInfo : "Mostrando de _START_ at� _END_ de _TOTAL_ registros",
												sProcessing : "Processando...",
												sInfoPostFix : "",
												sZeroRecords : "Nenhum registro encontrado",
												oPaginate : {
													sNext : "Pr�ximo",
													sPrevious : "Anterior",
													sFirst : "Primeiro",
													sLast : "�ltimo"
												}
											}
										});

						var erroMessage = "${erro}";
						if (erroMessage != "") {
							toastr.error("${erro}");
						}

					});
</script>
