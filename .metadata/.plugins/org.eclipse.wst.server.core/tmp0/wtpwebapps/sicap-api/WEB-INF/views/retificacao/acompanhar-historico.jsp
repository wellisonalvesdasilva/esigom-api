<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Visualizar Histórico </span>
		</h1>
		<div class="row" class="text-right">
			<div class="col-md-10"></div>
			<div class="col-md-2">
				<a href='/sicap-webapp/manager/retificacaoRemessa' type="button"
					class="btn btn-default btn-block btn-pesquisa"> <i
					class="glyphicon glyphicon-backward"></i> Voltar
				</a>
			</div>
		</div>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;!important">
			<div class="panel panel-primary">
				<div class="panel-heading">Registros Encontrados</div>
				<div class="panel-body">
					<div class="col-md-12">
						<table class="table  table-responsive" id="tableRemessa">
							<thead style="background-color: transparent;">
								<tr>
									<th class="text-center"><strong>Código da
											Solicitação</strong></th>
									<th class="text-center"><strong>Data da Ação</strong></th>
									<th class="text-center"><strong>Ação Realizada</strong></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="it" items="${historico}" varStatus="status">
									<tr>
										<td class="text-center">${it.solicitacaoRetificacaoHist.cod}</td>
										<td class="text-center"><fmt:formatDate
												pattern="dd/MM/yyyy HH:mm:ss" value="${it.dataAcao}" />
										<td>${it.acaoRealizada}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<script>
			
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>