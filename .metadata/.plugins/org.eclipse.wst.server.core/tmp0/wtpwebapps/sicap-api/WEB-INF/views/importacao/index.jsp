<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.btn-file {
	position: relative;
	overflow: hidden;
}

.hide {
	display: none;
}

.btn-file input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	min-width: 100%;
	height: 32px;
	font-size: 100px;
	text-align: right;
	filter: alpha(opacity = 0);
	opacity: 0;
	outline: none;
	background: white;
	cursor: inherit;
	display: block;
}
</style>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Cadastrar Importação XML</span>
		</h1>
		<div class="space-20"></div>
		<div class="row">
			<div class="col-md-12">
				<div id="error" class="alert alert-danger" style="display: none;">
					<span id="errorMessage"></span>
				</div>
			</div>
		</div>
		<form:form id="form" method="post"
			action="${pageContext.request.contextPath}/manager/importacao/salvar"
			commandName="importacao" enctype="multipart/form-data">
			<div class="row">
				<div class="col-lg-12 col-md-6 col-sm-6">
					<div class="panel panel-primary">
						<div class="panel-heading">Dados do Envio</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-6 col-md-3 col-sm-4">
									<div class="form-group">
										<label>Tipo de Envio:</label> <br />
										<div class="btn-group btn-group-toggle" data-toggle="buttons">
											<label onclick="habilitarBotoes(1)"
												class="btn btn-primary btn-sm"> <input type="radio"
												required name="tipoimportacao" value="1" /> Plano de Cargos
											</label> <label onclick="trueConcursoPublico()"
												class="btn btn-primary btn-sm"> <input type="radio"
												required name="tipoimportacao" value="2" /> Concurso
												Público
											</label> <label onclick="habilitarBotoes(1)"
												class="btn btn-primary btn-sm"> <input type='radio'
												required name="tipoimportacao" value="3" /> Admissão
											</label> <label onclick="habilitarBotoes(1)"
												class="btn btn-primary btn-sm"> <input type="radio"
												required name="tipoimportacao" value="4" /> Vacância
											</label> <label onclick="enviarFolhaDePagamento()"
												class="btn btn-primary btn-sm"> <input type="radio"
												required name="tipoimportacao" value="7" /> Folha de
												Pagamento
											</label>
										</div>
										<p id="avisoJurisdicionado" class="help-block"
											style="display: none;">
											<i class="glyphicon glyphicon-info-sign"></i>
											&nbsp;Tratando-se de Prorrogação, é necessário mencionar o
											documento nº 1790 no XML, conforme Tabela SICAP. Caso
											contrário, a importação será recusada durante validação.
										</p>
									</div>
								</div>

								<div id="divProrrogacao" class="col-lg-2 col-md-3 col-sm-4"
									style="display: none;">
									<div class="form-group">
										<label> É prorrogação?</label> <br />
										<div class="btn-group btn-group-toggle" data-toggle="buttons">
											<label id="buttonSim" onclick="simProrrogacao()"
												class="btn btn-primary btn-sm"> <input type="radio"
												required id="prorrogacaoSim" name="prorrogacao" value="1" />
												Sim
											</label> <label id="buttonNao" onclick="naoProrrogacao()"
												class="btn btn-primary btn-sm active"> <input
												type="radio" required id="prorrogacaoNao" name="prorrogacao"
												value="0" checked /> Não
											</label>
										</div>
									</div>
								</div>
								<input type="hidden" value="${codSolicitacaoRetificacao}"
									id="codSolicitacaoRetificacao" name="codSolicitacaoRetificacao" />
								<div id="enviarXml" class="col-lg-3 col-md-6 col-sm-6 imp"
									style="display: none;">
									<div class="form-group">
										<label for="sel1">Arquivo ZIP</label> <input
											onchange="ValidateSize(this,'zip')" accept=".zip" type="file"
											name="file" id="file" class="form-control" accept=".zip">
										<span id="menagem"
											style="margin-left: 10px; color: red; display: none;">
											Tipo de arquivo inválido </span>
										<p class="help-block">
											<i class="glyphicon glyphicon-info-sign"></i> &nbsp;Aceito
											somente arquivo .ZIP até 1GB
										</p>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div id="panelFebrabam" style="display: none;" class="row">
				<div class="col-lg-7 col-md-6 col-sm-6">
					<div class="panel panel-primary">
						<div class="panel-heading">Anexos Febraban (Resolução 88)</div>
						<div class="panel-body">
							<div class="col-lg-6">
								<div class="form-group">
									<label for="sel1">Remessa Bancária</label> <input
										onchange="ValidateSize(this,'remessa')" type="file"
										name="febrabamRemessa" id="febrabamRemessa"
										class="form-control txt" accept=".zip"> <span
										id="menagem"
										style="margin-left: 10px; color: red; display: none;">
										Tipo de arquivo inválido </span>
								</div>
								<p class="help-block">
									<i class="glyphicon glyphicon-info-sign"></i>&nbsp; Aceito
									somente arquivo .ZIP até 1GB<span></span>
								</p>
							</div>
							<div class="col-lg-6">
								<div class="form-group">
									<label for="sel1">Retorno Bancário</label> <input
										onchange="ValidateSize(this,'retorno')" type="file"
										name="febrabamRetornoBancario" id="febrabamRetornoBancario"
										class="form-control txt" accept=".zip"> <span
										id="menagem"
										style="margin-left: 10px; color: red; display: none;">
										Tipo de arquivo inválido </span>

								</div>
								<p class="help-block">
									<i class="glyphicon glyphicon-info-sign"></i>&nbsp; Aceito
									somente arquivo .ZIP até 1GB<span></span>
								</p>
							</div>
						</div>
					</div>
				</div>
				<div class="col-lg-5 col-md-6 col-sm-6">
					<div class="panel panel-info">
						<div class="panel-heading">
							<i class="glyphicon glyphicon-exclamation-sign"></i> Deseja
							justificar a impossibilidade de enviar os "Anexos Febraban"?
						</div>
						<div class="panel-body">
							<div class="row">
								<div class="col-lg-4">
									<div class="form-group">
										<div class="btn-group btn-group-toggle" data-toggle="buttons"
											text-center>
											<label id="justificarSim" name="justificarSim"
												onclick="justificarNaoEnvio(1)"
												class="btn btn-primary btn-sm"> <input type="radio" 
												onchange="ValidateSize(this)" required id="justificarSim"
												name="justificarSim" value="1" /> Sim
											</label> <label id="justificarNao" name="justificarNao"
												onclick="justificarNaoEnvio(0)"
												class="btn btn-primary btn-sm active"> <input
												type="radio" required id="justificarNao"
												name="justificarNao" value="0" checked /> Não
											</label>
										</div>
									</div>
									<div style="display: none;" name="detalheJustificativa"
										id="detalheJustificativa">
										<span style="margin-left: 10px; color: red">
											Justificado.</span>
									</div>
								</div>
								<div class="col-lg-8">
									<div class="form-group">
										<label for="sel1">Justificativa (Aceito somente PDF
											até 1GB)</label> <input type="file" onchange="ValidateSize(this,'justificativa')" name="anexoJustificativa"
											id="anexoJustificativa" class="form-control pdf"
											accept=".pdf"> <span
											style="margin-left: 10px; color: red; display: none;">
											Tipo de arquivo inválido </span>
									</div>
								</div>
							</div>
							<div style="display: none;" name="detalhes" id="detalhes">
								<div class="row">
									<div class="col-lg-12 text-center">
										<a onclick="confirmarCancelamento()" type="button"
											data-toggle="tooltip"
											title="Cancelar Justificativa - Já Enviada"
											class="btn btn-danger" target="_blank"><i
											class="glyphicon glyphicon-remove"></i> Cancelar
											Justificativa</a> <a id="detalhesJustificativa"
											name="detalhesJustificativa" type="button"
											data-toggle="tooltip"
											title="Visualizar Detalhes do Solicitante"
											class="btn btn-primary" onclick="visualizarDetalhes()"
											target="_blank"><i class="fa fa-search"></i> Solicitante</a>
										<a name="justificativaArquivo" id="justificativaArquivo"
											type="button" data-toggle="tooltip"
											title="Baixar Justificativa" class="btn btn-info"
											target="_blank"><i class="fa fa-download"></i> Baixar
											Arquivo</a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="row panel-footer">
				<div class="col-lg-4 col-md-6 col-sm-6">
					<a href='/sicap-webapp/manager/remessa' type="button"
						class="btn btn-default btn-block btn-pesquisa"> <i
						class="fa fa-ban"></i> Voltar à Consulta de Importação
					</a>
				</div>
				<div class="col-lg-2 col-md-6 col-sm-6">
					<button id="enviar" class="btn btn-success btn-block btn-pesquisa "
						type="button" data-toggle="modal" data-target="#myModal">
						<i class="fa fa-upload"></i> Salvar Cadastro
					</button>
				</div>

			</div>
			<div class="space-40"></div>
			<div class="space-40"></div>
			<div class="row">
				<div class="col-lg-12">
					<h3>Importante</h3>
					<ul>
						<li>Os arquivos de importação deverão seguir o formato ZIP
							(Método de Compressão DEFLATE), contendo um XML, e quando
							necessário arquivos PDF, correspondentes às informações presentes
							no XML.</li>

						<li>Sendo o caso de Retificação, realizar a solicitação ou
							reenvio, através da funcionalidade [Retificações].</li>
					</ul>
				</div>
			</div>
			<br />
		</form:form>
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Confirmação de Procedimento</h4>
					</div>
					<div class="modal-body">
						<p>Confirmo o envio dos dados para o Tribunal de Contas do
							Estado de Mato Grosso do Sul.</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
						<button id="btnYes" type="button" class="btn btn-primary"
							data-dismiss="modal">Confirmar</button>
					</div>
				</div>
			</div>
		</div>
		<div id="myModalFolha" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Atenção</h4>
					</div>
					<div class="modal-body">
						<p>Foi detectado no sistema, que há uma justificativa
							cadastrada para o não envio dos "Anexos Febraban". Neste caso, é
							necessário aguardar o processo de validação por parte do TCE/MS.</p>
						<br />
						<p class="text-left">
						<ul>
							<li>Data Solicitação: <spam id="dataInclusao"></spam></li>
							<li>Solicitante: <spam id="solicitante"></spam></li>
							<li>Status: <spam id="status"></spam></li>
						</ul>
						</p>
					</div>
					<div class="modal-footer">
						<button type="button" id="goCancelar" name="goCancelar"
							class="btn btn-danger">
							<i class="glyphicon glyphicon-remove"></i>&nbsp;Cancelar
							justificativa
						</button>
						<a id="arquivoJustificativa" name="arquivoJustificativa"
							type="button" class="btn btn-primary"> <i
							class="fa fa-download"></i>&nbsp;Baixar justificativa

						</a> <a type="button" id="closeJustificativa"
							name="closeJustificativa" class="btn btn-default"
							href="/sicap-webapp/manager/importacao/">Fechar</a>
					</div>
				</div>
			</div>
		</div>
		<div id="modalDetalheJustificativa" class="modal fade" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Detalhes Solicitação</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th class="text-center">Data Solicitação</th>
									<th class="text-center">Solicitante</th>

								</tr>
							</thead>
							<tbody>
								<td class="text-center"><spam id="dthInclusao"></spam></td>
								<td><spam id="nomeSolicitante"></spam></td>
							</tbody>
						</table>
						<div class="modal-footer">
							<button id="fecharJustificativa" name="fecharJustificativa"
								type="button" class="btn btn-default" data-dismiss="modal">
								<i class="glyphicon glyphicon-remove"></i>&nbsp;Fechar
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div id="modalCancelamento" class="modal fade" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Confirmação de Procedimento</h4>
					</div>
					<div class="modal-body">
						<p>Se cancelar, os arquivos de remessa e retorno bancário
							passarão a ser obrigatórios novamente. Deseja realmente cancelar
							a justificativa?</p>
					</div>
					<div class="modal-footer">
						<button type="button" id="btnCancelarCaptura"
							name="btnCancelarCaptura" class="btn btn-default"
							data-dismiss="modal">Cancelar</button>
						<button name="cancelarJustificativa" id="cancelarJustificativa"
							type="button" class="btn btn-primary">Confirmar</button>
					</div>
				</div>
			</div>
		</div>
		</div>
		</div>
		<script>
			//
			function confirmarCancelamento() {

				$('#modalCancelamento').modal({
					backdrop : 'static',
					keyboard : false
				});
			}

			
			var podeEnviarZip = true;
			var podeEnviarRemessa = true;
			var podeEnviarRetorno = true;
			var podeEnviarJustificativa = true;
			
			function ValidateSize(file,tipo) {
				 var fileSize = file.files[0].size / 1024; // in kB
				 var nomeArquivo = file.files[0].name;
				 
				 // Verificar tamanho do arquivo
				 if(fileSize > 1000000){
					 toastr.error('O arquivo ' +nomeArquivo+ ' deve possuir tamanho máximo de 1GB.');
					 if(tipo == 'zip'){
						 podeEnviarZip = false;
					 }
					 else if(tipo == 'remessa'){
						 podeEnviarRemessa = false;
					 }
					 else if(tipo == 'retorno'){
						 podeEnviarRetorno = false;
					 }
					 else if(tipo == 'justificativa'){
						 podeEnviarJustificativa = false;
					 }
				 } else {
					 //toastr.success('O arquivo ' +nomeArquivo+ ' foi selecionado com sucesso.');
					 if(tipo == 'zip'){
						 podeEnviarZip = true;
					 }
					 else if(tipo == 'remessa'){
						 podeEnviarRemessa = true;
					 }
					 else if(tipo == 'retorno'){
						 podeEnviarRetorno = true;
					 }
					 else if(tipo == 'justificativa'){
						 podeEnviarJustificativa = true;
					 }
				 }
				
				 if (!podeEnviarZip || !podeEnviarRemessa || !podeEnviarRetorno || !podeEnviarJustificativa){
					$('#enviar').addClass("disabled");
				} else {
					$('#enviar').removeClass("disabled");
				}
						
			}
			
			function visualizarDetalhes() {

				$('#modalDetalheJustificativa').modal({
					backdrop : 'static',
					keyboard : false
				});
			}

			$(document)
					.ready(
							function() {
		
								$('#btnYes')
										.click(
												function() {
													// Carregando....
													toastr
															.info("Aguarde.... solicitação em andamento!");

													$('#carregando').modal({
														keyboard : false,
														show : true
													});

													if ($("#tipoimportacao").val() == 0) {
														$('#carregando').modal('hide');
														$('#tipoimportacao').addClass("error");
														$("#error").show();
													} else {
														if ($("#file").val() == '' && !$("#anexoJustificativa").val()) {
															$('#carregando').modal('hide');
															$('#file').addClass("error");
														}else {
															$('form').submit();
														}
													}

												});
							});

			// Inicializar function que desabilita botão submit
			function botaoEnviarDesabilitado() {
				$('#enviar').addClass("disabled");
				$('#enviar').removeAttr("data-target");
			}

			botaoEnviarDesabilitado();

			function habilitarBotoes(tipo) {

				$('#file').prop("disabled", "");
				$('#febrabamRemessa').prop("disabled", "");
				$('#febrabamRetornoBancario').prop("disabled", "");
				$('#justificarNao').addClass("active");
				$('#justificarSim').removeClass("active");

				document.getElementById("anexoJustificativa").value = "";
				$('#anexoJustificativa').prop("disabled", "disabled");
				document.getElementById("febrabamRemessa").value = "";
				document.getElementById("febrabamRetornoBancario").value = "";

				if (tipo == 1 || tipo == 5) {
					$("#divProrrogacao").hide();
					$("#avisoJurisdicionado").hide();
					$('#buttonNao').removeClass("active");
					$('#buttonSim').removeClass("active");
					$('#buttonNao').addClass("active");
					// Limpar valor do prorrogacaoSim
					$('#prorrogacaoSim').val(0);
				}

				if (tipo != 5) {
					$("#panelFebrabam").hide();
				}

				$('#enviar').removeClass("disabled");
				$('#enviar').attr("data-target", "#myModal");

				$("#enviarXml").show();

			}

			function enviarFolhaDePagamento() {
				habilitarBotoes(5);
				$("#panelFebrabam").show();

				buscarDetalhesUltimaJustificativa();
			}

			function simProrrogacao() {
				$('#prorrogacaoSim').val(1);
				$("#avisoJurisdicionado").show();
			}

			function naoProrrogacao() {
				$("#avisoJurisdicionado").hide();
			}

			function trueConcursoPublico() {
				habilitarBotoes();
				$("#divProrrogacao").show();
			}

			function justificarNaoEnvio(tipo) {
				document.getElementById("file").value = "";
				document.getElementById("febrabamRemessa").value = "";
				document.getElementById("febrabamRetornoBancario").value = "";

				if (tipo == 1) {
					$('#anexoJustificativa').prop("disabled", "");
					$('#file').prop("disabled", "disabled");
					$('#febrabamRemessa').prop("disabled", "disabled");
					$('#febrabamRetornoBancario').prop("disabled", "disabled");
				} else {
					document.getElementById("anexoJustificativa").value = "";
					$('#anexoJustificativa').prop("disabled", "disabled");
					$('#file').prop("disabled", "");
					$('#febrabamRemessa').prop("disabled", "");
					$('#febrabamRetornoBancario').prop("disabled", "");
				}
			}

			// Buscar detalhes da justificativa
			var codSolicitacaoCancelar = 0;
			function buscarDetalhesUltimaJustificativa() {

				// Chamada Ajax
				$
						.ajax(
								{
									url : "/sicap-webapp/manager/importacao/justificativaDeNaoEnvioFebraban",
									type : 'POST'
								})
						.done(
								function(retorno) {
									if (retorno != null) {

										if (retorno.codStatus == 1) {
											// Desabilitar os campos "Arquivo ZIP" / "Remessa Bancária" / "Retorno Bancário"
											$('#anexoJustificativa').prop(
													"disabled", "disabled");
											$('#file').prop("disabled",
													"disabled");
											$('#febrabamRemessa').prop(
													"disabled", "disabled");
											$('#febrabamRetornoBancario').prop(
													"disabled", "disabled");

											// Desabilitar botão que solicita nova justificativa
											$('#justificarSim').addClass(
													"disabled");
											$('#justificarNao').addClass(
													"disabled");

											$('#status').html(retorno.status);
											$('#solicitante').html(
													retorno.solicitante);
											$('#dataInclusao')
													.html(
															dataAtualFormatada(retorno.dataInclusao));

											$('#arquivoJustificativa')
													.attr(
															"href",
															retorno.arquivoJustificativa);

											$('#arquivoJustificativa').attr(
													'target', '_blank');

											codSolicitacaoCancelar = retorno.id;

											$('#myModalFolha').modal({
												backdrop : 'static',
												keyboard : false
											});
										}
									}
									if (retorno.codStatus == 3) {
										$("#detalheJustificativa").show();
										$("#detalhes").show();

										$('#febrabamRemessa').prop("disabled",
												"disabled");
										$('#febrabamRetornoBancario').prop(
												"disabled", "disabled");
										$('#anexoJustificativa').prop(
												"disabled", "disabled");
										$('#justificarSim')
												.addClass("disabled");
										$('#justificarNao')
												.addClass("disabled");

										$('#nomeSolicitante').html(
												retorno.solicitante);
										$('#dthInclusao')
												.html(
														dataAtualFormatada(retorno.dataInclusao));

										$('#justificativaArquivo').attr("href",
												retorno.arquivoJustificativa);

										$('#justificativaArquivo').attr(
												'target', '_blank');

									}
								});
			}

			function dataAtualFormatada(miliseconds) {
				var data = new Date(miliseconds);
				var dia = data.getDate();
				if (dia.toString().length == 1)
					dia = "0" + dia;
				var mes = data.getMonth() + 1;
				if (mes.toString().length == 1)
					mes = "0" + mes;

				var hora = data.getHours();
				if (hora.toString().length == 1)
					hora = "0" + hora;

				var minutos = data.getMinutes();
				if (minutos.toString().length == 1)
					minutos = "0" + minutos;

				var segundos = data.getSeconds();
				if (segundos.toString().length == 1)
					segundos = "0" + segundos;

				var ano = data.getFullYear();
				return dia + "/" + mes + "/" + ano + " " + hora + ":" + minutos
						+ ":" + segundos;
			}

			$('#goCancelar')
					.click(
							function() {
								$('.loader').show();
								$('#goCancelar').attr('disabled', 'disabled');
								$('#closeJustificativa').attr('disabled',
										'disabled');
								$('#goCancelar').attr('disabled', 'disabled');
								$
										.ajax(
												{
													url : '/sicap-webapp/manager/importacao/cancelarJustificativa/'
															+ codSolicitacaoCancelar,
													type : 'POST',
												}).done(function(data) {
											toastr.success(data);
											$('.loader').hide();
											setTimeout(function() {
												location.reload();
											}, 1500);

										}).fail(function(data) {
											setTimeout(function() {
												location.reload();
											}, 1500);
										});
							})

			$('#cancelarJustificativa')
					.click(
							function() {
								$('.loader').show();
								$('#justificativaArquivo').attr('disabled',
										'disabled');
								$('#cancelarJustificativa').attr('disabled',
										'disabled');
								$('#fecharJustificativa').attr('disabled',
										'disabled');
								$
										.ajax(
												{
													url : '/sicap-webapp/manager/importacao/cancelarJustificativa/' + 0,
													type : 'POST',
												}).done(function(data) {
											toastr.success(data);
											$('.loader').hide();
											setTimeout(function() {
												location.reload();
											}, 1500);

										}).fail(function(data) {
											setTimeout(function() {
												location.reload();
											}, 1500);
										});
							})

			$(function() {
				$('[data-toggle="tooltip"]').tooltip()
			})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>