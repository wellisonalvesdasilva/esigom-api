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
			<span>Cadastrar Verba</span>
		</h1>
		<form:form method="POST" modelAttribute="objNewVerba">
			<div class="space-20"></div>
			<h3>
				<span>Dados da Verba</span>
			</h3>

			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>CBO Cargo:</label>
						<form:input maxlength="60" path="codigoCbo"
							placeholder='Informe o CBO' class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Dígito Verificador:</label>
						<form:input maxlength="60" path="dvCbo"
							placeholder='Informe o Dígito Verificador' class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Valor da Verba:</label>
						<form:input maxlength="60" path="valor"
							placeholder='Informe o Valor da Verba' class='form-control' />
					</div>
				</div>
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Tipo da Verba:</label> <select name='codSituacaoIntimacao'
							id='selectUg' class="form-control">
							<option value="">Selecione um valor</option>
							<option value="1">Renumeração Inicial</option>
						</select>
					</div>
				</div>
			</div>
			<h3>
				<span>Fundamentação Legal</span>
			</h3>
			<div class="row">
				<div class="col-lg-3 col-md-3 col-sm-4">
					<div class="form-group">
						<label>Tipo da Verba:</label> <select name='codSituacaoIntimacao'
							id='selectUg' class="form-control">
							<option value="">Selecione um valor</option>
							<option value="1">Legislação nº 151/2015 - Lei Orgânica</option>
						</select>
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