<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<style>
form.submitted input:invalid {
	border: 1px solid red;
}
</style>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Retificar Legislação</span>
		</h1>
		<div class="space-20"></div>
		<div class="row">
			<div id="error" class="alert alert-danger" style="display: none;">
				<span id="errorMessage"></span>
			</div>
		</div>
		<form:form method="POST" modelAttribute="dadosAtuaisObjAviso"
			enctype="multipart/form-data"
			onsubmit="return validarFormulario(this)">
			<div class="row">
				<div class="col-lg-6 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Título:</label>
						<form:input maxlength="60" path="titulo"
							placeholder='Informe o Título'
							value='${dadosAtuaisObjAviso.titulo}' required='required'
							class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Início Vigência Publicação:</label>
					<div class="input-group">
						<form:input type='text' path='dataInicioVigencia'
							value='${(fn:escapeXml(param.dadosAtuaisObjAviso.dataInicioVigencia))}'
							required='required' class="form-control dataMask"
							placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Término Vigência Publicação:</label>
					<div class="input-group">
						<form:input type='text'
							value='${(fn:escapeXml(param.dadosAtuaisObjAviso.dataTerminoVigencia))}'
							path='dataTerminoVigencia' required='required'
							class="form-control dataMask" placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="comment">Detalhes:</label>
						<form:textarea class="form-control" rows="5" path="texto" />
					</div>
					<p class="help-block">
						<i class="glyphicon glyphicon-info-sign"></i> &nbsp;Limite de 1000
						caracteres
					</p>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-12 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="comment">Imagem:</label>
						<c:if
							test="${(dadosAtuaisObjAviso.img != null) || (dadosAtuaisObjAviso.img == '')}">
							<a href="${caminhoImg}" target="_blank" class="btn btn-info"
								title="Fazer Download"> <i
								class="glyphicon glyphicon-search"></i>
							</a>&nbsp;
											<a class="btn btn-danger"
								onclick="excluirImagem(${dadosAtuaisObjAviso.cod})"
								title="Remover Imagem"> <i
								class="glyphicon glyphicon glyphicon-trash"></i>
							</a>
						</c:if>
						<form:input type='file' path='arquivoImg' class="btn btn-default"
							value="Escolher Arquivo" />
						<p class="help-block">
							<i class="glyphicon glyphicon-info-sign"></i> &nbsp;Será aceito
							somente arquivo no formato: .jpg, .jpeg, .bmp, .gif e .png.
						</p>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="comment">* Ativo:</label> <br />
						<div class="btn-group btn-group-toggle" data-toggle="buttons">
							<label
								class="btn btn-primary btn-sm <c:if test="${dadosAtuaisObjAviso.ativo == true}">active</c:if>">
								<input type="radio" name="ativo" value="1" autocomplete="off" />
								Sim
							</label> <label
								class="btn btn-primary btn-sm <c:if test="${dadosAtuaisObjAviso.ativo == false}">active</c:if>">
								<input type="radio" name="ativo" value="0" autocomplete="off" />
								Não
							</label>
						</div>
					</div>
				</div>
				<c:if test="${dadosAtuaisObjAviso.avisoGeral == true}">
					<div class="col-lg-2 col-md-3 col-sm-4">
						<div class="form-group">
							<label for="comment">Público:</label> <br />
							<div class="btn-group btn-group-toggle" data-toggle="buttons">
								<label onclick="changeAvisoGeral(1)"
									class="btn btn-primary btn-sm <c:if test="${dadosAtuaisObjAviso.avisoGeral == true}">active</c:if>">
									<input type='radio' name="avisoGeral" value="1" /> Interno
								</label> <label onclick="changeAvisoGeral(0)"
									class="btn btn-primary btn-sm <c:if test="${dadosAtuaisObjAviso.avisoGeral == false}">active</c:if>">
									<input type="radio" name="avisoGeral" value="0" /> Externo
								</label>
							</div>
						</div>
					</div>
				</c:if>
				<div id="divUgs" class="col-lg-8 col-md-3 col-sm-4"
					style="display: none">
					<label>Selecione as unidade(s) gestora(s):</label> <input
						id="txtUg" onkeyup="filtrarUgs()" type="text"
						placeholder="Informe a unidade gestora"
						class="form-control input-sm">
					<div
						style="min-height: 1px; max-height: 250px; border: 1px solid #ddd; overflow-y: scroll;">
						<c:forEach var="item" items='${ugs}'>
							<div class="col-lg-12 ugsToShow" name="${item.nomeUg}">
								<input type="checkbox" name="listUgs" value="${item.codUg}" />
								<span class="cursor-hand ng-binding">${item.nomeUg}</span>
							</div>
						</c:forEach>
					</div>
					<input type="checkbox" onclick="selecionarTodasUgs()"
						id="selectAll" /><span>Selecionar todos</span>
				</div>

				<%--
				<div id="divUgs" class="col-lg-8 col-md-3 col-sm-4"
					<c:if test="${dadosAtuaisObjAviso.avisoGeral == true}">style="display: none"</c:if>>
					<label>Selecione as unidade(s) gestora(s):</label> <input
						id="txtUg" onkeyup="filtrarUgs()" type="text"
						placeholder="Informe a unidade gestora"
						class="form-control input-sm">
					<div
						style="min-height: 1px; max-height: 250px; border: 1px solid #ddd; overflow-y: scroll;">
						<c:forEach var="item" items='${ugs}'>
							<div class="col-lg-12 ugsToShow" name="${item.nomeUg}">
								<input type="checkbox"
									<c:forEach var="itemdb" items='${listUgsRetorno}' >
										<c:if test="${item.codUg == itemdb.cod_ug}">checked</c:if>
									</c:forEach>
									name="listUgs" id="listUgs" value="${item.codUg}" /> <span
									class="cursor-hand ng-binding">${item.nomeUg}</span>
							</div>
						</c:forEach>
					</div>
					<input type="checkbox" onclick="selecionarTodasUgs()"
						id="selectAll" /><span>Selecionar todos</span>
				</div>
				 --%>
			</div>
			<div class="row align-right" style="margin: 0px;">
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
		<div id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<h4 class="modal-title">Atenção</h4>
					</div>
					<div class="modal-body">
						<p>Deseja realmente apagar esta imagem?</p>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Cancelar</button>
						<button name="btnYes" id="btnYes" type="button"
							class="btn btn-primary" data-dismiss="modal">Sim</button>
					</div>
				</div>
			</div>
		</div>
		<script>
		
		function limparAviso() {
			$("input[name='titulo']").val('');
			$("input[name='dataInicioVigencia']").val('');
			$("input[name='dataTerminoVigencia']").val('');
			$("textarea[name='texto']").val('');
			$("#arquivoImg").val("");
			$("#selectAll").prop('checked', false);
			desselecionarUgs();
		}

		
		
		function validarFormulario(oForm) {

			$('#loader-wrapper').attr('class', 'loader');

			var podeSubmeter = true;
			$('#errorMessage').html('');

			if (!campoObrigatorio())
				podeSubmeter = false;

			if (!ValidarExtensoes(oForm))
				podeSubmeter = false;

			if (!podeSubmeter)
				$("#error").show();

			$('form').addClass('submitted');

			if (!podeSubmeter)
				$('#loader-wrapper').removeAttr('class', 'loader');

			return podeSubmeter;
		}

		function campoObrigatorio() {
			if ($('#dataInicioVigencia').val() > $('#dataTerminoVigencia')
					.val()) {
				$('#errorMessage')
						.append(
										'Atenção:'
										+ "&nbsp;"
										+ 'A Data Ínicio não deve ser maior que a Data Término.'
										+ "&nbsp;");
				return false;
			}
			return true;
		}

		var _validFileExtensions = [ ".jpg", ".jpeg", ".bmp", ".gif",
				".png" ];

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
											'O formato da imagem selecionada é inválido.');
							return false;

						}
					}
				}
			}
			return true;
		}


		
		function limparAviso() {
			$("input[name='titulo']").val('');
			$("input[name='dataInicioVigencia']").val('');
			$("input[name='dataTerminoVigencia']").val('');
			$("textarea[name='texto']").val('');
			$("#arquivoImg").val("");
			$("#selectAll").prop('checked', false);
			desselecionarUgs();
		}

		function desselecionarUgs() {
			var lista = document.querySelectorAll('input[name=listUgs]');
			var empty = [].filter
					.call(
							lista,
							function(el) {
								el.checked = document
										.getElementById('selectAll').unchecked;
							});
		}
		
		
		var codAviso = 0;
			function excluirImagem(cod) {
				$('#myModal').modal();
				codAviso = cod;
			}

			// Invalidar importação
			$('#btnYes').click(function() {
				$.ajax({
					url : "/sicap-webadm/manager/quadro_avisos/deletarImagem",
					data : {
						"codAviso" : codAviso
					},
					method : "POST"

				}).done(function() {
					setTimeout(function() {
						location.reload();
					}, 1500);
					toastr.success("Imagem apagada com sucesso!");
				});
			})

			function selecionarTodasUgs() {
				var lista = document.querySelectorAll('input[name=listUgs]');
				var empty = [].filter.call(lista, function(el) {
					el.checked = document.getElementById('selectAll').checked;
				});
			}

			function filtrarUgs() {
				var lista = document.getElementsByClassName('ugsToShow');
				var textoParaPesquisar = document.getElementById('txtUg').value;

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

			function yesAvisoGeral() {

				if ($('#avisoGeral').val() == 0)
					$("#divUgs").show();
			}

			var sucessoMessage = "${message}";
			if (sucessoMessage != "") {
				toastr.success("${message}");
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

			function changeAvisoGeral(valor) {
				if (valor == 0) {
					$('#divUgs').show();
				} else {
					$('#divUgs').hide();
				}

			}

		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>