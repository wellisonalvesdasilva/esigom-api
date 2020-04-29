<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1>Consulta de Importação</h1>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='importacao' name="formPesquisa" id="formPesquisa">
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Cód. Importação</label> <input type='number' min='1'
							placeholder='Cód. Importação' max='99999' name='cod' id='cod'
							class="form-control" />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="sel1">Tipo Envio</label>
						<form:select path="tipoEnvio" id='tipoEnvio'
							items="${tipoRemessaList}" cssClass="form-control" />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="sel1">Tipo Importação</label>
						<form:select id='tipo' path="tipo" items="${tipoImportacaoList}"
							cssClass="form-control" />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="sel1">Situação</label>
						<form:select path="situacao" id='situacao'
							items="${tipoSituacaoList}" cssClass="form-control" />
					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<label>Período - Data Envio Inicio</label>
					<div class="input-group">
						<input id='dthInicio' autocomplete="off" name='dthInicio'
							placeholder='De:' class="form-control dataMask" /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<label>Período - Data Envio Fim</label>
					<div class="input-group">
						<input id='dthFim' autocomplete="off" name='dthFim'
							placeholder='Até:' class="form-control dataMask" /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-4 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="sel1">Responsável de Envio</label>
						<form:select id='codUsuarioInclusao' path="codUsuarioInclusao"
							items="${responsavelRemessaList}" cssClass="form-control" />
					</div>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<button name="btnSubmit" id="btnPesquisar" type="button"
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
			</div>
		</form:form>
		<div class="divisor"></div>
		<br />
	<div class="row resultado">
			<div class="col-lg-6">
				<div class="row align-right" style="margin: 0px;">
					<h4>Resultados da pesquisa</h4>
				</div>
			</div>
			<div class="col-lg-6 text-right">
			
			<%--
				<div class="row align-left" style="margin: 0px;">
					<a class="btn btn-info" title="Manual SICAP"
						data-toggle="tooltip"
						href="http://www.tce.ms.gov.br/portaljurisdicionado/files/conteudos/arquivo/10/56e4be869242ad1033188d8a734a8802.pdf"
						target="_blank"> <i class="glyphicon glyphicon-list-alt"></i>
						Manual SICAP
					</a> <a class="btn btn-info" title="Tabela SICAP"
						data-toggle="tooltip"
						href="http://www.tce.ms.gov.br/portaljurisdicionado/files/conteudos/arquivo/134/bb92eba09da4dc4ff4005571bf33d4ff.pdf"
						target="_blank"> <i class="	glyphicon glyphicon-th-list"></i>
						Tabela
					</a> <a class="btn btn-info" title="Manual de Peças (Resolução 88)"
						data-toggle="tooltip"
						href="http://www.tce.ms.gov.br/portal-services/files/tipo_legislacao/arquivo/109/6692d7edfe56aa458ff896ad3246869e.pdf"
						target="_blank"> <i class="glyphicon glyphicon-file"></i>
						Manual de Peças (Resolução 88)
					</a>
				</div>
				--%>
			</div>
		</div>
		<div class="space-20"></div>
		<table class="table table-striped table-responsive" id="tblRemessa">
			<thead>
				<tr>
					<th><strong>Cód. Importação</strong></th>
					<th><strong>Tipo de Envio</strong></th>
					<th><strong>Tipo de Importação</strong></th>
					<th><strong>Responsável de Envio</strong></th>
					<th><strong>Data de Envio</strong></th>
					<th><strong>Situação</strong></th>
					<th><strong>Ação</strong></th>
				</tr>
			</thead>
			<%-- <tbody>
				<c:forEach var="importacao" items="${importacoes}"
					varStatus="status">
					<tr>
						<td>${importacao.cod}</td>
						<td><tce:tipoEnvio value="${importacao.tipoEnvio}" /></td>
						<td><tce:tipoImportacao value="${importacao.tipo}" /></td>
						<td>${importacao.usuarioNome}</td>
						<td><fmt:formatDate pattern="dd/MM/yyyy"
								value="${importacao.dthInclusao}" /></td>
						<tce:situacaoImportacao value="${importacao.situacao}" />

						<td><c:if test="${importacao.antigo == 1}">
								<a class='btn btn-default disabled' href='#'><i
									class="fa fa-info-circle"></i>Detalhes</a>
							</c:if> <c:if test="${importacao.antigo != 1}">
								<a class='btn btn-info'
									href='/sicap-webapp/manager/remessa/detalhe_remessa?cod_importacao=${importacao.cod}'><i
									class="fa fa-info-circle"></i> Detalhes</a>
								<c:if test="${importacao.situacao == 4}">
									<a class='btn btn-danger'
										href="/sicap-webapp/manager/donwload?caminho=${importacao.arquivoErro}"><i
										class="fa fa-download"></i> Erro</a>
								</c:if>
								<c:if test="${importacao.situacao == 1}">
									<button id="excluir" class="btn btn-warning" type="button"
										data-toggle="modal" data-target="#myModal"
										onclick="cancelarImportacao(${importacao.cod})">
										<i class="fa fa-times-circle"></i> Invalidar
									</button>
								</c:if>
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody> --%>
		</table>
		<!-- 		<div class="divisor" style="border-top: none !important"></div>
		<span>**OBS: Os registros com o botão "Detalhes" desativado,
			não possuem arquivos para baixar.</span>
 -->

		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Atenção</h4>
					</div>
					<div class="modal-body">
						<p>
							Deseja alterar a situação da importação para <strong>Invalidado?</strong>
							Isso irá descartar o registro de ser processado pelo e-SICAP.
						</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
						<button name="btnYes" id="btnYes" type="button"
							class="btn btn-primary" data-dismiss="modal">Ok</button>
					</div>
				</div>
			</div>
		</div>
		<div id="modalQuadroDeAvisos" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 id="tituloModal"></h4>
					</div>
					<div class="modal-body">
						<div id="corpoModal"></div>
					</div>
					<div class="modal-footer">
						<button class="btn btn-default" data-dismiss="modal">Cancelar</button>
						<button name="btnAlterarAvisoParaLido"
							id="btnAlterarAvisoParaLido" type="button"
							class="btn btn-primary" data-dismiss="modal">Ciente</button>
					</div>
				</div>
			</div>
		</div>
		<script>
			$(document)
					.ready(
							function() {
								var page = 0;
								var start = 0;
								var dto = {};
								var dataTable = $('#tblRemessa')
										.DataTable(
												{
													responsive : true,
													bFilter : false,
													retrieve : true,
													bLengthChange : false,
													processing : true,
													searching : false,
													ordering : true,
													serverSide : true,

													columnDefs : [ {
														"width" : "8%",
														"targets" : 0
													}, {
														"width" : "12%",
														"targets" : 1
													}, {
														"width" : "15%",
														"targets" : 2
													}, {
														"width" : "20%",
														"targets" : 3
													}, {
														"width" : "13%",
														"targets" : 4
													}, {
														"width" : "10%",
														"targets" : 5
													}, {
														"width" : "22%",
														"targets" : 6
													}, ],

													"order" : [ [ 0, "desc" ] ],

													language : {
														"infoFiltered" : "",
														"sEmptyTable" : "Nenhum registro encontrado",
														"sInfo" : "Mostrando de _START_ até _END_ de _TOTAL_ registros",
														"sInfoEmpty" : "Mostrando 0 até 0 de 0 registros",
														"sInfoPostFix" : "",
														"sInfoThousands" : ".",
														"sLengthMenu" : "_MENU_ resultados por página",
														"sLoadingRecords" : "Carregando...",
														"sProcessing" : "Processando...",
														"sZeroRecords" : "Nenhum registro encontrado",
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
													},
													"pageLength" : 10,
													"ajax" : {
														"url" : 'remessa/listar/',
														"data" : function(data) {
															data.formulario = JSON
																	.stringify(dto);
															return data;
														}
													},
													"columns" : [
															{
																"data" : "cod",
																"className" : "text-center",
																"name" : "Código",
																"title" : "Código"
															},
															{
																"data" : "tipoEnvio",
																"name" : "Tipo de Envio",
																"title" : "Tipo de Envio"
															},
															{
																"data" : "tipo",
																"className" : "text-center",
																"name" : "Tipo de Importação",
																"title" : "Tipo de Importação"
															},
															{
																"data" : "usuarioNome",
																"name" : "Responsável de Envio",
																"title" : "Responsável de Envio"
															},
															{
																"data" : "dthInclusao",
																/* "className" : "text-center", */
																"name" : "Data de Envio",
																"title" : "Data de Envio"
															},
															{
																"data" : "situacao",
																"name" : "Situação",
																"title" : "Situação",
																"render" : function(
																		data,
																		type,
																		row,
																		meta) {

																	var temaBotao = '';
																	var textoButton = '';
																	switch (row.situacao) {

																	case "1":
																		temaBotao = 'label-default';
																		textoButton = 'Enviado';
																		break;
																	case "2":
																		temaBotao = 'label-default';
																		textoButton = 'Processando';
																		break;
																	case "3":
																		temaBotao = 'label-success';
																		textoButton = 'Protocolado';
																		break;
																	case "4":
																		temaBotao = 'label-danger';
																		textoButton = 'Recusado';
																		break;
																	case "5":
																		temaBotao = 'label-warning';
																		textoButton = 'Cancelado';
																		break;
																	case "8":
																		temaBotao = 'label-info';
																		textoButton = 'Aguardando Autuação';
																		break;
																	case "9":
																		temaBotao = 'label-success';
																		textoButton = 'Recebido';
																		break;
																	case "10":
																		temaBotao = 'label-warning';
																		textoButton = 'Invalidado';
																		break;
																	case "7":
																		temaBotao = 'label-warning';
																		textoButton = 'Migrado';
																		break;
																	case "12":
																		temaBotao = 'label-default';
																		textoButton = 'Rascunho';
																		break;
																	default:
																		temaBotao = '';
																		textoButton = '';
																		break;
																	}
																	return "<span class='label ellipsis_150 ng-isolate-scope ng-binding "+temaBotao+"' style='display: block; margin: 0; padding: 11.5px;'>"
																			+ textoButton
																			+ "</span>";
																}
															},
															{
																"data" : "situacao",
																"name" : "situacao",
																"title" : "Ação",
																"render" : function(
																		data,
																		type,
																		row,
																		meta) {

																	var htmlParaRenderizar = "<a class='btn btn-primary' href='/sicap-webapp/manager/remessa/detalhe_remessa?cod_importacao="
																			+ row.cod
																			+ "'><i class='fa fa-info-circle'></i> Detalhes</a>";

																	if (row.situacao == "1") {
																		htmlParaRenderizar = htmlParaRenderizar
																				+ " <button id='excluir' class='btn btn-warning' data-toggle='modal' data-target='#myModal' onclick='cancelarImportacao("
																				+ row.cod
																				+ ")'><i class='fa fa-times-circle'></i> Invalidar</button> ";
																	}

																	if (row.situacao == "12") {
																		htmlParaRenderizar = htmlParaRenderizar
																				+ " <a class='btn btn-warning' href='/sicap-webapp/manager/concluirEnvioPlanoCargo/?codImportacao="
																				+ row.cod
																				+ "'><i class='fa fa-paper-plane'></i> Finalizar Envio</a> ";
																	}
																	
																	
																	if (row.situacao == "4") {
																		htmlParaRenderizar = htmlParaRenderizar
																				+ " <a id='erro' name='erro' class='btn btn-danger' href='/sicap-webapp/manager/donwload?caminho="
																				+ row.caminhoErro
																				+ "'><i class='fa fa-download'></i> Erro</a>";
																	}

																	return htmlParaRenderizar;
																}

															} ]
												});

								//$('#tblRemessa').dataTable().fnSetFilteringEnterPress();
								$('#btnPesquisar')
										.click(
												function() {
													dto.cod = $('#cod').val();
													dto.tipoEnvio = $(
															'#tipoEnvio').val();
													dto.tipo = $('#tipo').val();
													dto.situacao = $(
															'#situacao').val();
													dto.dthInicio = $(
															'#dthInicio').val();
													dto.dthFim = $('#dthFim')
															.val();
													dto.codUsuarioInclusao = $(
															'#codUsuarioInclusao')
															.val();

													dataTable.draw();
												});

								// Invalidar importação
								$('#btnYes')
										.click(
												function() {
													$
															.ajax(
																	{
																		url : "/sicap-webapp/manager/remessa/cancela_importacao",
																		data : {
																			"cod_importacao" : codImportacaoCancelar
																		},
																		method : "POST"
																	})
															.done(
																	function() {

																		dataTable
																				.draw();

																		toastr
																				.success("A importação nº "
																						+ codImportacaoCancelar
																						+ " foi invalidada com sucesso!");

																	});
												})

								/* 		dataTable.on('order', function() {
											if (dataTable.page() !== page) {
												dataTable.page(page).draw('page');
											}
										});

										dataTable.on('page', function() {
											page = dataTable.page();
										}); */

							});

			var codAviso = 0;
			var codUsuarioQuadroAvisoUg = 0;

			// Buscar Avisos
			function buscarAvisos() {
				$
						.ajax(
								{
									url : "/sicap-webapp/manager/quadro_avisos/buscarAvisosNaoLido",
									type : 'POST'
								})
						.done(
								function(retorno) {

									if (retorno) {
										codAviso = retorno.cod_aviso;
										codUsuarioQuadroAvisoUg = retorno.quadroAvisoUg.cod;
										$('#tituloModal')
												.html(
														retorno.quadroAvisoUg.quadroAviso.titulo);
										$('#cod_aviso')
												.html(
														retorno.quadroAvisoUg.cod_aviso);

										if (retorno.quadroAvisoUg.quadroAviso.img != null) {
											$('.modal-dialog').addClass(
													'modal-lg');

											var imgTag = document
													.createElement('img');
											imgTag
													.setAttribute(
															'src',
															retorno.quadroAvisoUg.quadroAviso.img);
											imgTag.setAttribute('style',
													'width:100%;height:100%');
											$('#corpoModal').append(imgTag)
										} else {
											$('#corpoModal')
													.html(
															retorno.quadroAvisoUg.quadroAviso.texto);
											$('.modal-dialog').addClass(
													'modal-md');
										}
										$('#modalQuadroDeAvisos').modal();

									}
								});
			}
			buscarAvisos();

			function limparImportacao() {
				$("input[name='cod']").val('');
			}

			var codImportacaoCancelar = 0;
			function cancelarImportacao(codImportacao) {
				codImportacaoCancelar = codImportacao;
			}

			$(document)
					.ready(
							function() {

								// Alterar aviso para lido
								$('#btnAlterarAvisoParaLido')
										.click(
												function() {
													$
															.ajax(
																	{
																		url : '/sicap-webapp/manager/quadro_avisos/setarAvisoComoLido/'
																				+ codUsuarioQuadroAvisoUg,
																		type : 'POST',
																		contentType : "application/json"
																	})
															.then(
																	function(
																			data) {
																		toastr
																				.success(data);
																	})
															.fail(
																	function(
																			data) {
																		toastr
																				.warning(data);
																	});
												});

								$("#cod").val("");
								$('.dataMask').mask('00/00/0000');
								$(".dataMask")
										.datepicker(
												{
													dateFormat : 'dd/mm/yy',
													dayNames : [ 'Domingo',
															'Segunda', 'Terça',
															'Quarta', 'Quinta',
															'Sexta', 'Sábado' ],
													dayNamesMin : [ 'D', 'S',
															'T', 'Q', 'Q', 'S',
															'S', 'D' ],
													dayNamesShort : [ 'Dom',
															'Seg', 'Ter',
															'Qua', 'Qui',
															'Sex', 'Sáb', 'Dom' ],
													monthNames : [ 'Janeiro',
															'Fevereiro',
															'Março', 'Abril',
															'Maio', 'Junho',
															'Julho', 'Agosto',
															'Setembro',
															'Outubro',
															'Novembro',
															'Dezembro' ],
													monthNamesShort : [ 'Jan',
															'Fev', 'Mar',
															'Abr', 'Mai',
															'Jun', 'Jul',
															'Ago', 'Set',
															'Out', 'Nov', 'Dez' ],
													nextText : 'Próximo',
													prevText : 'Anterior',
													onClose : function(
															dateText, inst) {
														if (!validaDat(dateText)) {
															$('#btnSubmit')
																	.prop(
																			"disabled",
																			"disabled");
														} else {
															$('#btnSubmit')
																	.prop(
																			"disabled",
																			"");
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
									} else if (((ardt[1] == 4)
											|| (ardt[1] == 6) || (ardt[1] == 9) || (ardt[1] == 11))
											&& (ardt[0] > 30))
										erro = true;
									else if (ardt[1] == 2) {
										if ((ardt[0] > 28)
												&& ((ardt[2] % 4) != 0))
											erro = true;
										if ((ardt[0] > 29)
												&& ((ardt[2] % 4) == 0))
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

									$('#cod').val("");

									$("select").each(function() {
										$(this).val("0");
									});

									$('#btnSubmit').prop("disabled", "");
								});

								/* 			function carregaTabela(){
												
												$('#tableRemessa')
												.dataTable(
														{
															responsive : true,
															bFilter : false,
															bLengthChange : false,
															bAutoWidth : false,
															ordering : true,
															iDisplayLength : 10,
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
																"sSearch" : "Pesquisar",
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
												
											}
											
											carregaTabela(); */

							});

			$(function() {
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
