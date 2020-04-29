<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Atualização de Manual/Tabela</span>
		</h1>
		<div class="space-20"></div>
		<div class="row">
			<div id="error" class="alert alert-danger" style="display: none;">
				<span id="errorMessage"></span>
			</div>
		</div>
		<br />
		<div class="row resultado">
			<h4>Registros Encontrados</h4>
		</div>

		<div class="row" style="margin: 0px;">
			<table class="table table-striped table-responsive" id="table">
				<thead>
					<tr>
						<th class="text-center"><strong>ID</strong></th>
						<th class="text-center"><strong>Tipo Publicação</strong></th>
						<th class="text-center"><strong>Data</strong></th>
						<th class="text-center"><strong>Versão</strong></th>
						<th class="text-center"><strong>Título</strong></th>
						<th class="text-center"><strong>Autor</strong></th>
						<th class="text-center"><strong>Arquivo</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="it" items="${manuais}" varStatus="status">
						<tr>
							<td class="text-center">${it.getId()}</td>
							<td class="text-center"><div
									class="label label-<c:choose><c:when test="${it.getTipo_publicacao().getTipo() == 'MANUAL'}">primary</c:when><c:otherwise>warning</c:otherwise></c:choose>"
									style="display: block; width: 100%;">
									<span>${it.getTipo_publicacao().getTipo()}</span>
								</div></td>
							<td class="text-center">${it.getDataPublicacaoFormatada()}</td>
							<td class="text-center">${it.getNumero()}</td>
							<td>${it.getTitulo()}</td>
							<td class="text-center">${it.getAutor()}</td>
							<td class="text-center">
								<button data-toggle="tooltip" class="btn btn-info"
									onclick="abrirModal('${it.getUrlArquivoPublicacao()}', '${it.getTexto()}')"
									type="button" data-original-title="Visualizar Documentos">
									<i class="glyphicon glyphicon-search"></i>
								</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<div id="modalDetalhe" class="modal fade" role="dialog">
			<div class="modal-dialog modal-md">
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Detalhes Publicação</h4>
					</div>
					<div class="modal-body">
						<div class="row">
							<div class="col-lg-12">
								<div class="form-horizontal" role="form">
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>Detalhes:</strong>
										</label>
										<div class="col-lg-8">
											<div class="form-control-static ng-binding" id="texto">Nenhuma
												informação foi cadastrada no Portal do TCE.</div>
										</div>
									</div>
									<div class="form-group">
										<label class="col-sm-3 control-label"><strong>Arquivo:</strong>
										</label>
										<div class="col-lg-8">
											<a class="btn btn-primary" id="linkDownload"
												name="linkDownload" title="Download" target="_blank"><i
												class="glyphicon glyphicon-download-alt"></i> Download </a>
										</div>
									</div>
								</div>
							</div>
						</div>
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
		<script>
			function abrirModal(link, resumo) {

				$('#texto').html("");

				$('#modalDetalhe').modal({
					backdrop : 'static',
					keyboard : false
				});

				$('#texto').html(
						"Nenhuma informação foi cadastrada no Portal do TCE.");

				$("#linkDownload").removeAttr("href");
				$("#linkDownload").attr("href", link);

				if (resumo) {
					$('#texto').html(resumo);
				}
			}

			function obterArquivo(url) {
				if (url) {
					window.open(url);
				} else {
					toastr.warning("Manual não localizado. Consulte a TI.");
				}
			}

			var table = $('#table')
					.DataTable(
							{
								responsive : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,

								columnDefs : [ {
									"width" : "12%",
									"targets" : 0
								}, {
									"width" : "12%",
									"targets" : 1
								}, {
									"width" : "14%",
									"targets" : 2
								}, {
									"width" : "15%",
									"targets" : 3
								}, {
									"width" : "20%",
									"targets" : 4
								}, {
									"width" : "15%",
									"targets" : 5
								}, {
									"width" : "16%",
									"targets" : 6
								}, ],

								order : [ [ 1, "asc" ], [ 3, "desc" ] ],
								language : {
									"sEmptyTable" : "Nenhum registro encontrado",
									"sInfo" : "Mostrando de _START_ até _END_ de _TOTAL_ registros",
									"sInfoEmpty" : "Mostrando 0 até 0 de 0 registros",
									"sInfoFiltered" : "(Filtrados de _MAX_ registros)",
									"sInfoPostFix" : "",
									"sInfoThousands" : ".",
									"sLengthMenu" : "_MENU_ resultados por página",
									"sLoadingRecords" : "Carregando...",
									"sProcessing" : "Processando...",
									"sZeroRecords" : "Nenhum registro encontrado",
									"sSearch" : "Pesquisar por CPF: ",
									"oPaginate" : {
										"sNext" : "Próximo",
										"sPrevious" : "Anterior",
										"sFirst" : "Primeiro",
										"sLast" : "Último"
									},
									"oAria" : {
										"sSortAscending" : ": Ordenar colunas de forma ascendente",
										"sSortDescending" : ": Ordenar colunas de forma descendente"
									}
								}
							});
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>