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
		<script>
			var app = angular.module('app', []);

			app.filter('range', function() {
				return function(input, total) {
					total = parseInt(total);
					for (var i = 0; i < total; i++)
						input.push(i);
					return input;
				};
			});
			var controllerId = "consultarEnvioConcursoPublicoController";
			angular.module("app").controller(
					controllerId,
					[ "$scope", "envioConcursoService",
							consultarEnvioConcursoPublicoController ]);

			// Controller ///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			function consultarEnvioConcursoPublicoController($scope,
					envioConcursoService) {
				var vm = $scope;

				//Configurações iniciais da tabela
				function configurarFiltrosGrid() {
					vm.concurso = {
						itensPorPagina : 5,
						paginaAtual : 0,
						asc : true
					};
				}
				vm.proximaPagina = function() {
					vm.concurso.paginaAtual++;
					carregarGrid();
				}

				vm.paginaAnterior = function() {
					vm.concurso.paginaAtual--;
					carregarGrid();
				}

				vm.irParaPagina = function(pagina) {
					vm.concurso.paginaAtual = pagina;
					carregarGrid();
				}

				vm.ordenar = function(ordenar) {
					vm.concurso.ordenar = ordenar;
					vm.concurso.asc = !vm.concurso.asc;
					console.log(vm.concurso);
					carregarGrid();
				}

				vm.excluir = function(cod) {
					envioConcursoService.excluir(cod).then(function(result) {
						if (result.status == 200) {
							toastr.success('Registro excluído com sucesso!');
							carregarGrid();

						} else
							toastr.warning('sucesso!', 'sucesso');
					});
				}

				vm.pesquisar = function() {
					vm.concurso.paginaAtual = 0;
					carregarGrid();
				}

				function carregarGrid() {
					envioConcursoService.consultar(vm.concurso).then(
							function(result) {
								console.log(result);
								vm.QtdDeRegistros = result.data.quantidade;
								vm.concurso.paginas = Math
										.ceil(result.data.quantidade
												/ vm.concurso.itensPorPagina);
								vm.listaDeConcurso = result.data.lista
							});
				}

				function activate() {

					configurarFiltrosGrid();
					carregarGrid();
				}

				activate();
			};
		</script>
		<div ng-controller="consultarEnvioConcursoPublicoController">
			<h1 class="one">
				<span>Consultar Envio de Concurso</span>
			</h1>
			<div class="space-20"></div>
			<div class="row">
				<div id="error" class="alert alert-danger" style="display: none;">
					<span id="errorMessage"></span>
				</div>
			</div>
			<form>
				<div class="row">
					<div class="col-lg-2 col-md-3 col-sm-4">
						<div class="form-group">
							<label>Código</label> <input placeholder='Cód. Solicitação'
								type='number' min="0" ng-model="concurso.cod" max="999999"
								class="form-control" />
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-lg-2 col-md-2 col-sm-4">
						<button ng-click="pesquisar()"
							class="btn btn-primary btn-block btn-pesquisa">
							<i class="fa fa-search"></i> Pesquisar
						</button>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-4">
						<a href='/sicap-webapp/manager/envioConcurso' id="reset"
							type="button" class="btn btn-default btn-block btn-pesquisa">
							<i class="glyphicon glyphicon-refresh"></i> Limpar
						</a>
					</div>
					<div class="col-lg-2 col-md-2 col-sm-4">
						<a data-toggle="tooltip"
							title="Cadastrar Novo Envio de Concurso Público"
							class='btn btn-success btn-block btn-pesquisa'
							href='/sicap-webapp/manager/envioConcurso/cadastrar'><i
							class='glyphicon glyphicon-plus'></i> Novo Envio</a>
					</div>
				</div>
			</form>
			<div class="divisor"></div>
			<br />
			<div class="row resultado">
				<h4>Resultados da pesquisa</h4>
			</div>
			<div class="row" style="margin: 0px;">
				<table class="table table-striped table-condensed table-hover">
					<thead>
						<tr>
							<th style="cursor: pointer;" class="text-center"
								ng-click="ordenar('cod')"><strong>Código</strong></th>
							<th class="text-center"><strong>Data Criação</strong></th>
							<th class="text-center"><strong>Regime</strong></th>
							<th class="text-center"><strong>Descrição</strong></th>
							<th class="text-center"><strong>Veículo Publicação</strong></th>
							<th class="text-center"><strong>Prazo Validade</strong></th>
							<th class="text-center"><strong>Ações</strong></th>
						</tr>
					</thead>

					<tbody>
						<tr ng-repeat="it in listaDeConcurso">
							<td class="text-center">{{it.cod}}</td>
							<td class="text-center">{{it.dataInclusao | date:'dd-MM-yyyy
								HH:mm:ss'}}</td>
							<td class="text-center">{{it.nomeTipoRegime}}</td>
							<td class="text-center">{{it.descricao}}</td>
							<td class="text-center">{{it.nomeVeiculoPublicacao}}</td>
							<td class="text-center">{{it.prazoValidade}}</td>
							<td class="text-center"><a id='editar' data-toggle="tooltip"
								href='#' class='btn btn-primary' title="Editar"> <i
									class='glyphicon glyphicon-pencil'></i></a>
								<button id="excluir" data-toggle="tooltip" title="Excluir"
									class="btn btn-danger" type="button" ng-click="excluir(it.cod)">
									<i class="glyphicon glyphicon-trash"></i>
								</button></td>
					</tbody>
					<tfoot>
						<td colspan="10">{{QtdDeRegistros}}
							<nav aria-label="...">
								<div class="pagination pull-right">
									<li ng-class="{disabled: concurso.paginaAtual == 0}"
										class="page-item"><a class="page-link"
										ng-click="paginaAnterior()" tabindex="-1">Anterior</a></li>
									<li ng-class="{active: $index == concurso.paginaAtual}"
										ng-repeat="n in [] | range:concurso.paginas" class="page-item"><a
										class="page-link" ng-click="irParaPagina($index)">{{$index+1}}</a></li>
									<li
										ng-class="{disabled: concurso.paginaAtual == concurso.paginas-1}"
										class="page-item"><a class="page-link"
										ng-click="proximaPagina()">Próximo</a></li>
									</ul>
								</div>
							</nav>
						</td>
					</tfoot>
				</table>
			</div>
		</div>
	</tiles:putAttribute>
</tiles:insertDefinition>
