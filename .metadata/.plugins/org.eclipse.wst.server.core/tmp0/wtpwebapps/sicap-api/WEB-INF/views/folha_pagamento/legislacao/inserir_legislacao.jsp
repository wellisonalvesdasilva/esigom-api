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
			<span>Cadastrar Legislação</span>
		</h1>
		<form:form method="POST" modelAttribute="objNewLegislacao">
			<div class="space-20"></div>
			<h3>
				<span>Informações</span>
			</h3>
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Tipo</label> <select name="codigoTipoLegislacao"
							id="codigoTipoLegislacao" class="form-control">
							<c:forEach var="legislacao" items='${tiposDeLegislacoes}'>
								<option value='${legislacao.key}'>${legislacao.value}</option>
							</c:forEach>
						</select>
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Número:</label>
						<form:input maxlength="60" path="numeroLei"
							placeholder='Informe o Número' class='form-control' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Ano:</label>
						<form:input maxlength="60" placeholder='Ano' path="ano"
							class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Código de Controle:</label>
						<form:input maxlength="60" path="codigoControle"
							placeholder='Informe o Código' class='form-control' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<label>Data de Assinatura:</label>
					<div class="input-group">
						<form:input type='text' path='dataAssinatura'
							class="form-control dataMask" placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-5 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Assunto:</label>
						<form:input path="assunto" maxlength="60"
							placeholder='Informe o Assunto' class='form-control' />
					</div>
				</div>
				<div class="col-lg-7 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="comment">Ementa:</label>
						<form:textarea class="form-control" rows="1" path="ementa"
							placeholder="Informe a Ementa" />
					</div>
				</div>

			</div>
			<div class="space-20"></div>
			<div class="space-20"></div>
			<h3>
				<span>Dados da Publicação</span>
			</h3>
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>CNPJ Veículo de Publicação:</label>
						<form:input maxlength="60" path="cnpjVeiculoPublicacao"
							placeholder='Informe o CNPJ' class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Título da Publicação:</label>
						<form:input path="tituloPublicacao" maxlength="60"
							placeholder='Informe o Título da Publicação' class='form-control' />
					</div>
				</div>
				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Número:</label>
						<form:input path="numeroPublicacao" maxlength="60"
							placeholder='Informe o Número' class='form-control' />
					</div>
				</div>

				<div class="col-lg-2 col-md-3 col-sm-4">
					<label>Data Publicação:</label>
					<div class="input-group">
						<form:input type='text' path='dataPublicacao'
							class="form-control dataMask" placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>

				<div class="col-lg-2 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Página(s):</label>
						<form:input path="paginas" maxlength="60"
							placeholder='Informe as Páginas' class='form-control' />
					</div>
				</div>
			</div>
			<div class="space-20"></div>
			<div class="space-20"></div>
			<h3>
				<span>Vigência e Produção de Efeitos</span>
			</h3>
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Data de Vigência:</label>
					<div class="input-group">
						<form:input type='text' path='dataVigenciaEfeito'
							class="form-control dataMask" placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<label>Data de Produção de Efeitos:</label>
					<div class="input-group">
						<form:input type='text' path='dataProducaoEfeito'
							class="form-control dataMask" placeholder="DD/MM/AAAA" />
						<span class="input-group-addon"><i class="fa fa-calendar"></i></span>
					</div>
				</div>
			</div>
			<div class="space-20"></div>
			<div class="space-20"></div>
			<h3>
				<span>Situação da Norma</span>
			</h3>
			<div class="row">
				<div class="col-lg-12 col-md-3 col-sm-4">
					<div class="form-group">
						<label for="comment">Detalhes:</label>
						<form:textarea class="form-control" rows="2" path="situacaoNorma"
							placeholder="Informe a Situação da Norma" />
					</div>
				</div>
			</div>
			<div class="row align-left" style="margin: 0px;">
				<div class="btn-group" role="group">
					<button onclick="javascript: history.go(-1)" type="button"
						class="btn btn-default btn-block btn-pesquisa">
						<i class="glyphicon glyphicon-backward"></i> Voltar
					</button>
				</div>
				<div class="btn-group" role="group">
					<button type="submit" id="cadastrar"
						class="btn btn-success btn-block btn-pesquisa">
						<i class="glyphicon glyphicon-floppy-disk"></i> Salvar
					</button>
				</div>
				<div class="btn-group" role="group">
					<button id="reset" type="button"
						class="btn btn-default btn-block btn-pesquisa">
						<i class="fa fa-times"></i> Limpar
					</button>
				</div>
			</div>
		</form:form>
		<script>
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
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>