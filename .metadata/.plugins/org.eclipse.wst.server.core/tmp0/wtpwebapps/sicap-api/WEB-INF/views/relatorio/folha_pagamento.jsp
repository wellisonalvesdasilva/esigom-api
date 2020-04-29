<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Relatório Folha de Pagamento</span>
		</h1>
		<div class="space-20"></div>
		<script
			src="${pageContext.request.contextPath}/resources/relatorio_folha/fusioncharts.js?cacheBust=56"></script>
		<script
			src="${pageContext.request.contextPath}/resources/relatorio_folha/fusioncharts.charts.js?cacheBust=56"></script>
		<script
			src="${pageContext.request.contextPath}/resources/relatorio_folha/fusioncharts.theme.fint.js?cacheBust=56"></script>

		<div class="space-20"></div>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='folha' id="formPesquisa">
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Ano Referência</label>
						<form:select path="anoReferencia" items="${anos}"
							cssClass="form-control" />
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
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a href='/sicap-webapp/manager/remessa' id="reset" type="button"
						class="btn btn-default btn-block btn-pesquisa"> <i
						class="fa fa-search"></i> Consulta de Importação
					</a>
				</div>
			</div>
		</form:form>
		<div class="divisor"></div>
		<br />
		<div class="row resultado">
			<h4>Resultados da pesquisa</h4>
		</div>
		<div id="chart-container">TCE/MS</div>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<table id="employee-grid"
				class="table table-striped table-responsive">
				<thead>
					<tr>
						<th>Nome</th>
						<th>CPF</th>
						<th>Matrícula</th>
						<th>Descrição Cargo</th>
						<th>CBO Cargo</th>
						<th>Ação</th>
					</tr>
				</thead>
				<div id="divBotoesRetornoFolha" style="display: none;">
					<div class="panel-heading">Anexos Febraban</div>
					<a class="btn btn-info" data-toggle="tooltip"
						id="buttonRemessaFebrabam"
						title="Arquivo Remessa Febraban enviado junto à Folha de Pagamento."><i
						class="glyphicon glyphicon-download-alt"></i> Remessa</a> <a
						class="btn btn-info" data-toggle="tooltip"
						id="buttonRetornoBancarioFebrabam"
						title="Arquivo Retorno Bancário Febraban enviado junto à Folha de Pagamento."><i
						class="glyphicon glyphicon-download-alt"></i> Retorno Bancário</a>
				</div>
				</div>
			</table>
		</div>

		<script type="text/javascript">
			$(document).ready(function() {
				
				$( "#reset" ).click(function() {
				 	
					$(":text").each(function () {
			        	$(this).val("");
			        });
			 
			        $("select").each(function () {
			            $(this).val("0");
			        });
				});	
				
				$('#carregando').modal('show');
				var chartdata = "";
				$.ajax({
					  url: "/sicap-webapp/manager/relatorio/grafico_folha_pagamento",
					  method: "POST",
					  data: {anoReferencia:${folha.anoReferencia}},
					  success: function(data){
						  chartdata = data; 
						  FusionCharts.ready(function () {
							    var revenueChart = new FusionCharts({
							        type: 'column2d',
							        renderAt: 'chart-container',
							        width: '100%',
							        height: '450',
							        dataFormat: 'json',
							        dataSource: {
							            "chart": {
							            	"caption": "Folha de Pagamento Referente ao Ano "+${anoReferencia},
							                "xAxisName": "Meses",
							                "yAxisName": "Valores",
							                "numberPrefix": "R$",
							                "bgColor": "#F7F7F7",
							                "theme" : "fint",
							                "decimals": "2",
							                "captionFontSize": "16",
							                "subcaptionFontSize": "16",
							                "subcaptionFontBold": "1",
							                "animation":"1",
						                    "legendBorderAlpha": "1",
						                    "placeValuesInside": "1",
						        			"rotateValues": "1",
						                    "forceDecimals": "1",
						                    "formatNumberScale": "0",
						                    "decimalSeparator": ",",
						                    "thousandSeparator": ".",
						                    "formatNumberScale":"0"
							            },
							            "data": chartdata
							        }
							    });
							    
							    var myEventListenerLinkClicked = function (eventObj, dataObj) {
							    	listaServidor(dataObj['linkProvided']);
						    	};
						    	
						    	revenueChart.addEventListener("linkClicked", myEventListenerLinkClicked);
							    revenueChart.render();
							});  	
					  }
				}).done(function() {
					$('#carregando').modal('hide');
				});
				
				function listaServidor(param){
					$('#carregando').modal('show');
			    	param = param.replace("#","?");
			    	$('#employee-grid').DataTable().destroy();
			    	$('#employee-grid').DataTable( {
			    		 processing: true,
						 searching: true,
						 serverSide: false, 
						 
						 ajax:{
				    			url:"/sicap-webapp/manager/relatorio/lista_folha_servidor"+param,
				    			type: "GET",
				    			dataSrc: function(json)
				    			
				    			{
				    				$("#divBotoesRetornoFolha").hide();
				    				$('#buttonFebrabam').removeAttr('href');
				    				$('#buttonFebrabam').removeAttr('target');
				    			
				    				if(json.caminhoArquivoRemessaFebrabam && json.caminhoArquivoRetornoBancarioFebrabam)
				    					{
				    					 	$("#divBotoesRetornoFolha").show();
				    						$('#buttonRemessaFebrabam').attr(
				    								'href',
				    								json.caminhoArquivoRemessaFebrabam).attr('target',
				    								'_blank');
				    						$('#buttonRetornoBancarioFebrabam').attr(
				    								'href',
				    								json.caminhoArquivoRetornoBancarioFebrabam).attr('target',
				    								'_blank');
				    					}
				    				return json.data;
				    			}
				    		},

				    	 responsive: true,
			    		 bFilter: false, 
						 bLengthChange: false,
						 bAutoWidth: false,
						 iDisplayLength: 10,
						 language:{
								"sEmptyTable": "Nenhum registro encontrado",
							    "sInfo": "Mostrando de _START_ até _END_ de _TOTAL_ registros",
							    "sInfoEmpty": "Mostrando 0 até 0 de 0 registros",
							    "sInfoFiltered": "(Filtrados de _MAX_ registros)",
							    "sInfoPostFix": "",
							    "sInfoThousands": ".",
							    "sLengthMenu": "_MENU_ resultados por página",
							    "sLoadingRecords": "Carregando...",
							    "sProcessing": "Processando...",
							    "sZeroRecords": "Nenhum registro encontrado",
							    "sSearch": "Pesquisar: ",
							    "oPaginate": {
							        "sNext": "Próximo",
							        "sPrevious": "Anterior",
							        "sFirst": "Primeiro",
							        "sLast": "Último"
							    },
							    "oAria": {
							        "sSortAscending": ": Ordenar colunas de forma ascendente",
							        "sSortDescending": ": Ordenar colunas de forma descendente"
							    }
						 }
					} );
			    	$('#carregando').modal('hide');
		}
			}
				);

			</script>
	</tiles:putAttribute>
</tiles:insertDefinition>