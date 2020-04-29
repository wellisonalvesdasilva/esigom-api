<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">

		<h1 class="one">
			<span>Relatório de Vacância</span>
		</h1>
		<div class="space-20"></div>
		<form:form method="POST" cssClass='form-horizontal'
			commandName='vacancia' id="formPesquisa">
					<div class="row">

				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Cód. Admissão</label> <input id='codAdmissao' type="number"
							min="1" max="999999" name='codAdmissao' class="form-control"
							placeholder="Cód. Admissão"
							value='${(fn:escapeXml(param.codAdmissao))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>CPF</label> <input id='cpf' name='cpf' class="form-control"
							placeholder="CPF" value='${(fn:escapeXml(param.cpf))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Nome</label> <input id='name' name='nome'
							class="form-control" placeholder="Nome"
							value='${(fn:escapeXml(param.nome))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Tipo Vacância</label> <select id="tipoVacancia"
							name="tipoVacancia" class="form-control"
							value='${(fn:escapeXml(param.tipoVacancia))}'>
							<c:forEach var="item" items='${tipoVacancias}'>
								<option value='${item.key}'
									<c:if test="${item.key == tipoVacanciaSelecionada}"> selected="selected"</c:if>>${item.value}</option>
							</c:forEach>
						</select>
					</div>
				</div>

				<div class="col-lg-2 col-md-2 col-sm-4">
					<button type="submit"
						class="btn btn-primary btn-block btn-pesquisa">
						<i class="fa fa-search"></i> Pesquisar
					</button>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-4">
					<a href='/sicap-webapp/manager/relatorio/vacancia' id="reset"
						type="button" class="btn btn-default btn-block btn-pesquisa">
						<i class="glyphicon glyphicon-refresh"></i> Limpar
					</a>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a href='/sicap-webapp/manager/remessa' id="reset" type="button"
						class="btn btn-default btn-block btn-pesquisa"> <i
						class="fa fa-search"></i> Consulta de Importação
					</a>
				</div>

				<div class="col-lg-3 col-md-2 col-sm-4">
					<button type="button" id="buttonReportVacancia"
						title="Gerar Relatório de Vacâncias da Unidade Gestora"
						onclick="gerarRelatorioVacancia()"
						class="btn btn-danger btn-block btn-pesquisa">
						<i class="fa fa-file-pdf-o"></i> Exportar para PDF
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
						<th><strong>Cód. Vacância</strong></th>
						<th><strong>Cód. Admissão</strong></th>
						<th><strong>Nome Pessoa/CPF</strong></th>
						<th><strong>Matrícula</strong></th>
						<th><strong>Tipo Vacância</strong></th>
						<th><strong>Data Vacância</strong></th>
						<th><strong>Status</strong></th>
						<th><strong>Ações</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="it" items="${vacancias}" varStatus="status">
						<tr>
							<td class="text-center">${it.cod}</td>
							<td class="text-center">${it.admissao.cod}</td>
							<td>${it.admissao.pessoa.nome}&nbsp;(${it.admissao.pessoa.cpf})<c:choose>
									<c:when test="${it.admissao.remessa.importacao.tipo == 1}">&nbsp;<i
											class="glyphicon glyphicon-warning-sign"
											title="Vacância refere-se à um servidor enviado no Plano de Cargos"></i>
									</c:when>
									<c:otherwise></c:otherwise>
								</c:choose>
							</td>

							<td class="text-center">${it.admissao.matricula}-${it.admissao.dvMatricula}</td>
							<td class="text-center">${it.tipoVacancia.descricao}</td>
							<td class="text-center"><fmt:formatDate pattern="dd/MM/yyyy"
									value="${it.dataVacancia}" /></td>
							<td><c:choose>
									<c:when test="${it.descartado == true}">Cancelado</c:when>
									<c:otherwise>Ativo</c:otherwise>
								</c:choose></td>
							<td>
								<button data-toggle="tooltip"
									title="Detalhe Importação Vacância" class="btn btn-info"
									type="button" onclick="visualizarDetalheRemessa('${it.cod}')">
									<i class="glyphicon glyphicon-search"></i>
								</button>
								<button data-toggle="tooltip" title="Detalhe Admissão"
									class="btn btn-default" type="button"
									onclick="detalhesAdmissao(
									'${it.admissao.pessoa.nome}',
									 '${it.admissao.pessoa.cpf}',
									 '${it.admissao.tipoAdmissao}',
									 '${it.admissao.dataPosse}',
									 '${it.admissao.remessa.importacao.cod}',
									 '${it.admissao.cargoAtributo.cargo.descricao}',
									 '${it.admissao.cargoAtributo.cargo.codCbo}'
									)">
									<i class="glyphicon glyphicon-list-alt"></i>
								</button> <c:choose>
									<c:when test="${it.descartado == true}">
										<button data-toggle="tooltip"
											onclick="obterArquivo('${it.cod}')"
											title="Download Justificativa de Cancelamento"
											class="btn btn-warning" type="button" onclick="#">
											<i class="glyphicon glyphicon-download-alt"></i>
										</button>
									</c:when>
								</c:choose>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="modalDetalhesAdmissao" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h3 class="modal-title">Detalhe Admissão</h3>
					</div>

					<div class="modal-header">
						<table class="table table-bordered table-striped"">
							<thead>
								<h4>Dados Pessoais</h4>
								<tr>
									<th>Nome</th>
									<th>CPF</th>
								</tr>
							</thead>
							<tbody>
								<tr class="ng-scope">
									<td><span id="lblNome"></span></td>
									<td><span id="lblCPF"></span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-header">
						<table class="table table-bordered table-striped"">
							<thead>
								<h4>Dados Admissão</h4>
								<tr>
									<th>Cód. Importação</th>
									<th>Tipo Admissão</th>
									<th>Data da Posse</th>
								</tr>
							</thead>
							<tbody>
								<tr class="ng-scope">
									<td><a id='editarFuncionario' class='btn btn-xs btn-info'>
											<i class='fa fa-search'></i>
									</a> &nbsp;<span id="lblCodImportacaoAdmissao"></span></td>
									<td><span id="lblTipoAdmissao"></span></td>
									<td><span id="lblDataPosse"></span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-header">
						<table class="table table-bordered table-striped"">
							<thead>
								<h4>Dados Cargo</h4>
								<tr>
									<th>Descrição Cargo</th>
									<th>CBO Cargo</th>
								</tr>
							</thead>
							<tbody>
								<tr class="ng-scope">
									<td><span id="lblDescricaoCargo"></span></td>
									<td><span id="lblCboCargo"></span></td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="reset" class="btn btn-default" data-dismiss="modal">Fechar</button>
					</div>
				</div>
			</div>
		</div>
		<div id="modalDetalheRemessa" class="modal fade" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Detalhe Importação Vacância</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>Código Importação</th>
									<th>Código Remessa</th>
									<th>Responsável pelo Envio</th>
								</tr>
							</thead>
							<tbody id="registro">
							</tbody>
						</table>
						<div class="modal-footer">
							<button type="button" class="btn btn-default"
								data-dismiss="modal">
								<i class="glyphicon glyphicon-remove"></i>&nbsp;Fechar
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<script>
		
		
		/// <--- Gerar PDF de Vacância --- > ///
		function gerarRelatorioVacancia() {
			toastr.info("Aguarde.... solicitação em andamento!");
			document.getElementById("buttonReportVacancia").disabled = true;
			var dto = {};
			dto.codAdmissao = $('#codAdmissao').val();
			dto.cpf = $('#cpf').val();
			dto.nome = $('#name').val();
			dto.tipoVacancia = $('#tipoVacancia').val();
				
			$.ajax({
				url : 'exportPdfRelatorioVacanciaPorUnidadeGestora',
				type : 'POST',
				data: {params: JSON.stringify(dto)}
			})
			.done(function(response) {
				
				console.log(response.length);
				// PDF com Informações sem Resultado
				if(response.length < 17500){
					toastr.error("PDF não gerado. Nenhum registro foi encontrado para os dados fornecidos!");
				} else {
					toastr.success("PDF gerado com sucesso! Abrindo...");
					let pdfWindow = window.open();
					pdfWindow.document.write("<iframe width='100%' height='100%' src='data:application/pdf;base64, " + encodeURI(response)+"'></iframe>");
					pdfWindow.document.title = "Relatório de Vacância";
				}
				document.getElementById("buttonReportVacancia").disabled = false;
		});
		}
		
		
		$(document).ready(function() {

			function getParameterByName(name, url) {
			    if (!url) url = window.location.href;
			    name = name.replace(/[\[\]]/g, '\\$&');
			    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
			        results = regex.exec(url);
			    if (!results) return null;
			    if (!results[2]) return '';
			    return decodeURIComponent(results[2].replace(/\+/g, ' '));
			}
			
			var codSolicitacaoUrl = getParameterByName('codAdmissao');
				if(codSolicitacaoUrl){
					console.log(document.querySelectorAll('#formPesquisa input'));
					document.querySelectorAll('#formPesquisa input,#formPesquisa select').forEach(function(item){
						item.disabled = true;
					});
				}
				
			$('#codAdmissao').mask('000000');
			$('#cpf').mask('00000000000');
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
		
		/// <--- Funções que invocam modais --- > ///
		function obterArquivo(cod) {
			$('.loader').show();
			$
					.ajax({
						url : 'downloadJustificativaDeRecusa/' + cod,
						type : 'POST',
						data : {
							cod : cod
						}
					})
					
					// Preparar dados com o retorno da função
					.done(function(response) {
								$('.loader').hide();
								//window.top = response.justificativa;
								window.open(response.justificativa, '_blank');
				});
		}

		
		
			/// <--- Visualizar Detalhe Importação Vacância --- > ///
			function visualizarDetalheRemessa(cod) {
				$('.loader').show();
				$
						.ajax({
							url : 'obterDadosRemessa/' + cod,
							type : 'POST',
							data : {
								cod : cod
							}
						})
						
						// Preparar dados com o retorno da função
						.done(
								function(response) {
									$('.loader').hide();
									$('#registro')
											.html(
													'<tr>'
															+'<td style="text-transform: uppercase" class="ng-binding">'
															+ response.codImportacao
															+ '</td>' 
															+ '<td style="text-transform: uppercase" class="ng-binding">'
															+ response.codRemessa
															+ '</td>'
															+ '<td style="text-transform: uppercase" class="ng-binding">'
															+ response.usuarioInclusao
															+ '</td>'
													+ '<tr>'
											);
									
									/// Abrir Modal
									$('#modalDetalheRemessa').modal({
										backdrop : 'static',
										keyboard : false
									});
								});
			}

			function detalhesAdmissao(nome, cpf, tipo_admissao, data_posse,
					codImportacaoAdmissao, descricaoCargo, codCboCargo) {
				$('#modalDetalhesAdmissao').modal();
				$('#lblNome').html(nome);
				$('#lblCPF').html(cpf);
				$('#lblCodImportacaoAdmissao').html(codImportacaoAdmissao);

				switch (tipo_admissao) {
				case "1":
					$('#lblTipoAdmissao').html('Concursado');
					break;

				case "2":
					$('#lblTipoAdmissao').html('Comissionado');
					break;

				case "3":
					$('#lblTipoAdmissao').html('Contratado');
					break;

				case "4":
					$('#lblTipoAdmissao').html('Convocado');
					break;

				case "5":
					$('#lblTipoAdmissao').html('Membro de Poder');
					break;

				case "6":
					$('#lblTipoAdmissao').html('Agente Político');
					break;

				case "7":
					$('#lblTipoAdmissao').html('Função Gratificada');
					break;

				case "8":
					$('#lblTipoAdmissao').html('Conselheiro Tutelar');
					break;

				default:
					$('#lblTipoAdmissao').html('-');
					break;
				}

				$('#lblDataPosse').html((data_posse == "" ? '-' : data_posse));
				$('#lblDescricaoCargo').html(
						(data_posse == "" ? '-' : descricaoCargo));
				$('#lblCboCargo').html((data_posse == "" ? '-' : codCboCargo));
				$('#editarFuncionario').attr(
						'href',
						'/sicap-webapp/manager/remessa/detalhe_remessa?cod_importacao='
								+ codImportacaoAdmissao).attr('target',
						'_blank');
			}


			
			
			var table = $('#tableVacancia')
					.DataTable(
							{
								responsive : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,
								columnDefs : [ {
									"width" : "11",
									"targets" : 0
								}, {
									"width" : "12%",
									"targets" : 1
								}, {
									"width" : "24%",
									"targets" : 2
								}, {
									"width" : "9%",
									"targets" : 3
								}, {
									"width" : "12%",
									"targets" : 4
								}, {
									"width" : "11%",
									"targets" : 5
								}, {
									"width" : "7%",
									"targets" : 6
								}, {
									"width" : "14%",
									"targets" : 7
								}, ],
								order : [ [ 0, "desc" ] ],
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