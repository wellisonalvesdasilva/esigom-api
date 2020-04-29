<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<style>
.background {
	background: #cccccc;
}
</style>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1>
			<span>2) Anexar Lei(s) à Importação de Plano de Cargos</span>
		</h1>
		<h4 class="one">Importação Código: ${codImportacao} - Situação:
			Em Rascunho</h4>
		<div class="space-20"></div>
		<div class="row">
			<div class="col-lg-6"></div>
			<div class="col-lg-6 text-right">
				<a href='/sicap-webapp/manager/donwload?caminho=${caminhoXml}'
					class="btn btn-info" type="button"> <i class="fa fa-download"></i>
					Baixar XML
				</a>
				<button onclick="openModalInvalidarOuConcluirEnvio(2)"
					id="btnConcluirEnvio" name="btnConcluirEnvio"
					class="btn btn-success" type="button" disabled>
					<i class="fa fa-check"></i> Concluir Envio da Importação
				</button>
			</div>
			<div class="space-20"></div>
			<div class="col-lg-12">
				<table class="table table-striped table-responsive" id="tableLei">
					<thead>
						<tr>
							<th class="text-center"><strong>Número Lei</strong></th>
							<th class="text-center"><strong>Ano</strong></th>
							<th><strong>Tipo Lei</strong></th>
							<th class="text-center"><strong>Data de Publicação</strong></th>
							<th><strong>Arquivo</strong></th>
							<th><strong>Arquivo Hash</strong></th>
							<th class="text-center"><strong>Anexado no ZIP</strong></th>
							<th class="text-center"><strong>Ação</strong></th>
						</tr>
					</thead>

					<tbody>
						<c:forEach var="it" items="${lista}" varStatus="status">
							<tr>
								<td class="text-center">${it.numeroLei}</td>
								<td class="text-center">${it.anoLei}</td>
								<td>${it.tipoLei}</td>
								<td class="text-center">${it.dataPublicacao}</td>
								<td>${it.nomeArquivo}</td>
								<td>${it.arquivoHash}</td>

								<td class="text-center"><c:choose>
										<c:when
											test="${it.uploadManual == false && it.srcDocumento != null}">
											Sim
										</c:when>
										<c:otherwise>Não</c:otherwise>
									</c:choose></td>

								<td class="text-center"><c:choose>
										<c:when test="${it.srcDocumento == null || it.uploadManual}">
											<button class="btn btn-primary" type="button" title="Upload"
												data-toggle="tooltip"
												onclick="enviarPDF('${it.nomeArquivo}','${it.arquivoHash}', '${it.codDocumento}')">
												<i class="fa fa-upload"></i>
											</button>
										</c:when>
									</c:choose> <c:choose>
										<c:when test="${it.srcDocumento != null}">
											<a class="btn btn-danger"
												href='/sicap-webapp/manager/donwload?caminho=${it.srcDocumento}'
												type="button" title="Download" data-toggle="tooltip"> <i
												class="fa fa-file-pdf-o"></i>
											</a>
										</c:when>
									</c:choose></td>
							</tr>
						</c:forEach>
					</tbody>

				</table>
			</div>
		</div>
		<div class="row panel-footer">
			<div class="col-lg-3 col-md-3 col-sm-6">
				<a href='/sicap-webapp/manager/remessa' type="button"
					class="btn btn-default btn-block btn-pesquisa"> <i
					class="fa fa-ban"></i> Consulta de Importação
				</a>
			</div>
			<div class="col-lg-3 col-md-2 col-sm-2">
				<button class="btn btn-danger btn-block btn-pesquisa"
					id="btnInvalidar" name="btnInvalidar" type="button"
					title="Adicionar Lei" data-toggle="tooltip"
					onclick="openModalInvalidarOuConcluirEnvio(1)">
					<i class="fa fa-times"></i> Invalidar Importação
				</button>
			</div>
		</div>

		<div id="modalAdicionar" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Realizar Upload do PDF da Lei</h4>
					</div>
					<form onsubmit="desabilitarBotao()" id="formId" method="POST"
						enctype="multipart/form-data">
						<div class="modal-body">
							<div class="row">
								<div class="col-lg-4 col-md-4 col-sm-4">
									<div class="form-group">
										<label>Arquivo</label> <span class="form-control background"
											id="spanArquivo"></span>
									</div>
									<input type="hidden" id="arquivo" name="arquivo"> <input
										type="hidden" id="codDocumento" name="codDocumento">
								</div>
								<div class="col-lg-5 col-md-5 col-sm-5">
									<div class="form-group">
										<label>Arquivo Hash</label> <span
											class="form-control background" id="spanArquivoHash"></span>
									</div>
									<input type="hidden" id="arquivoHash" name="arquivoHash">
								</div>
								<div class="col-lg-3 col-md-3 col-sm-3">
									<div class="form-group">
										<label>PDF (Até 200 Megabytes)</label> <input
											onchange="ValidateSize(this)" class="form-control background"
											type="file" name="file" accept=".pdf">
									</div>
								</div>

							</div>
						</div>
						<div class="modal-footer">
							<button class="btn btn-primary" id="btnSalvar"
								title="Adicionar Lei" type="submit">
								<i class="fa fa-save"></i> Salvar
							</button>

							<button type="button" id="btnFechar" class="btn btn-default"
								data-dismiss="modal">
								<i class="glyphicon glyphicon-remove"></i>&nbsp;Fechar
							</button>
						</div>
					</form>
				</div>
			</div>
		</div>

		<div id="modalInvalidarOuConcluirEnvio" class="modal fade"
			role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Confirmação de Procedimento</h4>
					</div>
					<form>
						<div class="modal-body">
							<p id="msg"></p>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-warning"
								data-dismiss="modal">Não</button>
							<button onclick="confirmarAcao()" type="button"
								class="btn btn-primary" data-dismiss="modal">Sim</button>
						</div>
					</form>
				</div>
			</div>
		</div>
		<script>

		var podeEnviarPDF = true;
		
		function ValidateSize(file) {
			
			$('#btnSalvar').addClass("disabled");
			 var fileSize = file.files[0].size / 1024; // in kB
			 var nomeArquivo = file.files[0].name;
			 
			 // Verificar tamanho do arquivo
			 if(fileSize > 25000){
				 toastr.error('O arquivo ' +nomeArquivo+ ' deve possuir tamanho máximo de 200 Megabytes.');
				 podeEnviarPDF = false;
			 } else {
				 podeEnviarPDF = true;
			 }
			
			 if (!podeEnviarPDF){
				$('#btnSalvar').addClass("disabled");
			} else {
				$('#btnSalvar').removeClass("disabled");
			}
					
		}
			
			var acaoLei;
			function openModalInvalidarOuConcluirEnvio(acao){
				acaoLei = acao;
				
				if(acao == 2){
					$('#msg').html("Deseja Realmente Concluir o Envio da Importação?");
				} else {
					$('#msg').html("Deseja Realmente Invalidar esta Importação?");
				}
				
				
				$('#modalInvalidarOuConcluirEnvio').modal({
					backdrop : 'static',
					keyboard : false
				});
			}
			
			/* EVENTO CONFIRMAR AÇÃO */
			var action;
			function confirmarAcao(){
			
				toastr.info("Aguarde.... solicitação em andamento!");
				
				// Desabilitar Botões
				document.getElementById("btnConcluirEnvio").disabled = true;
				document.getElementById("btnInvalidar").disabled = true;
				
				if(acaoLei == 2){
					action = "concluirEnvioImportacao";
				} else {
					action = "cancelaImportacao";
				}
				// Chamada AJAX
				$.ajax({
					url : action,
					data : {"codImportacao" : ${codImportacao}},
					method : "POST"
					})
				.done(function(cancelou) {
					if(cancelou == true){
						toastr.success("Ação realizada com sucesso.");
						window.location.href = "/sicap-webapp/manager/remessa";
					} else {
						document.getElementById("btnConcluirEnvio").disabled = false;
						document.getElementById("btnInvalidar").disabled = false;
					}
				});
				
			}
		
	
			// Ao Carregar a Página Verificar se o Botão de Conclusão Pode ser Habilitado
			$(function() {
				if(${documentosEnviados}){
					document.getElementById("btnConcluirEnvio").disabled = false;
				}
				
				if(${primeiroAcesso}){
					toastr.success("Rascunho salvo com sucesso!");
				}
				
				
				$('#btnSalvar').addClass("disabled");
				
			});
			
						
			function enviarPDF(nomeArquivo, arquivoHash, codDocumento) {

				/* SPAN VISUALIZAÇÃO DO USUÁRIO */
				$('#spanArquivo').html(nomeArquivo);
				$('#spanArquivoHash').html(arquivoHash);

				/* PARÂMETROS API */
				$('#arquivo').val(nomeArquivo);
				$('#arquivoHash').val(arquivoHash);
				$('#codDocumento').val(codDocumento);
				
				$('#modalAdicionar').modal({
					backdrop : 'static',
					keyboard : false
				});
			}

			function desabilitarBotao() {
				$('#btnSalvar').prop("disabled", "disabled");
				$('#btnFechar').prop("disabled", "disabled");
			}

		
		var table = $('#tableLei')
					.DataTable(
							{
								responsive : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,
								columnDefs : [ {
									"width" : "11%",
									"targets" : 0
								}, {
									"width" : "5%",
									"targets" : 1

								}, {
									"width" : "13%",
									"targets" : 2

								}, {
									"width" : "18%",
									"targets" : 3

								}, {
									"width" : "13%",
									"targets" : 4
								}, {
									"width" : "9%",
									"targets" : 5
								}, {
									"width" : "16%",
									"targets" : 6
								}, {
									"width" : "15%",
									"targets" : 7
								}, ],
								order : [ [ 6, "asc" ] ],
								language : {
									"sEmptyTable" : "Nenhuma lei foi cadastrada.",
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