<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<style>
svg {
	background-color: none;
}
</style>
		<h1 class="one">
			<span>Buscar Admitido</span>
		</h1>
		<div class="space-20"></div>
		<div class="panel panel-primary">
			<div class="panel-heading">Detalhes</div>
			<div class="panel-body">
				<c:if test="${not empty error}">
					<div class="alert alert-danger">${error}</div>
				</c:if>
				<form
					action="/sicap-webapp/manager/relatorio/detalhe_admissao_geral"
					method="get">
					<div class="row">
						<div class="col-lg-3 col-md-3 col-sm-4">
							<div class="form-group">
								<label>CPF</label> <input id='cpf' name="cpf"
									placeholder="Digite o CPF" class="form-control inputs" />
							</div>
						</div>
						<div class="col-lg-5 col-md-3 col-sm-4">
							<div class="form-group">
								<label>Nome</label> <input id='nomeCompleto' name="nomeCompleto"
									placeholder="Informe o Nome Completo"
									class="form-control inputs" />
							</div>
						</div>
					</div>
					<div class="row panel-footer">
						<div class="col-lg-2 col-md-2 col-sm-4">
							<button type="submit" id="pesquisar" name="pesquisar"
								class="btn btn-primary btn-block btn-pesquisa">
								<i class="fa fa-search"></i> Pesquisar
							</button>
						</div>
						<div class="col-lg-2 col-md-2 col-sm-4">
							<a href="pessoa" type="button"
								class="btn btn-default btn-block btn-pesquisa"> <i
								class="glyphicon glyphicon-refresh"></i> Limpar
							</a>
						</div>
					</div>
				</form>
				<div id="modalCpfEncontrado" class="modal fade" role="dialog">
					<div class="modal-dialog modal-md">
						<div class="modal-content">
							<div class="modal-header">
								<h4 class="modal-title">Mais de um CPF foi encontrado!</h4>
							</div>

							<div class="modal-body">
								<table class="table table-bordered table-striped">
									<thead>
										<tr>
											<th class="text-center">Número CPF</th>
											<th class="text-center">Ação</th>
										</tr>
									</thead>
									<tbody id="lista">
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
			</div>
		</div>
		<script>
			$(document).ready(function() {
				$('#pesquisar').prop("disabled", "disabled");
				$('#cpf').mask('000.000.000-00');
				$("#reset").click(function() {
					$(":text").each(function() {
						$(this).val("");
					});
					$("select").each(function() {
						$(this).val("0");
					});
				});
			});
			$('.inputs').blur(verificarPreenchimento);

			function verificarPreenchimento() {
				var nomeCompleto = $('#nomeCompleto').val();

				if ($('#cpf').val() && !$('#nome').val()) {
					$("#pesquisar").removeAttr("disabled", "");
				} else {
					$('#pesquisar').prop("disabled", "disabled");
				}
				if (nomeCompleto && !$('#cpf').val()) {
					$('#nomeCompleto').prop("disabled", "disabled");
					$('#cpf').prop("disabled", "disabled");
					$
							.ajax(
									{
										url : 'buscarPessoaNome/'
												+ nomeCompleto,
										type : 'GET',
										contentType : "application/json; charset=UTF-8",
									})
							.done(
									function(response) {
										if (response.length > 1) {
											$('#lista').html('');
											response
													.forEach(function(valor) {
														$('#lista')
																.append(
																		'<tr>'
																				+ '<td style="text-transform: uppercase" class="ng-binding text-center">'
																				+ valor
																				+ '</td>'
																				+ '<td class="text-center"><a type="button" href="/sicap-webadm/relatorios/relatorio/detalhe_admissao_geral?cpf='
																				+ valor
																				+ '&nomeCompleto=&pesquisar=" class="btn btn-success btn-sm"> Selecionar</a>'
																				+ '</td>'
																				+ '<tr>');
													});

											$('#modalCpfEncontrado').modal({
												backdrop : 'static',
												keyboard : false
											});
										}
										if (response.length == 1) {
											$("#nomeCompleto").removeAttr(
													"disabled", "");
											$("#cpf")
													.removeAttr("disabled", "");
											$("#pesquisar").removeAttr(
													"disabled", "");
										} else {
											toastr
													.warning("Nenhuma pessoa foi encontrada!");
											$("#nomeCompleto").removeAttr(
													"disabled", "");
											$("#nomeCompleto").val("");
											$("#cpf")
													.removeAttr("disabled", "");
										}
									});
				}
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>
