<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<style>
svg {
	background-color: none;
}
</style>
		<h1 class="one">
			<span>Relatório Admissão</span>

		</h1>
		<div class="space-20"></div>
		<div class="row">
			<div class="col-sm-5">
				<div class="form-group">
					<select class="form-control input-sm" id="dropTipoRelatorio">
						<option value="">Selecione</option>
						<option value="1">Servidores mencionados no XML de Plano
							de Cargos</option>
						<option value="2">Servidores importados via XML de
							Admissões</option>
					</select>
				</div>
			</div>
			<div class="col-sm-1"></div>
			<div class="col-sm-6">
				<div class="form-group text-right">
					<a data-toggle="tooltip"
						title="Visualizar Admissões Retificadas"
						class='btn btn-default'
						href='/sicap-webapp/manager/relatorio/remessas-descartadas'><i
						class='glyphicon glyphicon-eye-open'></i> Visualizar Admissões
						Retificadas</a> <a data-toggle="tooltip"
						title="Acessar Consulta de Importação" class='btn btn-default'
						href='/sicap-webapp/manager/remessa'><i class='fa fa-search'></i>
						Consulta de Importação</a>
				</div>
			</div>
		</div>
		<script
			src="${pageContext.request.contextPath}/resources/relatorio_folha/fusioncharts.js?cacheBust=56"></script>
		<script
			src="${pageContext.request.contextPath}/resources/relatorio_folha/fusioncharts.charts.js?cacheBust=56"></script>
		<!-- <script type="text/javascript"
			src="http://static.fusioncharts.com/code/latest/fusioncharts.js?cacheBust=56"></script>
		<script type="text/javascript"
			src="http://static.fusioncharts.com/code/latest/fusioncharts.charts.js?cacheBust=56"></script> -->

		<div id="chart-container">TCE/MS</div>
		<div class="space-20"></div>

		<div class="row" style="margin: 0px;">
			<table id="tableAdmissao"
				class="table table-striped table-responsive">
				<thead>
					<tr>
						<th>Servidor Admitido/CPF</th>
						<th>Importação/Remessa/Situação</th>
						<th>Tipo/Provimento/Matrícula</th>
						<th>Função</th>
						<th>Data Ínicio</th>
						<th>Data Fim</th>
						<th>Status</th>
						<th>Ação</th>
					</tr>
				</thead>
				<tbody>
				</tbody>
			</table>
		</div>
		<script>
			$(document).ready(function() {
				$('#carregando').modal({
					keyboard : true,
					show : false
				});

				$("#dropTipoRelatorio").change(function() {

					if ($('#dropTipoRelatorio').val()) {
						$('#carregando').modal('show');

						CarregarGrafico($("#dropTipoRelatorio").val());
						//$('#tableAdmissao tbody').html('');
						$('#tableAdmissao').DataTable().clear().draw();
					}
				});
			});

			function listaAdmissao(param, tipoRelatorio) {
				$('#carregando').modal('show');
				param = param.replace("#", "?");
				$('#tableAdmissao').DataTable().destroy();

				//Formatação de data atual pt-BR
				var hoje = new Date();
				var dd = hoje.getDate();
				var mm = hoje.getMonth() + 1;
				var yyyy = hoje.getFullYear();
				var HH = hoje.getHours();
				var minutes = hoje.getMinutes();
				var segundos = hoje.getSeconds();

				if (dd < 10) {
					dd = '0' + dd;
				}

				if (mm < 10) {
					mm = '0' + mm;
				}

				if (HH < 10) {
					HH = '0' + HH;
				}

				if (minutes < 10) {
					minutes = '0' + minutes;
				}

				if (segundos < 10) {
					segundos = '0' + segundos;
				}

				var dataFormatada = dd + '/' + mm + '/' + yyyy + ' ' + 'às'
						+ ' ' + HH + ':' + minutes + ':' + segundos;

				table = $('#tableAdmissao')

						.DataTable(
								{
									dom : 'Bfrtip',

									buttons : [
											{
												extend : 'pdf',
												messageTop : 'Tribunal de Contas do Estado de Mato Grosso do Sul - TCE/MS (Relatório de Admissões - Unidade Gestora: ${usr.nomeUg} - Gerado por: ${usr.nome} em '
														+ dataFormatada + ').',
												className : 'btn btn-danger',
												exportOptions : {
													columns : [ 0, 1, 4, 5, 6 ]
												},
												customize : function(doc) {
													doc['footer'] = (function(
															page, pages) {
														return {
															columns : [
																	{
																		alignment : 'left',
																		text : [ '' ]
																	},
																	{
																		alignment : 'right',
																		text : [ 'Página '
																				+ page
																				+ ' de '
																				+ pages ]
																	} ],
															margin : 20
														}
													});

												}
											},
											{
												extend : 'excel',
												className : 'btn btn-success',
												messageTop : ' '
														+ ' Relatório de Admissões (U.G.: ${usr.nomeUg} - Gerado por: ${usr.nome} em '
														+ dataFormatada + ')',
												//text : 'Exportar para Excel',
												exportOptions : {
													columns : [ 0, 1, 2, 3, 4,
															5, 6 ]

												}
											} ],

									initComplete : function() {
										$('.buttons-pdf')
												.html(
														'<span><i class="glyphicon glyphicon-export"></i> Exportar para PDF</span>')
										$('.buttons-excel')
												.html(
														'<span><i class="glyphicon glyphicon-export"></i> Exportar para Excel</span>')
									},
									processing : true,
									searching : true,
									serverSide : false,
									sAjaxSource : "/sicap-webapp/manager/relatorio/lista_admissao"
											+ param
											+ "&tipo_relatorio="
											+ tipoRelatorio,
									responsive : true,
									bFilter : false,
									bLengthChange : false,
									bAutoWidth : false,
									iDisplayLength : 10,
									columnDefs : [ {
										"width" : "3%",
										"targets" : 0

									}, {
										"width" : "23%",
										"targets" : 1

									}, {
										"width" : "20%",
										"targets" : 2

									}, {
										"width" : "30%",
										"targets" : 3
									}, {
										"width" : "10%",
										"targets" : 4

									}, {
										"width" : "10%",
										"targets" : 5

									}, {
										"width" : "2%",
										"targets" : 6

									}, {
										"width" : "2%",
										"targets" : 7

									} ],

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
										"sSearch" : "Pesquisar: ",
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
				$('#carregando').modal('hide');

			}

			function CarregarGrafico(tipoRelatorio) {

				var chartdata = "";

				$
						.ajax(
								{
									url : "/sicap-webapp/manager/relatorio/grafico_admissao",
									data : {
										"tipo_relatorio" : tipoRelatorio
									},
									method : "POST",
									success : function(data) {
										chartdata = data;

										var total = data[0].total;

										FusionCharts
												.ready(function() {

													var revenueChart = new FusionCharts(
															{
																type : 'doughnut2d',
																renderAt : 'chart-container',
																width : '100%',
																exportEnabled : 1,
																height : '450',
																dataFormat : 'json',
																dataSource : {
																	"chart" : {
																		"caption" : "Admissões Ativas/Inativas",
																		"subCaption" : "Tipos: Concursado, Comissionado, Contratado, Convocado, Membro de Poder, Agente Politico e Conselheiro Tutelar.",
																		"numberPrefix" : "",
																		"paletteColors" : "#0075c2,#1aaf5d,#f2c500,#f45b00,#9400D3,#B03060,#FA8072",
																		"bgColor" : "#F7F7F7",
																		"showBorder" : "0",
																		"use3DLighting" : "0",
																		"showShadow" : "0",
																		"enableSmartLabels" : "1",
																		"startingAngle" : "310",
																		"showLabels" : "0",
																		"showPercentValues" : "1",
																		"showLegend" : "1",
																		"legendShadow" : "1",
																		"legendBorderAlpha" : "0",
																		"centerLabelBold" : "1",
																		"showTooltip" : "0",
																		"decimals" : "0",
																		"defaultCenterLabel" : "Total de admissões: "
																				+ total,
																		"enableMultiSlicing" : "0",
																		"captionFontSize" : "16",
																		"subcaptionFontSize" : "16",
																		"subcaptionFontBold" : "1",
																		"theme" : "fint",
																		"animation" : "1"
																	},
																	"data" : chartdata
																}

															});

													var myEventListenerLinkClicked = function(
															eventObj, dataObj) {
														listaAdmissao(
																dataObj['linkProvided'],
																tipoRelatorio);
													};

													var myEventListenerLegendItemClicked = function(
															eventObj, dataObj) {
														listaAdmissao(
																dataObj['link'],
																tipoRelatorio);
													};

													revenueChart
															.addEventListener(
																	"linkClicked",
																	myEventListenerLinkClicked);
													revenueChart
															.addEventListener(
																	"legendItemClicked",
																	myEventListenerLegendItemClicked);
													revenueChart.render();
												});
									}
								}).done(function() {
							$('#carregando').modal('hide');
						});
			};

			$(function() {
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
