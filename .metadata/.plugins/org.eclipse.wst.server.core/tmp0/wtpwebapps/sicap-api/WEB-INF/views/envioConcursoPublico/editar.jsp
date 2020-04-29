<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>


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
		<div ng-controller="editarEnvioConcursoPublicoController">

			<h1 class="one">
				<span>Editar Envio de Concurso</span>
			</h1>
			<div class="space-20"></div>

			<div class="row">
				<div id="error" class="alert alert-danger" style="display: none;">
					<span id="errorMessage"></span>
				</div>
			</div>
			<form id="objNovoEnvio" method="POST">
				<div class="row">
					<div class="col-lg-3 col-md-3 col-sm-4">
						<div class="form-group">
							<label> Regime Jurídico:</label> <select value=""
								ng-model="concurso.tipoRegime" class="form-control"
								required='required'>
								<option value="">Selecione</option>
								<option value="1">Celetista</option>
								<option value="2">Estatutário</option>
							</select>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-4">
						<div class="form-group">
							<label> Veículo de Publicação do Edital:</label> <select value=""
								ng-model="concurso.veiculoPublicacao" class="form-control"
								required='required'>
								<option value="">Selecione</option>
								<option value="1">Diário Oficial</option>
								<option value="2">Jornal Local</option>
								<option value="3">Fixação em Mural</option>
							</select>
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-4">
						<div class="form-group">
							<label>Prazo de Validade (Meses):</label> <input value=""
								maxlength="30" ng-model="concurso.prazoValidade"
								placeholder='Informe o Prazo de Validade' required='required'
								class='form-control' />
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-4">
						<div class="form-group">
							<label>Número do Edital:</label> <input value="" maxlength="30"
								ng-model="concurso.numeroEdital"
								placeholder='Informe o Número do Edital' required='required'
								class='form-control' />
						</div>
					</div>
					<div class="col-lg-2 col-md-3 col-sm-4">
						<div class="form-group">
							<label>Ano do Edital:</label> <input value="" maxlength="30"
								ng-model="concurso.anoEdital" placeholder='Informe o Ano'
								required='required' class='form-control' />
						</div>
					</div>
					<div class="col-lg-4 col-md-3 col-sm-4">
						<div class="form-group">
							<label>Descrição do Edital:</label> <input value=""
								maxlength="30" ng-model="concurso.descricao"
								placeholder='Informe a Descrição do Edital' required='required'
								class='form-control' />
						</div>
					</div>
					<div class="col-lg-3 col-md-3 col-sm-4">
						<label>Data de Publicação do Edital:</label>
						<div class="input-group">
							<input type='text' autocomplete="off"
								ng-model='concurso.dataPublicacaoEditalView' value=""
								class="form-control dataMask" required='required'
								placeholder="DD/MM/AAAA" /> <span class="input-group-addon"><i
								class="fa fa-calendar"></i></span>
						</div>
					</div>

				</div>
				<div class="row align-right" style="margin: 0px;">
					<div class="btn-group" role="group">
						<button onclick="javascript: history.go(-1)" type="button"
							class="btn btn-warning btn-block btn-pesquisa">
							<i class="glyphicon glyphicon-ban-circle"></i> Cancelar
						</button>
					</div>
					<div class="btn-group" role="group">
						<button ng-click="editar()" id="editar"
							class="btn btn-success btn-block btn-pesquisa">
							<i class="glyphicon glyphicon-floppy-disk"></i> Salvar
						</button>
					</div>
				</div>
			</form>
			<script>
				$('.dataMask').mask('00/00/0000');
				$(".dataMask").datepicker(
						{
							dateFormat : 'dd/mm/yy',
							dayNames : [ 'Domingo', 'Segunda', 'Terça',
									'Quarta', 'Quinta', 'Sexta', 'Sábado' ],
							dayNamesMin : [ 'D', 'S', 'T', 'Q', 'Q', 'S', 'S',
									'D' ],
							dayNamesShort : [ 'Dom', 'Seg', 'Ter', 'Qua',
									'Qui', 'Sex', 'Sáb', 'Dom' ],
							monthNames : [ 'Janeiro', 'Fevereiro', 'Março',
									'Abril', 'Maio', 'Junho', 'Julho',
									'Agosto', 'Setembro', 'Outubro',
									'Novembro', 'Dezembro' ],
							monthNamesShort : [ 'Jan', 'Fev', 'Mar', 'Abr',
									'Mai', 'Jun', 'Jul', 'Ago', 'Set', 'Out',
									'Nov', 'Dez' ],
							nextText : 'Próximo',
							prevText : 'Anterior',
							onClose : function(dateText, inst) {
								if (!validaDat(dateText)) {
									$('#btnSubmit')
											.prop("disabled", "disabled");
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
					} else if (((ardt[1] == 4) || (ardt[1] == 6)
							|| (ardt[1] == 9) || (ardt[1] == 11))
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

				var app = angular.module('app', [ 'ngAnimate', 'toastr' ]);
				var controllerId = "editarEnvioConcursoPublicoController";

				angular.module("app").controller(
						controllerId,
						[ "$scope", 'toastr', "envioConcursoService",
								editarEnvioConcursoPublicoController ]);

				function editarEnvioConcursoPublicoController($scope, toastr,
						envioConcursoService) {
					var vm = $scope;

					// editar
					vm.editar = function() {
						vm.concurso.dataPublicacaoEdital = new Date(
								vm.concurso.dataPublicacaoEditalView);

						// Chamada Javascript
						envioConcursoService
								.editar(vm.concurso)
								.then(
										function(result) {

											if (result.status == 200) {
												document
														.getElementById("editar").disabled = true;
												toastr
														.success('Registro cadastrado com sucesso!');
												window.location.href = "/sicap-webapp/manager/envioConcurso/consultar";
											} else
												toastr.warning('sucesso!',
														'sucesso');
										});
					};
				};
			</script>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>