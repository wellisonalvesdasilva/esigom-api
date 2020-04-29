<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<!-- <style>
form.submitted input:invalid {
	border: 1px solid red;
}

:focus:required:invalid {
	border: 1px solid red;
}
</style> -->

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Solicitar Nova Retificação</span>
		</h1>
		<div class="space-20"></div>
		<div class="panel panel-primary">
			<div class="panel-heading">Detalhes da Solicitação</div>
			<div class="panel-body">
				<div class="col-md-12">
					<div class="row">
						<div id="error" class="alert alert-danger" style="display: none;">
							<span id="errorMessage"></span>
						</div>
					</div>
					<form:form id="newDto" method="POST" modelAttribute="newDto"
						enctype="multipart/form-data"
						onsubmit="return validarFormulario(this)">
						<div class="row" style="margin: 0px;">
							<div class="row">
								<div class="col-lg-6 col-md-3 col-sm-4">
									<div class="form-group">
										<label> Tipo Envio:</label> <br />
										<div class="btn-group btn-group-toggle" data-toggle="buttons">
											<label disabled="disabled" class="btn btn-primary btn-sm">
												<input type="radio" required name="tipoImportacao" value="" />
												Plano de Cargos
											</label> <label disabled="disabled" class="btn btn-primary btn-sm">
												<input value="" type="radio" required name="tipoImportacao" />
												Concurso Público
											</label> <label onclick="verMsgNaoVacancia()"
												class="btn btn-primary btn-sm"> <input type='radio'
												required name="tipoImportacao" value="1" /> Admissão
											</label> <label disabled="disabled" class="btn btn-primary btn-sm">
												<input type="radio" required name="tipoImportacao" value="3" />
												Folha de Pagamento
											</label> <label onclick="verMsgVacancia()"
												class="btn btn-primary btn-sm"> <input type="radio"
												required name="tipoImportacao" value="2" /> Vacância
											</label>
										</div>
									</div>
									<p class="help-block">
										<i class="glyphicon glyphicon-info-sign"></i> &nbsp;Essa
										funcionalidade encontra-se indisponível para as remessas de
										concursos e admissões que geram processos, sendo àquelas
										decorrentes de servidores aprovados em concurso público,
										contratação temporária e convocação de professores.
									</p>
									<br>
								</div>
								<div class="col-lg-3 col-md-3 col-sm-4">
									<div class="form-group">
										<label> Ação Desejada:</label> <select name="acao" id="acao"
											class="form-control" required>
											<option value="">Selecione</option>
											<option value="1">Reenviar</option>
											<option value="2">Descartar</option>
										</select>
									</div>
								</div>
								<div class="col-lg-3 col-md-3 col-sm-4">
									<div class="form-group">
										<label> Motivo:</label> <select name="tipo" id="tipo"
											class="form-control" required>
											<option value="">Selecione</option>
											<option value="1">Duplicidade</option>
											<option value="2">Erro no XML</option>
										</select>
									</div>
								</div>
								<div class="col-lg-12 col-md-3 col-sm-4">
									<div class="form-group">
										<label> Detalhes:</label>
										<form:textarea class="form-control" rows="5"
											required="required" id="detalhesSolicitacao"
											title="Campo obrigatório!"
											placeholder="Informe os Detalhes (Até 1000 caracteres)"
											maxlength="1000" path="detalhesSolicitacao" />
									</div>
								</div>
								<div class="col-lg-4 col-md-3 col-sm-4">
									<div class="form-group">
										<label for="comment"> Justificativa:</label>
										<form:input required="required" type='file'
											path='arquivoJustificativa' class="btn btn-default"
											value="Escolher Arquivo" />
										<p class="help-block">
											<i class="glyphicon glyphicon-info-sign"></i> &nbsp;Será
											aceito somente arquivo no formato: .pdf.
										</p>
									</div>
								</div>

								<div class="col-lg-2 col-md-6 col-sm-6">
									<div class="form-group">
										<label>Código Importação</label>
										<div class="input-group">
											<input id="codImportacao" required name="codImportacao"
												class="form-control" placeholder="Digite o Código"
												type="text" value=""> <a class="input-group-addon"
												id="goSearch" type="button"><i class="fa fa-refresh"></i></a>
										</div>
									</div>
								</div>
								<div id="divRemessas" class="col-lg-6 col-md-3 col-sm-4"
									style="display: none">
									<label>Selecione a(s) remessa(s) para
										retificar/descartar:</label> <input id="txtRemessa"
										onkeyup="filtrarRemessas()" type="text"
										placeholder="Informe o código da remessa"
										class="form-control input-sm">
									<div
										style="min-height: 1px; max-height: 250px; border: 1px solid #ddd; overflow-y: scroll;">
										<div id="optionDropdownJs"></div>
									</div>
									<input type="checkbox" onclick="selecionarTodasRemessas()"
										id="selectAll" /><span>Selecionar todas</span>
								</div>
							</div>
						</div>
						<div class='row align-left panel-footer' style='margin: 0px;'>
							<div class="btn-group" role="group">
								<a href='/sicap-webapp/manager/retificacaoRemessa' type="button"
									class="btn btn-default btn-block btn-pesquisa"> <i
									class="glyphicon glyphicon-backward"></i> Consultar
									Solicitações de Retificação
								</a>
							</div>
							<div class="btn-group" role="group">
								<a href='/sicap-webapp/manager/retificacaoRemessa/cadastrar'
									type="button" class="btn btn-default btn-block btn-pesquisa">
									<i class="glyphicon glyphicon-refresh"></i> Limpar Campos
								</a>
							</div>
							<div class="btn-group" role="group">
								<button type="submit" id="cadastrar"
									class="btn btn-success btn-block btn-pesquisa">
									<i class="glyphicon glyphicon-ok"></i> Enviar Solicitação
								</button>
							</div>
						</div>
					</form:form>
				</div>
			</div>
		</div>
		<form:form id="avisoNaoVacancia" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Aviso</h4>
					</div>
					<div class="modal-body">
						<p>Após a validação por parte do TCE-MS, caso aprovada,
							ocasionará na alteração do status da(s) remessa(s) para
							Cancelada. Portanto, sendo o caso de reenvio, este ficará sob
							responsabilidade do jurisdicionado.</p>
					</div>
					<div class="modal-footer">
						<a type="button" class="btn btn-warning"
							href='/sicap-webapp/manager/index'>Cancelar</a>
						<button data-dismiss="modal" type="button" class="btn btn-success">Ciente</button>
					</div>
				</div>
			</div>
		</form:form>
		<form:form id="avisoVacancia" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Aviso</h4>
					</div>
					<div class="modal-body">
						<p>Após a validação por parte do TCE-MS, caso aprovada,
							ocasionará na alteração do status da(s) remessa(s) para
							Cancelada. Portanto, sendo o caso de reenvio, este ficará sob
							responsabilidade do jurisdicionado.</p>
					</div>
					<div class="modal-footer">
						<a type="button" class="btn btn-warning"
							href='/sicap-webapp/manager/index'>Cancelar</a>
						<button data-dismiss="modal" type="button" class="btn btn-success">Ciente</button>
					</div>
				</div>
			</div>
		</form:form>

		<script>
			var txt = $("#detalhesSolicitacao");
			var func = function() {
				if (txt.val().length == 1) {
					txt.val(txt.val().replace(/\s/g, ''));
				}
			}

			txt.keydown(func).blur(func);

			function verMsgVacancia() {
				$('#avisoVacancia').modal({
					backdrop : 'static',
					keyboard : false
				});

			}

			function verMsgNaoVacancia() {
				$('#avisoNaoVacancia').modal({
					backdrop : 'static',
					keyboard : false
				});
			}

			// Toastr
			var errorMessage = "${erro}";
			if (errorMessage != "") {
				toastr.error("${erro}");
			}

			// Desabilitar botão ao carregar a página
			function desabilitarBotaoSalvarCarregamento() {
				$('#cadastrar').prop("disabled", "disabled");
			};

			// Executar função no carregamento da página
			desabilitarBotaoSalvarCarregamento();

			// Blur
			function pesquisarImportacao() {
				$('#optionDropdownJs').html('');
				$("#cadastrar").removeAttr("disabled", "");
				$("#selectAll").removeAttr("disabled", "");
				$("#selectAll").prop('checked', false);
				var codImportacao = document.getElementById("codImportacao").value;
				$('#codImportacaoRetificar').val(codImportacao);

				// limpar campos no inicio da chamada do ajax ou da validação de campo obrigatório
				$("#errorModal").hide();
				$('#errorMensagem').html('');

				if (codImportacao)
					$
							.ajax(
									{
										url : '/sicap-webapp/manager/retificacaoRemessa/buscarImportacaoPeloCod/'
												+ codImportacao,
										type : 'POST',
									})
							.done(
									function(data) {
										$('#divRemessas').show();
										// Verificar se existe valores no retorno do data
										if (data.length > 0) {
											$("#cadastrar").removeAttr(
													"disabled", "");
											data
													.forEach(function(element,
															index, array) {

														if (element) {
															$(
																	'#optionDropdownJs')
																	.append(
																			'<div class="col-lg-12 remessasToShow" name='+element.codRemessa+'>'
																					+ '<input type="checkbox" id="listRemessas" value='+element.codRemessa+' name="listRemessas"/><span class="cursor-hand ng-binding">'
																					+ element.codRemessa
																					+ ' '
																					+ '-'
																					+ ' '
																					+ element.descricao)
														}
													});

										} else {
											$('#optionDropdownJs')
													.append(
															'<div class="col-lg-12 remessasToShow">'
																	+ 'Nenhum registro encontrado.')

											$("#selectAll").attr("disabled",
													"disabled");

											$('#cadastrar').prop("disabled",
													"disabled");

										}
									}).fail(function() {
								//TODO 

							});
			}

			// Ao clicar fora do campo codImportacao, executar function pesquisarImportacao()
			$('#codImportacao').blur(pesquisarImportacao);
			$('#goSearch').click(pesquisarImportacao);

			// Funções DIV remessas
			function selecionarTodasRemessas() {
				var lista = document
						.querySelectorAll('input[name=listRemessas]');
				var empty = [].filter.call(lista, function(el) {
					el.checked = document.getElementById('selectAll').checked;
				});
			}

			function filtrarRemessas() {
				var lista = document.getElementsByClassName('remessasToShow');
				var textoParaPesquisar = document.getElementById('txtRemessa').value;

				Array.prototype.forEach.call(lista, function(el) {

					if (el.getAttribute("name").toUpperCase().includes(
							textoParaPesquisar.toUpperCase())) {
						el.style.visibility = 'visible';
						el.style.position = 'relative';
					} else {
						el.style.visibility = 'hidden';
						el.style.position = 'absolute';
					}
				});
			}

			function validarFormulario(oForm) {
				$('#loader-wrapper').attr('class', 'loader');
				$('#errorMessage').html('');
				$('form').addClass('submitted');

				if (!ValidarExtensoes(oForm)) {
					$("#error").show();
					$('#loader-wrapper').removeAttr('class', 'loader');
					return false;
				}

				document.getElementById("cadastrar").disabled = true;
				return true;

			}

			var _validFileExtensions = [ ".pdf", ".doc", ".docx" ];

			function ValidarExtensoes(oForm) {
				//Verificação das extensões
				var arrInputs = oForm.getElementsByTagName("input");
				for (var i = 0; i < arrInputs.length; i++) {
					var oInput = arrInputs[i];
					if (oInput.type == "file") {
						var sFileName = oInput.value;
						if (sFileName.length > 0) {
							var blnValid = false;
							for (var j = 0; j < _validFileExtensions.length; j++) {
								var sCurExtension = _validFileExtensions[j];
								if (sFileName
										.substr(
												sFileName.length
														- sCurExtension.length,
												sCurExtension.length)
										.toLowerCase() == sCurExtension
										.toLowerCase()) {
									blnValid = true;
									break;
								}
							}

							if (!blnValid) {
								$('#errorMessage')
										.append(
												'O formato do arquivo selecionado é inválido.');
								return false;

							}
						}
					}
				}

				return true;
			}

			$(document).ready(function() {

			});
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>