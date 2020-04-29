
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>

<tiles:insertDefinition name="autenticacao">
	<tiles:putAttribute name="body">

		<div class="col-lg-12 col-xs-12 col-sm-12 col-md-12"
			style="text-align: center;">
			<div class="botoesIndex col-lg-6 col-xs-6 col-sm-6 col-md-6 centered">
				<img data-toggle="modal" onclick="abrirFormularioAutenticacao()"
					src="${pageContext.request.contextPath}/resources/img/sicap_usuario_senha.png"
					alt="Generic placeholder image"
					style="cursor: pointer; cursor: hand; padding-left: 100px;">
			</div>
			<div class="botoesIndex col-lg-6 col-xs-6 col-sm-6 col-md-6 centered">
				<a target="_BLANCK"
					href="http://cjur.tce.ms.gov.br/Login/Login?ReturnUrl=%2f#/selecaoTipoCadastro">
					<img
					src="${pageContext.request.contextPath}/resources/img/sicap_nao_sou_cadastrado.png"
					style="cursor: pointer; cursor: hand;"
					alt="Generic placeholder image">
				</a>
			</div>
		</div>
		<!-- Modal -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
			aria-labelledby="myModalLabel">
			<div class="modal-dialog" role="document">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" onclick="fecharModal()" class="close"
							data-dismiss="modal" aria-label="Close">
							<span aria-hidden="true">&times;</span>
						</button>
						<h4 class="modal-title" id="myModalLabel">Formulário de
							Autenticação</h4>
					</div>
					<form:form class="form-signin" method="post"  onsubmit="return desabilitarBotao()" commandName="userForm"
						action="../j_spring_security_check" acceptCharset="UTF-8">
						<div class="modal-body">

							<div class="row">
								<div
									class="form-group col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1">
									<label for="j_username">CPF</label> <input type="text"
										name="j_username" id="j_username" class="form-control"
										placeholder="CPF cadastrado no CJUR" required autofocus>
								</div>
							</div>
							<div class="row">
								<div
									class="form-group col-lg-10 col-lg-offset-1 col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1">
									<label for="j_password">Senha</label> <input type="password"
										name="j_password" id="j_password" class="form-control"
										placeholder="Digitar Senha CJUR" required onchange="">
								</div>
							</div>
							<div class="row">
								<div
									class="form-group col-lg-10 col-lg-offset-1  col-md-10 col-md-offset-1 col-sm-10 col-sm-offset-1 col-xs-10 col-xs-offset-1">
									<div id="carregando" class="col-lg-1">
										<span
											class="glyphicon glyphicon-refresh glyphicon-refresh-animate"></span>
									</div>
									<div class="col-lg-9" style="margin: 0px; padding: 0px;">
										<label for="j_unidadeGestora"> Unidade Gestora </label>
									</div>
									<br /> <select name="j_unidadeGestora" id="j_unidadeGestora"
										class="form-control">
										<option>Selecione uma Unidade Gestora</option>
									</select>
								</div>
							</div>
						</div>
						<div class="modal-footer">
							<button type="button" onclick="fecharModal()"
								class="btn btn-default" data-dismiss="modal">Fechar</button>

							<button id="btnAutenticar" name="btnAutenticar" type="submit"
								class="btn btn-primary">Autenticar</button>

							<br /> <br /> <br /> <label id="errosenha" class=".btn-danger"
								style="display: none; padding-right: 30%; color: red;">Verifique
								os dados informados!</label>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
<script>
	function desabilitarBotao() {
		$('#btnAutenticar').prop("disabled", "disabled");
	}

	function fecharModal() {
		$('#myModal').modal('hide');
	}

	function abrirFormularioAutenticacao() {

		// Apagar preenchimentos da modal
		$('#j_username').val('');
		$('#j_password').val('');
		$("#j_unidadeGestora")
				.html(
						'<option value="0">Informe o CPF e a senha do usuário que possua vínculo!</option>');
		$('#errosenha').hide();
		$('#btnAutenticar').prop("disabled", "disabled");

		$('#myModal').modal({
			backdrop : 'static',
			keyboard : false
		});
	}

	$(document)
			.ready(
					function() {
						$('#j_unidadeGestora').val(
								'Selecione uma Unidade Gestora');
						$('#j_username').mask('000.000.000-00');
						$("#j_username")
								.focusout(
										function() {
											$("#j_unidadeGestora")
													.html(
															'<option value="0">Unidade Gestora não encontrada</option>');
										});

						$("#j_password")
								.focusout(
										function() {
											var cpf = $("#j_username").val();
											var senha = md5($("#j_password")
													.val());
											$('#carregando').show();
											$("#j_unidadeGestora")
													.html(
															"<option value='0'>Carregando Unidade Gestora..</option>");
											$
													.getJSON(
															"/sicap-api/auth/lista_ug",
															{
																"cpf" : cpf,
																"senha" : senha
															},
															function(j) {
																$('#mensagem')
																		.hide();
																var options = '';

																if (j.length == 0) {
																	$(
																			'#errosenha')
																			.show();

																	$(
																			'#btnAutenticar')
																			.prop(
																					"disabled",
																					"disabled");

																	$(
																			'#mensagem')
																			.show();
																	options += '<option value="0">Unidade Gestora não encontrada</option>';
																} else {
																	for (var i = 0; i < j.length; i++) {
																		options += '<option value="' + j[i].cod + '">'
																				+ j[i].nome
																				+ '</option>';

																		$(
																				'#btnAutenticar')
																				.prop(
																						"disabled",
																						"");
																	}
																	$(
																			'#errosenha')
																			.hide();
																}

																$(
																		"#j_unidadeGestora")
																		.html(
																				options);

															})
													.complete(
															function() {
																$('#carregando')
																		.hide();
															});
										});
					});
</script>
