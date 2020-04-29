<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- <style>
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
</style> -->

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Consulta de Retifica��o</span>
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
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>C�digo Solicita��o</label> <input
							placeholder='C�d. Solicita��o' type='number' min="0" max="999999"
							name='codSolicitacao' id='codSolicitacao' class="form-control"
							value='${(fn:escapeXml(param.codSolicitacao))}' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Remessa</label> <input placeholder='Remessa' min="0"
							max="999999" type='number' name='codRemessa' id='codRemessa'
							class="form-control" value='${(fn:escapeXml(param.codRemessa))}' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Importa��o</label> <input placeholder='Importa��o' min="0"
							max="999999" type='number' name='codImportacao'
							id='codImportacao' class="form-control"
							value='${(fn:escapeXml(param.codImportacao))}' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Data Solicita��o (�nicio)</label>
					<div class="input-group">
						<input type='text' name='dataInicioVigencia'
							id='dataInicioVigencia' autocomplete="off"
							class="form-control dataMask" placeholder="DD/MM/AAAA"
							value='${(fn:escapeXml(param.dataInicioVigencia))}' /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Data Solicita��o (Fim)</label>
					<div class="input-group">
						<input type='text' name='dataFimVigencia' autocomplete="off"
							id='dataFimVigencia' class="form-control dataMask"
							placeholder="DD/MM/AAAA"
							value='${(fn:escapeXml(param.dataFimVigencia))}' /> <span
							class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-4 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Solicitante</label> <input
							placeholder='Informe o Nome do Solitante' type='text'
							name='solicitante' id='solicitante' class="form-control"
							maxlength="60" value='${(fn:escapeXml(param.solicitante))}' />
					</div>
				</div>
				<div class="col-lg-4 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Status da Solicita��o</label> <select name="codStatus"
							id="codStatus" class="form-control">
							<option value="">Selecione</option>
							<option value="1">Solicita��o Aguardando Valida��o</option>
							<option value="2">Solicita��o Cancelada</option>
							<option value="3">Solicita��o Aprovada</option>
							<option value="4">Solicita��o Recusada</option>
							<option value="5">Solicita��o Em An�lise</option>
						</select>
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Motivo</label> <select name="tipo" id="tipo"
							class="form-control">
							<option value="">Selecione</option>
							<option value="1">Duplicidade</option>
							<option value="2">Erro no XML</option>
						</select>
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>A��o Desejada</label> <select name="acao" id="acao"
							class="form-control">
							<option value="">Selecione</option>
							<option value="1">Reenviar</option>
							<option value="2">Descartar</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a data-toggle="tooltip" title="Visualizar Admiss�es Retificadas"
						class='btn btn-default btn-block btn-pesquisa'
						href='/sicap-webapp/manager/relatorio/remessas-descartadas'><i
						class='glyphicon glyphicon-eye-open'></i> Visualizar Admiss�es
						Retificadas</a>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a href='/sicap-webapp/manager/retificacaoRemessa' id="reset"
						type="button" class="btn btn-default btn-block btn-pesquisa">
						<i class="glyphicon glyphicon-refresh"></i> Limpar Campos
					</a>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<button type="submit"
						class="btn btn-primary btn-block btn-pesquisa">
						<i class="fa fa-search"></i> Pesquisar
					</button>
				</div>
				<div class="col-lg-3 col-md-2 col-sm-4">
					<a data-toggle="tooltip" title="Solicitar Nova Retifica��o"
						class='btn btn-success btn-block btn-pesquisa'
						href='/sicap-webapp/manager/retificacaoRemessa/cadastrar'><i
						class='glyphicon glyphicon-plus'></i> Solicitar Nova Solicita��o</a>
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
				id="tableSolicitacaoDeRetificacao">
				<thead>
					<tr>
						<th class="text-center"><strong>C�digo</strong></th>
						<th class="text-center"><strong>Data da Solicita��o</strong></th>
						<th class="text-center"><strong>A��o</strong></th>
						<th class="text-center"><strong>Solicitante</strong></th>
						<th class="text-center"><strong>Tipo Importa��o</strong></th>
						<th class="text-center"><strong>Status</strong></th>
						<th class="text-center"><strong>A��es</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="it" items="${resultado}" varStatus="status">
						<tr>
							<td class="text-center">${it.cod}</td>
							<td class="text-center"><fmt:formatDate pattern="dd/MM/yyyy"
									value="${it.dataInclusao}" /></td>
							<td class="text-center"><c:choose>
									<c:when test="${it.acao == 1 && it.tipo == 1}">Reenviar por Duplicidade</c:when>
									<c:when test="${it.acao == 1 && it.tipo == 2}">Reenviar por Erro no XML</c:when>
									<c:when test="${it.acao == 2 && it.tipo == 1}">Descartar por Duplicidade</c:when>
									<c:when test="${it.acao == 2 && it.tipo == 2}">Descartar por Erro no XML</c:when>
								</c:choose></td>
							<td>${it.pessoa.nome}</td>
							<td><c:choose>
									<c:when test="${it.codTipoImportacao == 1}">
												Admiss�o
									</c:when>
									<c:when test="${it.codTipoImportacao == 2}">
												Vac�ncia
									</c:when>
									<c:when test="${it.codTipoImportacao == 3}">
												Concurso P�blico
									</c:when>
								</c:choose></td>


							<td class="text-center"><c:choose>
									<c:when test="${it.situacao == 1}">
										<span
											class="label ellipsis_150 ng-isolate-scope ng-binding label-default"
											title="Solicita��o Aguardando Valida��o"
											data-toggle="tooltip"
											style="display: block; margin: 0; padding: 11.5px;">
											Solicita��o Aguardando Valida��o </span>
									</c:when>
									<c:when test="${it.situacao == 2}">
										<span
											class="label ellipsis_150 ng-isolate-scope ng-binding label-warning"
											title="Solicita��o Cancelada" data-toggle="tooltip"
											style="display: block; margin: 0; padding: 11.5px;">
											Solicita��o Cancelada </span>
									</c:when>
									<c:when test="${it.situacao == 3}">
										<span
											class="label ellipsis_150 ng-isolate-scope ng-binding label-success"
											title="Solicita��o Aprovada" data-toggle="tooltip"
											style="display: block; margin: 0; padding: 11.5px;">
											Solicita��o Aprovada </span>
									</c:when>
									<c:when test="${it.situacao == 4}">
										<span
											class="label ellipsis_150 ng-isolate-scope ng-binding label-danger"
											title="Solicita��o Recusada" data-toggle="tooltip"
											style="display: block; margin: 0; padding: 11.5px;">
											Solicita��o Recusada</span>
									</c:when>
									<c:when test="${it.situacao == 5}">
										<span
											class="label ellipsis_150 ng-isolate-scope ng-binding label-warning"
											title="Solicita��o Em An�lise" data-toggle="tooltip"
											style="display: block; margin: 0; padding: 11.5px;">
											Solicita��o Em An�lise</span>
									</c:when>
								</c:choose></td>
							<td class="text-center"><c:choose>
									<c:when test="${it.situacao == 1}">
										<button id="cancelar" name="cancelar" data-toggle="tooltip"
											title="Cancelar Solicita��o" class="btn btn-danger"
											type="button" onclick="cancelarSolicitacao(${it.cod})">
											<i class="glyphicon glyphicon-remove"></i>
										</button>
									</c:when>
								</c:choose>
								<button id='editarAviso' data-toggle="tooltip"
									onclick="visualizarRemessas(${it.cod})"
									title="Ver Remessas V�nculadas" class='btn btn-default'>
									<i class='glyphicon glyphicon-list-alt'></i>
								</button>
								<button id='visualizarDetalhes' data-toggle="tooltip"
									title="Visualizar Detalhes" type="button" class='btn btn-info'
									onclick="visualizarDetalhesSolicitacao(${it.cod})">
									<i class='glyphicon glyphicon-zoom-in'></i>
								</button> <a id='editarAviso' data-toggle="tooltip" title="Ver Hist�rico"
								href='/sicap-webapp/manager/retificacaoRemessa/historico/${it.cod}'
								class='btn btn-primary'> <i
									class='glyphicon glyphicon-hourglass'></i>
							</a> <c:choose>
									<c:when
										test="${(it.situacao == 3  && it.acao == 1 && (it.codImportacaoUltimoEnvio == null || (it.importacao.situacao == 2 || it.importacao.situacao == 4 || it.importacao.situacao == 5 || it.importacao.situacao == 6 || it.importacao.situacao == 7)))}">
										<a id='editarAviso' data-toggle="tooltip"
											href='/sicap-webapp/manager/importacao/?codSolicitacaoRetificacao=${it.cod}'
											target="_blank" title="Enviar Nova Importa��o"
											class='btn btn-warning'> <i
											class='glyphicon glyphicon-upload'></i> Reenviar
										</a>
									</c:when>
									<c:when
										test="${(it.situacao == 3  && it.acao == 1 && (it.codImportacaoUltimoEnvio == null || (it.importacao.situacao == 2 || it.importacao.situacao == 4 || it.importacao.situacao == 5 || it.importacao.situacao == 6 || it.importacao.situacao == 7)))}">
										<a id='editarAviso' data-toggle="tooltip"
											href='/sicap-webapp/manager/importacao/?codSolicitacaoRetificacao=${it.cod}'
											target="_blank" title="Enviar Nova Importa��o"
											class='btn btn-warning'> <i
											class='glyphicon glyphicon-upload'></i>
										</a>
									</c:when>
								</c:choose> <c:choose>
									<c:when test="${(it.codImportacaoUltimoEnvio != null)}">
										<a id='editarAviso' data-toggle="tooltip"
											onclick="visualizarDetalheImportacaoRemessa(${it.codImportacaoUltimoEnvio})"
											target="_blank"
											title="Ver detalhes da �ltima importa��o enviada como resposta"
											class='btn btn-success'> <i
											class='glyphicon glyphicon-eye-open'></i> Reenvio
										</a>
									</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="myModalDetalhesSolicitacao" class="modal fade" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Detalhes da Solicita��o de
							Retifica��o</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<div class="form-horizontal" role="form">
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>Data
												Inclus�o:</strong> </label>
										<div class="col-lg-8">
											<div class="form-control-static ng-binding" id="dataInclusao"></div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>Status:</strong>
										</label>
										<div class="col-lg-8">
											<div class="form-control-static ng-binding" id="status"></div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>Tipo
												Envio:</strong> </label>
										<div class="col-lg-8">
											<div class="form-control-static ng-binding"
												id="tipoImportacao"></div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>A��o
												Desejada:</strong> </label>
										<div class="col-lg-8">
											<div class="form-control-static ng-binding" id="tipoAcao"></div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>Anexo:</strong>
										</label>
										<div class="col-lg-8">
											<a class="btn btn-primary" id="linkDownload"
												name="linkDownload" title="Download" target="_blank"><i
												class="glyphicon glyphicon-download-alt"></i> Justificativa
											</a>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>Mais
												Detalhes:</strong> </label>
										<div class="col-lg-8">
											<div class="form-control-static ng-binding"
												id="detalhesSolicitacao"></div>
										</div>
									</div>
								</div>
							</div>
						</div>
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
		<form:form id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Aten��o</h4>
					</div>
					<div class="modal-body">
						<p>Deseja realmente cancelar essa solicita��o de Retifica��o?</p>
					</div>
					<div class="modal-footer">
						<button type="button" name="noCancelar" id="noCancelar"
							class="btn btn-default" data-dismiss="modal">Cancelar</button>
						<button name="goCancelar" id="goCancelar" type="button"
							class="btn btn-primary">Confirmar</button>
					</div>
				</div>
			</div>
		</form:form>
		<div id="modalRemessasViculadas" class="modal fade" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Remessas V�nculadas � Solicita��o de
							Retifica��o</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>C�digo Importa��o</th>
									<th>C�digo Remessa</th>
									<th>Descri��o XML</th>
								</tr>
							</thead>
							<tbody id="listaDeRemessas">
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
		<div id="modalDetalheRemessa" class="modal fade" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Detalhe Nova Importa��o Enviada</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th>C�digo Importa��o</th>
									<th>Situa��o</th>
									<th>Data de Envio</th>
									<th>Tipo Importa��o</th>
								</tr>
							</thead>
							<tbody id="retornoDetalheImportacao">
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
		
		function getParameterByName(name, url) {
		    if (!url) url = window.location.href;
		    name = name.replace(/[\[\]]/g, '\\$&');
		    var regex = new RegExp('[?&]' + name + '(=([^&#]*)|&|#|$)'),
		        results = regex.exec(url);
		    if (!results) return null;
		    if (!results[2]) return '';
		    return decodeURIComponent(results[2].replace(/\+/g, ' '));
		}
		
		
		$(document).ready(function() {
			var codSolicitacaoUrl = getParameterByName('codSolicitacao');
		
			if(codSolicitacaoUrl){
				console.log(document.querySelectorAll('#formPesquisa input'));
				document.querySelectorAll('#formPesquisa input,#formPesquisa select').forEach(function(item){
					item.disabled = true;
				});
			}	
	
			// Mantem selecionado os dados dos dropdowns quando o usu�rio clica sobre o bot�o [Pesquisar]
			var valor = JSON.stringify(${(fn:escapeXml(param.tipo))});
			valor ? document.getElementById("tipo").value = valor : document.getElementById("tipo").value = '';
		
			var valor = JSON.stringify(${(fn:escapeXml(param.acao))});
			valor ? document.getElementById("acao").value = valor : document.getElementById("acao").value = '';
			
			var valor = JSON.stringify(${(fn:escapeXml(param.codStatus))});
			valor ? document.getElementById("codStatus").value = valor : document.getElementById("codStatus").value = '';
			
			if(!$('#codSolicitacao').val() && !$('#codRemessa').val() && !$('#codImportacao').val() && (!$('#codStatus').val() == 1 || !$('#codStatus').val()) && !$('#dataFimVigencia').val() && !$('#solicitante').val()&& !$('#tipo').val()){
				document.getElementById("codStatus").value = 1;
			}
			
			// evento que limpa os valores preenchidos nos campos quando o usu�rio clica sobre o bot�o [Limpar]
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
		
		function visualizarDetalheImportacaoRemessa(cod) {
			$('.loader').show();
			$
					.ajax({
						url : 'retificacaoRemessa/obterDadosRemessa/'+cod,
						type : 'POST',
						data : {
							cod : cod
						}
					})
					// Preparar dados com o retorno da fun��o
					.done(
							function(response) {
								$('.loader').hide();
								
								$('#retornoDetalheImportacao')
										.html(
													'<tr>'
														+'<td style="text-transform: uppercase" class="ng-binding"><a class="btn btn-xs btn-info " title="Visualizar Importa��o" target="_blank" href="/sicap-webapp/manager/remessa/detalhe_remessa?cod_importacao='
														+response.codImportacao+'"><i class="glyphicon glyphicon-search"></i></a>&nbsp;'+response.codImportacao+'</td>'
														+'<td style="text-transform: uppercase" class="ng-binding">'
														+ response.situacao
														+ '</td>'
														+'<td style="text-transform: uppercase" class="ng-binding">'
														+ dataAtualFormatada(response.dataEnvio)
														+ '</td>' 
														+ '<td style="text-transform: uppercase" class="ng-binding">'
														+ response.tipoImportacao
														+ '</td>'
												+ '<tr>'
										);
								
								// Abrir Modal
								$('#modalDetalheRemessa').modal({
									backdrop : 'static',
									keyboard : false
								});
							});
						}
					
		
		
		function dataAtualFormatada(miliseconds){
		    var data = new Date(miliseconds);
		    var dia = data.getDate();
		    if (dia.toString().length == 1)
		      dia = "0"+dia;
		    var mes = data.getMonth()+1;
		    if (mes.toString().length == 1)
		      mes = "0"+mes;
		    
		    var hora = data.getHours();
		    if (hora.toString().length == 1)
		    	hora = "0"+hora;
		    
		    var minutos = data.getMinutes();
		    if (minutos.toString().length == 1)
		    	minutos = "0"+minutos;
		    
		    var segundos = data.getSeconds();
		    if (segundos.toString().length == 1)
		    	segundos = "0"+segundos;
		    
		    
		    var ano = data.getFullYear();  
		    return dia+"/"+mes+"/"+ano+" "+hora+":"+minutos+":"+segundos;   
		}
		
		
		
		
		var codSolicitacaoNovaImportacao = 0;
		function novaImportacao(codSolicitacao){
			
			codSolicitacaoNovaImportacao = codSolicitacao;
			
			$('#newImportacao').modal({
				backdrop : 'static',
				keyboard : false
			});
		}
		
		
		// Return situa��o
		function retornarSituacao(situacao){
		  
			if(situacao == 1){
				return "Aguardando Valida��o";
			}
			
			if(situacao == 2){
				return "Cancelada";
			}
			
			if(situacao == 3){
				return "Aprovada";
			}
			
			if(situacao == 4){
				return "Recusada";
			}
			
			if(situacao == 4){
				return "Em An�lise";
			}
			
		}
		
		// Return tipo
			function retornarTipoImportacao(tipo){
		  
			if(tipo == 1){
				return "Admiss�o";
			}
			
			if(tipo == 2){
				return "Vac�ncia";
			}
			
			if(tipo == 3){
				return "Concurso P�blico";
			}
			
		}

		function retornarTipoAcao(acao){
			  
				if(acao == 1){
					return "Reenviar";
				}
				
				if(acao == 2){
					return "Descartar";
				}
			}
			
			
			function retornarTipoMotivo(motivo){
			  
				if(motivo == 2){
					return "por Erro no XML";
				}
				
				if(motivo == 1){
					return "por Duplicidade";
				}
			}
				
		
		function visualizarDetalhesSolicitacao(cod) {
			$('.loader').show();
			$
					.ajax({
						url : 'retificacaoRemessa/listarSolicitacaoRetificacao/'+cod,
						type : 'POST',
						data : {
							cod : cod
						}
					})
					
					// Preparar dados com o retorno da fun��o
					.done(
							function(response) {
								
								// ativar loeader
								$('.loader').hide();
								
								// preparar os dados
								$('#dataInclusao').html(dataAtualFormatada(response.dataInclusao));
								$('#status').html(retornarSituacao(response.situacao));
								$('#tipoImportacao').html(retornarTipoImportacao(response.tipoImportacao));
								$('#tipoAcao').html(retornarTipoAcao(response.acao)+" "+retornarTipoMotivo(response.tipo));
								$('#detalhesSolicitacao').html(response.detalhesSolicitacao);
								$('#importacaoTipo').html(response.tipoImportacao);
								$("#linkDownload").attr("href", response.arquivoJustificativa);
								
								/// Abrir Modal
								$('#myModalDetalhesSolicitacao').modal({
									backdrop : 'static',
									keyboard : false
								});
							});
		}
								
			
		// limpar campos
		$("#reset").click(function() {
			$(":text").each(function() {
				$(this).val("");
			});
			$("select").each(function() {
				$(this).val("");
			});
		});

		// Iniciar a lista sempre vazia
		function visualizarRemessas(cod)
			{
			$('.loader').show();
			$('#listaDeRemessas').html('');	
			
			$.ajax({
				url:'retificacaoRemessa/listarRemessasSolicitacao/'+cod,
				type:'POST',
				data: {cod: cod}
			}).done(function(response){
				$('.loader').hide();
				console.log(response);
				response.forEach(function(valor){
					$('#listaDeRemessas').append('<tr>' 
							+'<td style="text-transform: uppercase" class="ng-binding"><a class="btn btn-xs btn-info " title="Visualizar Importa��o" target="_blank" href="/sicap-webapp/manager/remessa/detalhe_remessa?cod_importacao='
							+valor.codImportacao+'"><i class="glyphicon glyphicon-search"></i></a>&nbsp;'+valor.codImportacao+'</td>'

							+'<td style="text-transform: uppercase" class="ng-binding">'
									+valor.codRemessa+'</td>'
							+'<td style="text-transform: uppercase" class="ng-binding">'
									+valor.descricao+'</td>'
							+'<tr>');				
				});	
				// Abrir Modal
				$('#modalRemessasViculadas').modal({
					backdrop : 'static',
					keyboard : false
				});
			});
		}
		
		/* // Toastr
		var sucessoMessage = "${message}";
		if (sucessoMessage != "") {
			toastr.success("${message}");
		} */
		
		// Abrir modal
		var codSolicitacaoCancelar = 0;		
		function cancelarSolicitacao(cod) {
			codSolicitacaoCancelar = cod;
			$('#myModal').modal({
				backdrop : 'static',
				keyboard : false
			});
		}
				
		// Datatables
					var table = $('#tableSolicitacaoDeRetificacao')
					.DataTable(
							{
								responsive : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,
								columnDefs : [ {
									"width" : "3%",
									"targets" : 0
								}, {
									"width" : "15%",
									"targets" : 1
									
								}, {
									"width" : "9%",
									"targets" : 2
									
								}, {
									"width" : "20%",
									"targets" : 3
									
								}, {
									"width" : "13%",
									"targets" : 4
								}, {
									"width" : "6%",
									"targets" : 5
								}, {
									"width" : "34%",
									"targets" : 6
								}, ],
								order : [ [ 4, "asc" ] ],
								language : {
									"sEmptyTable" : "Nenhum registro encontrado",
									"sInfo" : "Mostrando de _START_ at� _END_ de _TOTAL_ registros",
									"sInfoEmpty" : "Mostrando 0 at� 0 de 0 registros",
									"sInfoFiltered" : "(Filtrados de _MAX_ registros)",
									"sInfoPostFix" : "",
									"sInfoThousands" : ".",
									"sLengthMenu" : "_MENU_ resultados por p�gina",
									"sLoadingRecords" : "Carregando...",
									"sProcessing" : "Processando...",
									"sZeroRecords" : "Nenhum registro encontrado",
									"sSearch" : "Pesquisar por CPF: ",
									"oPaginate" : {
										"sNext" : "Pr�ximo",
										"sPrevious" : "Anterior",
										"sFirst" : "Primeiro",
										"sLast" : "�ltimo"
									},
									"oAria" : {
										"sSortAscending" : ": Ordenar colunas de forma ascendente",
										"sSortDescending" : ": Ordenar colunas de forma descendente"
									}
								}
							});

					$(function () {
						  $('[data-toggle="tooltip"]').tooltip()
					});
					
				// class = .
					$('.dataMask').mask('00/00/0000');
					$('.dataMask')
							.datepicker(
									{
										dateFormat : 'dd/mm/yy',
										dayNames : [ 'Domingo', 'Segunda', 'Ter�a',
												'Quarta', 'Quinta', 'Sexta', 'S�bado' ],
										dayNamesMin : [ 'D', 'S', 'T', 'Q', 'Q', 'S',
												'S', 'D' ],
										dayNamesShort : [ 'Dom', 'Seg', 'Ter', 'Qua',
												'Qui', 'Sex', 'S�b', 'Dom' ],
										monthNames : [ 'Janeiro', 'Fevereiro', 'Mar�o',
												'Abril', 'Maio', 'Junho', 'Julho',
												'Agosto', 'Setembro', 'Outubro',
												'Novembro', 'Dezembro' ],
										monthNamesShort : [ 'Jan', 'Fev', 'Mar', 'Abr',
												'Mai', 'Jun', 'Jul', 'Ago', 'Set',
												'Out', 'Nov', 'Dez' ],
										nextText : 'Pr�ximo',
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
		
					// Evento 3: Bot�o Transformar Aviso em Interno
					$('#goCancelar').click(function(){
						$('.loader').show();
						$('#goCancelar').attr('disabled','disabled');
						$('#noCancelar').attr('disabled','disabled');	
						$.ajax({
						url:'retificacaoRemessa/cancelar/'+codSolicitacaoCancelar,
						type:'POST',
						
					}).done(function(data){
						toastr.success(data);
						$('.loader').hide();
						setTimeout(function(){location.reload(); }, 1500);
				
					}).fail(function(data){
						toastr.warning(data);
						$('.loader').hide();
						setTimeout(function(){location.reload(); }, 1500);
					});		
					})
					
					
					// Evento de criar importa��o
						$('#btnCriarImportacao').click(function(e){
						$('.loader').show();
						$('#btnCriarImportacao').attr('disabled','disabled');
						$('#noCancelarCriacaoImportacao').attr('disabled','disabled');	
							
						// Iniciando vari�veis
						var tipoEnvio = "0";
						var file = "0";
							
						 	e.preventDefault();
						    //Disable submit button
						    $(this).prop('disabled',true);
						    
						    var form = document.forms.newImportacao;
						    var formData = new FormData(form);
						    	
						    // Ajax call for file uploaling
						    var ajaxReq = $.ajax({
								url:'retificacaoRemessa/enviar_importacao',
						      type : 'POST',
						      data : {dto:formData},
						      cache : false,
						      contentType : false,
						      processData : false,
						      xhr: function(){

						    //Get XmlHttpRequest object
						     var xhr = $.ajaxSettings.xhr() ;
						        
						        //Set onprogress event handler 
						         xhr.upload.onprogress = function(event){
						          	var perc = Math.round((event.loaded / event.total) * 100);
						          	$('#progressBar').text(perc + '%');
						          	$('#progressBar').css('width',perc + '%');
						         };
						         return xhr ;
						    	},
						    	beforeSend: function( xhr ) {
						    		//Reset alert message and progress bar
						    		$('#alertMsg').text('');
						    		$('#progressBar').text('');
						    		$('#progressBar').css('width','0%');
						              }
						    		
						});
						 // Called on success of file upload
						    ajaxReq.done(function(msg) {
						      $('#alertMsg').text(msg);
						      $('input[type=file]').val('');
						      $('button[type=submit]').prop('disabled',false);
						    });
						    
						    // Called on failure of file upload
						    ajaxReq.fail(function(jqXHR) {
						      $('#alertMsg').text(jqXHR.responseText+'('+jqXHR.status+
						      		' - '+jqXHR.statusText+')');
						      $('button[type=submit]').prop('disabled',false);
						    });
						 });
				
								
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>