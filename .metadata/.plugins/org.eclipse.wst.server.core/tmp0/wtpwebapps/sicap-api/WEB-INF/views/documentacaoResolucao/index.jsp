<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Documentos Resolução 88</span>
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
			<table class="table table-striped table-responsive"
				id="tableSolicitacaoDeRetificacao">
				<thead>
					<tr>
						<th class="text-center"><strong>Código</strong></th>
						<th class="text-center"><strong>Classe</strong></th>
						<th class="text-center"><strong>Subclasse</strong></th>
						<th class="text-center"><strong>Tipo Processo</strong></th>
						<th class="text-center"><strong>Modalidade</strong></th>
						<th class="text-center"><strong>Ações</strong></th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="it" items="${resultado}" varStatus="status">
						<tr>
							<td class="text-center">${it.getCodComposicao()}</td>
							<td>${it.getClasse()}</td>
							<td>${it.getSubClasse()}</td>
							<td>${it.getTipoProcesso()}</td>
							<td>${it.getModalidade()}</td>
							<td class="text-center">
								<button data-toggle="tooltip" class="btn btn-primary"
									type="button" data-original-title="Visualizar Documentos"
									onclick="visualizarDocumentos(${it.getDocumentosJson()})">
									<i class="glyphicon glyphicon-th-list"></i>
								</button> <c:if
									test="${it.getCodComposicao() == 142 || it.getCodComposicao() == 143}">
									<button data-toggle="tooltip" class="btn btn-warning"
										data-original-title="Visualizar Documentos - Quanto á Prorrogação/Termo Aditivo"
										type="button" onclick="abrirModal(${it.getCodComposicao()})">
										<i class="glyphicon glyphicon-list-alt"></i>
									</button>
								</c:if>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<form:form id="myModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Visualizar Documentos</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th class="text-center">Código</th>
									<th class="text-center">Nome</th>
								</tr>
							</thead>
							<tbody id="tableRegistros"></tbody>
						</table>
					</div>
					<div class="modal-footer">
						<button type="button" name="noCancelar" id="noCancelar"
							class="btn btn-default" data-dismiss="modal">Fechar</button>
					</div>
				</div>
			</div>
		</form:form>
		<form:form id="myModalProrrogacao" class="modal fade" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content-->
				<div class="modal-content">
					<div class="modal-header">
						<h4 class="modal-title">Documentos Quanto á Prorrogação/Termo
							Aditivo</h4>
					</div>
					<div class="modal-body">
						<table class="table table-bordered table-striped">
							<thead>
								<tr>
									<th class="text-center">Código</th>
									<th class="text-center">Nome</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="text-center">476</td>
									<td>TERMO ADITIVO</td>
								</tr>
								<tr>
									<td class="text-center">73</td>
									<td>COMPROVAÇÃO DE PUBLICAÇÃO DE EXTRATO</td>
								</tr>

								<tr>
									<td class="text-center">229</td>
									<td>JUSTIFICATIVA QUANTO À PRORROGAÇÃO</td>
								</tr>
								<tr>
									<td class="text-center">1059</td>
									<td>DECLARAÇÃO DE NÚMERO DO PROCESSO AUTUADO NO TCE</td>
								</tr>
								<tr id="isContrato" style="display: none;">
									<td class="text-center">477</td>
									<td>CONTRATO (Opcional se enviado o documento nº 1059)</td>
								</tr>
								<tr>
									<td class="text-center">452</td>
									<td>OUTROS DOCUMENTOS (Opcional)</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="modal-footer">
						<!-- 	<div class="row">
							<div class="col-md-12">
								<i class="glyphicon glyphicon-warning-sign"></i> Em relação aos
								documentos 477 e 1059, neste caso em específico, é necessário
								envio de ao menos um desses documentos.
							</div>
						</div> -->
						<button type="button" name="noCancelar" id="noCancelar"
							class="btn btn-default" data-dismiss="modal">Fechar</button>
					</div>
				</div>
			</div>
		</form:form>

		<script>
		function abrirModal(codComposicao){
			
			// Exigir exigência do "Contrato"
			$("#isContrato").hide();
			if(codComposicao == 142){
				$("#isContrato").show();
			}
			
				$('#myModalProrrogacao').modal({
				backdrop : 'static',
				keyboard : false
			});
		}
	
		var table = $('#tableSolicitacaoDeRetificacao')
					.DataTable(
							{
								responsive : true,
								bFilter : false,
								bLengthChange : false,
								bAutoWidth : false,
								iDisplayLength : 10,
								columnDefs : [ {
									"width" : "16%",
									"targets" : 0
								}, {
									"width" : "16%",
									"targets" : 1

								}, {
									"width" : "16%",
									"targets" : 2

								}, {
									"width" : "16%",
									"targets" : 3

								}, {
									"width" : "16%",
									"targets" : 4

								}, {
									"width" : "20%",
									"targets" : 5

								}, ],
								order : [ [ 5, "asc" ] ],
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
			});

			// Visualizar Documentos
			
			function visualizarDocumentos(param) {
					document.getElementById('tableRegistros').innerHTML = '';
					
					param.forEach(function(documento){
				
						console.log(documento);
						if(documento.TipoDocumento.Cod != 481 && documento.TipoDocumento.Cod != 482){
					var linha = document.createElement('tr');
				
					// Código
					var coluna1 = document.createElement('td');
					coluna1.className = 'text-center col-sm-3';
					coluna1.innerHTML = documento.TipoDocumento.Cod;
					linha.appendChild(coluna1);
					
					// Documento
					var coluna2 = document.createElement('td');
					coluna2.innerHTML = documento.TipoDocumento.Nome;
					linha.appendChild(coluna2);
					
					// Ativo
			/* 		var coluna3 = document.createElement('td');
					coluna3.className = 'text-center col-sm-2';
					coluna3.innerHTML = isObrigatorio(documento.Obrigatorio);
					linha.appendChild(coluna3);  */
					
					document.getElementById('tableRegistros').appendChild(linha);
					}
			
					// Abrir Modal
					$('#myModal').modal({
						backdrop : 'static',
						keyboard : false
					});
				});
			}
			
			
			function isObrigatorio(param){
				if (param == true) {
					return "Sim";
				} 
				return "Não";
			}
			
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>