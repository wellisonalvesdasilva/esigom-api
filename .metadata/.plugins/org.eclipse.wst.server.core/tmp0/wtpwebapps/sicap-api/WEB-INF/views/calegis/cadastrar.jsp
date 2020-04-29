<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
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
</style>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Cadastrar Legislação</span>
		</h1>
		<div class="space-20"></div>
		<div class="row">
			<div id="error" class="alert alert-danger" style="display: none;">
				<span id="errorMessage"></span>
			</div>
		</div>
		<form:form id="objNewCalegis" method="POST"
			modelAttribute="objNewCalegis" enctype="multipart/form-data"
			onsubmit="return validarFormulario(this)">
			<div class="row">
				<h3>Informações</h3>
				<div class="col-lg-6 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Tipo</label> <select name="codTipoAto" id="codTipoAto"
							class="form-control">
							<option value="">Selecione</option>
							<option value="1">Constituição Estadual</option>
							<option value="2">Constituição Federal</option>
							<option value="3">Decreto</option>
							<option value="4">Decreto-lei</option>
							<option value="5">Emenda à Constituição Estadual</option>
							<option value="6">Emenda à Constituição Federal</option>
							<option value="7">Emenda à Lei Orgânica Municipal</option>
							<option value="8">Lei complementar</option>
							<option value="9">Lei ordinária</option>
							<option value="10">Lei Orgânica Municipal</option>
							<option value="11">Portaria normativa - tipo 16</option>
							<option value="12">Resolulção normativa - tipo 15</option>
						</select>
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Número:</label>
						<form:input maxlength="60" path="numeroAto"
							placeholder='Informe o Número' required='required'
							class='form-control' />
					</div>
				</div>
				<div class="col-lg-1 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Ano:</label>
						<form:input maxlength="60" path="anoAto" placeholder='Ano'
							required='required' class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Código de Controle:</label>
						<form:input maxlength="60" path="codControle"
							placeholder='Informe o Código de Controle' required='required'
							class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>* Data Legislação:</label>
					<div class="input-group">
						<form:input type='text' path='dataPublicacao'
							class="form-control dataMask" required='required'
							placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-9 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Assunto:</label>
						<form:input maxlength="60" path="assunto"
							placeholder='Informe o Assunto' required='required'
							class='form-control' />
					</div>
				</div>
				<div class="col-lg-12 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="comment">Ementa:</label>
						<form:textarea class="form-control" rows="5"
							placeholder="Informe a Ementa" maxlength="1000" path="ementa" />
					</div>
					<p class="help-block">
						<i class="glyphicon glyphicon-info-sign"></i> &nbsp;Limite de 1000
						caracteres
					</p>
				</div>
			</div>
			<div class="row">
				<h3>Dados Publicação</h3>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Número Publicação:</label>
						<form:input maxlength="60" path="numeroPublicacao"
							placeholder='Informe o Número' required='required'
							class='form-control' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<label>* Data Publicação:</label>
					<div class="input-group">
						<form:input type='text' path='dataPublicacao'
							class="form-control dataMask" required='required'
							placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Página Publicação:</label>
						<form:input maxlength="60" path="paginaPublicacao"
							placeholder='Informe a Página' required='required'
							class='form-control' />
					</div>
				</div>
				<div class="col-lg-6 col-md-3 col-sm-4">
					<div class="form-group">
						<label>* Endereço Eletrônico:</label>
						<form:input maxlength="60" path="enderecoEletronico"
							placeholder='Informe o Endereço Eletrônico' required='required'
							class='form-control' />
					</div>
				</div>
			</div>
			<div class="row">
				<h2>Anexo</h2>
				<div class="col-lg-12 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="comment">Lei:</label>
						<form:input type='file' path='arquivoPdf' class="btn btn-default"
							value="Escolher Arquivo" />
						<p class="help-block">
							<i class="glyphicon glyphicon-info-sign"></i> &nbsp;Será aceito
							somente arquivo no formato: .pdf.
						</p>
					</div>
				</div>
			</div>
			<div class="row align-left" style="margin: 0px;">
				<div class="btn-group" role="group">
					<button onclick="javascript: history.go(-1)" type="button"
						class="btn btn-warning btn-block btn-pesquisa">
						<i class="glyphicon glyphicon-ban-circle"></i> Cancelar
					</button>
				</div>
				<div class="btn-group" role="group">
					<button type="submit" id="cadastrar"
						class="btn btn-success btn-block btn-pesquisa">
						<i class="glyphicon glyphicon-floppy-disk"></i> Salvar
					</button>
				</div>
				<div class="btn-group" role="group">
					<button id="reset" onclick="limparAviso()" type="button"
						class="btn btn-default btn-block btn-pesquisa">
						<i class="fa fa-times"></i> Limpar
					</button>
				</div>
			</div>
		</form:form>

		<script>
			var errorMessage = "${erro}";
			if (errorMessage != "") {
				toastr.error("${erro}");
			}

			var sucessoMessage = "${message}";
			if (sucessoMessage != "") {
				toastr.success("${message}");
			}

			function validarFormulario(oForm) {

				$('#loader-wrapper').attr('class', 'loader');
				var podeSubmeter = true;

				$('#errorMessage').html('');

				if (!ValidarExtensoes(oForm))
					podeSubmeter = false;

				if (!podeSubmeter)
					$("#error").show();

				$('form').addClass('submitted');

				if (!podeSubmeter)
					$('#loader-wrapper').removeAttr('class', 'loader');

				return podeSubmeter;
			}

			var _validFileExtensions = [ ".pdf" ];

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

			// DatePicker
			$('.dataMask').mask('00/00/0000');

			$(".dataMask")
					.datepicker(
							{
								dateFormat : 'dd/mm/yy',
								dayNames : [ 'Domingo', 'Segunda', 'Terça',
										'Quarta', 'Quinta', 'Sexta', 'Sábado' ],
								dayNamesMin : [ 'D', 'S', 'T', 'Q', 'Q', 'S',
										'S', 'D' ],
								dayNamesShort : [ 'Dom', 'Seg', 'Ter', 'Qua',
										'Qui', 'Sex', 'Sáb', 'Dom' ],
								monthNames : [ 'Janeiro', 'Fevereiro', 'Março',
										'Abril', 'Maio', 'Junho', 'Julho',
										'Agosto', 'Setembro', 'Outubro',
										'Novembro', 'Dezembro' ],
								monthNamesShort : [ 'Jan', 'Fev', 'Mar', 'Abr',
										'Mai', 'Jun', 'Jul', 'Ago', 'Set',
										'Out', 'Nov', 'Dez' ],
								nextText : 'Próximo',
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
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>