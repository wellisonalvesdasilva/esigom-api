<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<style>
svg {
	background-color: none;
}

@media print {
	body {
		font-size: 10px !important;
	}
	h2, h1 {
		font-size: 18px !important;
	}
	.btn-group, footer, nav {
		display: none !important;
	}
	.space-20 {
		height: 0px;
	}
	.download {
		display: none !important;
	}
}
</style>
		<h1>Detalhe Importação</h1>
		<div class="row">
			<div class="col-md-12 text-right">
				<a class='btn btn-default' href='/sicap-webapp/manager/remessa'><i
					class="glyphicon glyphicon-backward"></i> Voltar à Consulta de
					Importações</a>
			</div>
		</div>
		<div class="space-20"></div>
		<c:if test="${not empty remessas}">
			<div class="row" style="margin: 0px;!important">
				<div class="panel panel-primary">
					<div class="panel-heading">Detalhe Remessa</div>
					<div class="panel-body">
						<div class="col-md-12">
							<table class="table  table-responsive" id="tableRemessa">
								<thead style="background-color: transparent;">
									<tr>
										<td colspan="5"><h3>Acompanhamento das Remessas
												Geradas</h3></td>
									</tr>
									<tr>
										<th class="text-center"><strong>Remessa</strong></th>
										<th class="text-center"><strong>Protocolo</strong></th>
										<th class="text-center"><strong>Processo</strong></th>
										<th class="text-center"><strong>Descrição</strong></th>
										<th id="thAnexos" class="text-center" style="display: none;"><strong>Anexos
												Febraban (Resolução 88)</strong></th>
										<th class="text-center"><strong>Ações</strong></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="remessa" items="${remessas}" varStatus="status">
										<tr>
											<td class="text-center"><c:choose>
													<c:when test="${remessa.cod == NULL}">
														-
													</c:when>
													<c:otherwise>
													${remessa.cod}
													</c:otherwise>
												</c:choose></td>
											<td class="text-center"><c:choose>
													<c:when test="${remessa.codProtocolo == NULL}">
														-
													</c:when>
													<c:otherwise>
													${remessa.codProtocolo}
													</c:otherwise>
												</c:choose></td>
											<td class="text-center"><c:choose>
													<c:when test="${remessa.codProcesso == NULL}">
														-
													</c:when>
													<c:otherwise>
													${remessa.codProcesso}
													</c:otherwise>
												</c:choose></td>
											<td><c:choose>
													<c:when test="${remessa.importacao.tipo == 4}">
														${remessa.descricao} <a class="btn-xs btn-default"
															data-toggle="tooltip" role="button"
															title='Visualizar Importação da Admissão Enviada'
															onclick="obterDetalheAdmissao('${remessa.numeroReferencia}')"
															target="_blank"> <i class="fa fa-search"></i>
														</a>
													</c:when>
													<c:otherwise>
													${remessa.descricao}
													</c:otherwise>
												</c:choose></td>
											<td class="text-center" style="display: none;" id="tdAnexos"><a
												class="btn btn-info" id='buttonRemessaFebrabam'><i
													class="fa fa-download"></i> Remessa</a> <a class="btn btn-info"
												id='buttonRetornoBancarioFebrabam'><i
													class="fa fa-download"></i> Retorno Bancário</a></td>
											<td width="30%" class="text-center"><c:choose>
													<c:when
														test="${remessa.importacao.situacao != 7 && remessa.importacao.tipo != 4 && remessa.importacao.tipo != 7 && remessa.importacao.tipoEnvio != 2 && remessa.importacao.tipo != 1 && remessa.importacao.tipo != 2}">
														<a class="btn btn-primary"
															onclick='visualizarDocumentos(${remessa.cod})'><i
															class="fa fa-info-circle"></i> Ver Documentos</a>
													</c:when>
												</c:choose> <c:choose>
													<c:when
														test="${remessa.importacao.situacao == 3|| remessa.importacao.situacao == 7  || remessa.importacao.situacao == 8 || remessa.importacao.situacao == 9	 }">
														<button id="${remessa.cod}" class="btn btn-warning"
															onclick='imprimirReciboDeRemessa(${remessa.cod})'><i
															class="fa fa-file-pdf-o"></i> Recibo Remessa</button>
													</c:when>
												</c:choose></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<c:if test="${not empty erros}">
			<div class="row" style="margin: 0px;!important">
				<div class="panel panel-danger">
					<div class="panel-heading">Dados Erro</div>
					<div class="panel-body">
						<div class="col-md-12">
							<div class="row" style="margin: 0px;!important">
								<div class="col-md-3 col-xs-3">
									<div class="form-group">
										<label for="email">Quantidade de Erros</label> <label
											class="form-control background">${fn:length(erros)}</label>
									</div>
								</div>
								<div class="col-md-9 col-xs-9">
									<div class="form-group">
										<label for="email">Download do arquivo</label> <label
											class="form-control"
											style="border: medium none; box-shadow: none;"> <a
											href="/sicap-webapp/manager/donwload?caminho=${importacao.arquivoErro}">Download
												Arquivo</a>
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</c:if>
		<div class="row" style="margin: 0px;!important">
			<c:choose>
				<c:when test="${importacao.situacao != NULL}">
					<div class="panel panel-primary">
						<div class="panel-heading">Detalhes da Importação</div>
						<div class="panel-body">
							<div class="row" style="margin: 0px;!important">
								<div class="col-md-1 col-xs-3">
									<div class="form-group">
										<label for="cod">Código</label> <label
											class="form-control background">${importacao.codImportacao}</label>
									</div>
								</div>
								<div class="col-md-2 col-xs-9">
									<div class="form-group">
										<label for="tpImportacao">Tipo Importação</label> <label
											class="form-control background">${importacao.nomeTipoImportacao}</label>
									</div>
								</div>
								<div class="col-md-3 col-xs-3">
									<div class="form-group">
										<label for="email">Situação Importação </label> <label
											class="form-control background"><tce:situacaoImportacaoDescricao
												value="${importacao.situacao}" /></label>
									</div>
								</div>
								<div class="col-md-2 col-xs-9">
									<div class="form-group">
										<label for="data">Data Inclusão</label> <label
											class="form-control background"><fmt:formatDate
												pattern="dd/MM/yyyy" value="${importacao.dthInclusao}" /></label>
									</div>

								</div>
								<div class="col-md-4 col-xs-9">
									<div class="form-group">
										<label for="email">Responsável pelo Envio</label> <label
											class="form-control background">${importacao.responsavelEnvio}</label>
									</div>
								</div>
							</div>
							<c:if test="${not empty documentosImportacao}">
								<c:choose>
									<c:when
										test="${importacao.situacao != 9 && importacao.situacao != 3 && importacao.situacao != 1 && importacao.situacao != 2 && importacao.situacao != 4 && importacao.situacao != 5 && importacao.situacao != 10 && importacao.situacao != 8}"></c:when>
									<c:otherwise>
										<div class="col-md-12 col-xs-12">
											<table class="table  table-responsive" id="tableRemessa">
												<thead style="background-color: transparent;">
													<tr>
														<td colspan="4"><h3></h3></td>
													</tr>
													<tr>
														<th><strong>Nome do arquivo</strong></th>
														<th><strong>Hash arquivo</strong></th>
														<th><strong>Tipo do Arquivo</strong></th>
														<th><strong>Ação</strong></th>
													</tr>
												</thead>
												<tbody>
													<c:forEach var="documento" items="${documentosImportacao}"
														varStatus="status">
														<tr>
															<td>${documento.arquivo}</td>
															<td>${documento.hashArquivo}</td>
															<td>${documento.tipoArquivo}</td>
															<td><a class='btn btn-primary download'
																type="button"
																href='/sicap-webapp/manager/donwload?caminho=${documento.storage}/${documento.arquivo}'>
																	<i class="fa fa-download"></i> Baixar arquivo
															</a></td>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</c:otherwise>
								</c:choose>
							</c:if>
						</div>
					</div>
				</c:when>
				<c:otherwise>
				</c:otherwise>
			</c:choose>
			<c:if test="${empty documentosImportacao}">
				<div class="panel panel-primary">
					<div class="panel-heading">Atenção</div>
					<div class="panel-body">
						<div class="col-md-12 col-xs-12">
							<strong><i class="fa fa-info-circle"></i> Os documentos
								enviados nesta importação encontram-se indisponíveis para
								visualização no momento.</strong>
						</div>
					</div>
				</div>
			</c:if>
		</div>
		<div class="space-20"></div>
		<div id="modalListaDocumentos" class="modal fade" role="dialog">
			<div class="modal-dialog modal-lg">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Visualizar Documentos Remessa</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th class="text-center">Código</th>
									<th class="text-center">Nome Arquivo</th>
									<th class="text-center">Hash</th>
									<th class="text-center">Ação</th>
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

 		function obterDetalheAdmissao(cod) {
			$.ajax({
				url : 'obterDetalheVacancia/'+cod,
				type : 'POST'
			}).done(function(response) {
				console.log(response);
				
				if(response){
					window.open("detalhe_remessa?cod_importacao="+response, '_blank');
				}
			});
		}

		if(${importacao.tipoImportacao == 7}){
		function obterAnexosFebraban() {
		var codImportacao = ${importacao.codImportacao};
			$.ajax({
				url : 'obterAnexosFebraban/'+codImportacao,
				type : 'POST'
			}).done(function(response) {
				if(response){
					$("#thAnexos").show();
					$("#tdAnexos").show();
					if(response.caminhoArquivoRemessaFebrabam && response.caminhoArquivoRetornoBancarioFebrabam)
					{
						$('#buttonRemessaFebrabam').attr(
								'href',
								response.caminhoArquivoRemessaFebrabam).attr('target',
								'_blank');
						$('#buttonRetornoBancarioFebrabam').attr(
								'href',
								response.caminhoArquivoRetornoBancarioFebrabam).attr('target',
								'_blank');
					}
				}
			});
			}	
		obterAnexosFebraban();
		}
	

		
		// Visualizar Documentos Remessa
			function visualizarDocumentos(cod) {
				$
						.ajax({
							url : 'obterDocumentosRemessa/' + cod,
							type : 'POST',
							data : {
								cod : cod
							}
						})
						.done(
								function(valor) {
									$('#registro').html("");
								console.log(valor);

								valor.forEach(function(valor){
										$('#registro').append('<tr>' 
															
															+'<td style="text-transform: uppercase" class="ng-binding text-center">'
																	+valor.cod+'</td>'
																	
															+'<td style="text-transform: uppercase" class="ng-binding">'
																	+valor.arquivo+'</td>'
																	
															+'<td style="text-transform: uppercase" class="ng-binding">'
																	+valor.hashArquivo+'</td>'
																	
															+'<td class="text-center"><a type="button" href="/sicap-webapp/manager/donwload?caminho='
																	+valor.urldownload+
																	'"class="btn btn-primary download"><i class="fa fa-download"></i></a></td>'
																	
															+'<tr>');				
									});	
									
									/// Abrir Modal
									$('#modalListaDocumentos').modal({
										backdrop : 'static',
										keyboard : false
									});
									
									$('.loader').hide();
									
								});
			}

			var sucessoMessage = "${message}";
			if (sucessoMessage != "") {
				toastr.warning("${message}");
			}
			
			
			// Imprimir Recibo de Remessa
			
		function imprimirReciboDeRemessa(codRemessa){
													var filtros = {};
													document.getElementById(codRemessa).disabled = true;
													filtros.codRemessa = codRemessa;
													toastr.info("Aguarde a geração do Recibo de Remessa em instantes...");
													
													// Chamada Ajax
													var req = new XMLHttpRequest();
													req.open("POST","gerarReciboRemessa");
													req.responseType = "blob";
													req.setRequestHeader(
																	'Content-type',
																	'application/x-www-form-urlencoded ; charset=utf-8');
													req.send("filtros="+JSON.stringify(filtros));

													// Callback
													req.onload = function(event) {
														var blob = req.response;

														var link = document
																.createElement('a');
														link.href = window.URL
																.createObjectURL(blob);
														link.download = "[SICAP]Recibo-Remessa-"
														+codRemessa+".pdf";
														link.click();
														toastr.success("Recibo gerado com sucesso!");
														document.getElementById(codRemessa).disabled = false;
													};
													
											
												}
			
			
		
		$(function() {
			$('[data-toggle="tooltip"]').tooltip()
		})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
