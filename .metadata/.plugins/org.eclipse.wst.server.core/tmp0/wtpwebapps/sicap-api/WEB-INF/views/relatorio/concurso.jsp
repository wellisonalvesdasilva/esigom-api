<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Relatório de Concurso Público</span>
		</h1>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<table class="table table-striped table-responsive" id="tableCargo">
				<thead>
					<tr>
						<th class="text-center"><strong>Cód. Importação</strong></th>
						<th><strong>Descrição</strong></th>
						<th class="text-center"><strong>Número/Ano</strong></th>
						<th class="text-center"><strong>Regime Juridico</strong></th>
						<th class="text-center"><strong>Modalidade</strong></th>
						<th><strong>Situação</strong></th>
						<th><strong>Status</strong></th>
						<th><strong>Ação</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="concurso" items="${concursos}" varStatus="status">
						<tr>
							<td class="text-center"><a class="btn btn-xs btn-info "
								title='Visualizar dados do responsável'
								href="/sicap-webapp/manager/remessa/detalhe_remessa?cod_importacao=${concurso.remessa.importacao.cod}">
									<i class="glyphicon glyphicon-search"></i>
							</a>&nbsp;${concurso.remessa.importacao.cod}</td>
							<td>${concurso.descricao}</td>
							<td class="text-center">${concurso.numero}/${concurso.ano}</td>
							<td>${concurso.regimeJuridico.descricao}</td>
							<td><tce:modalidadeConcurso
									value="${concurso.codModalidaConcurso}" /></td>
							<td><c:choose>
									<c:when test="${concurso.remessa.importacao.situacao == 2}">Processando</c:when>
									<c:when test="${concurso.remessa.importacao.situacao == 7}">Migrado</c:when>
									<c:when test="${concurso.remessa.importacao.situacao == 3}">Protocolado</c:when>
									<c:when test="${concurso.remessa.importacao.situacao == 8}">Aguardando autuação</c:when>
									<c:when test="${concurso.remessa.importacao.situacao == 9}">Recebido</c:when>
									<c:otherwise>-</c:otherwise>
								</c:choose></td>
							<td><c:choose>
									<c:when test="${concurso.remessa.situacao == 15}">Cancelado</c:when>
									<c:when test="${concurso.remessa.situacao != 15}">Ativo</c:when>
								</c:choose></td>
							<td><a class='btn btn-primary' data-toggle="tooltip"
								title="Visualizar Mais Detalhes"
								href='/sicap-webapp/manager/relatorio/detalhe_concurso?cod_concurso=${concurso.cod}'><i
									class='fa fa-search-plus'></i></a> <c:choose>
									<c:when test="${concurso.remessa.situacao == 15}">
										<button data-toggle="tooltip"
											onclick="obterArquivo('${concurso.cod}')"
											title="Download Justificativa de Cancelamento"
											class="btn btn-warning" type="button" onclick="#">
											<i class="glyphicon glyphicon-download-alt"></i>
										</button>
									</c:when>
								</c:choose></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<script>
		
		
		function obterArquivo(cod) {
			$('.loader').show();
			$
					.ajax({
						url : 'downloadJustificativaDeRecusaConcurso/' + cod,
						type : 'POST',
						data : {
							cod : cod
						}
					})
					
					// Preparar dados com o retorno da função
					.done(function(response) {
								$('.loader').hide();
								//window.top = response.justificativa;
								window.open(response.justificativa, '_blank');
				});
		}
		
				var table = $('#tableCargo')
					.DataTable(
							{
								responsive : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,
								columnDefs : [ {
									"width" : "13%",
									"targets" : 0
								}, {
									"width" : "23%",
									"targets" : 1
								}, {
									"width" : "10%",
									"targets" : 2
								}, {
									"width" : "13%",
									"targets" : 3
								}, {
									"width" : "10%",
									"targets" : 4
								}, {
									"width" : "10%",
									"targets" : 5
								}, {
									"width" : "10%",
									"targets" : 6
									
								}, {
									"width" : "11%",
									"targets" : 6
								} ],
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
				$(function() {
					$('[data-toggle="tooltip"]').tooltip()
				})
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>