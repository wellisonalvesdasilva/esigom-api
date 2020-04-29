<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<style>
.btn-file {
	position: relative;
	overflow: hidden;
}

.btn-file input[type=file] {
	position: absolute;
	top: 0;
	right: 0;
	min-width: 100%;
	height: 32px;
	font-size: 100px;
	text-align: right;
	filter: alpha(opacity = 0);
	opacity: 0;
	outline: none;
	background: white;
	cursor: inherit;
	display: block;
}

#textoResposta {
	width: 100%;
}
</style>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Intimação</span>
		</h1>
		<div class="space-20"></div>

		<form:form id="form" method="post"
			action="${pageContext.request.contextPath}/manager/intimacao/salvar"
			commandName="intimacao" enctype="multipart/form-data">
			<form:hidden path="cod" />
			<div class="row" style="margin: 0px;!important">
				<div class="panel panel-primary">
					<div class="panel-heading">Dados da Intimação</div>
					<div class="panel-body">
						<div class="row" style="margin: 0px;!important">
							<div class="col-md-3 col-xs-3">
								<div class="form-group">
									<label for="email">Situação Importação</label> <label
										class="form-control background"><tce:situacaoImportacaoDescricao
											value="${importacao.situacao}" /></label>
								</div>
							</div>
							<div class="col-md-9 col-xs-9">
								<div class="form-group">
									<label for="email">Usuário</label> <label
										class="form-control background">${importacao.usuarioNome}</label>
								</div>
							</div>
						</div>
						
						<c:if test="${fn:length(importacao.documentos) > 0}">
						<div class="col-md-12 col-xs-12">
							<table class="table  table-responsive" id="tableRemessa">
								<thead style="background-color: transparent;">
									<tr>
										<td colspan="4"><h3>Lista de Arquivos</h3></td>
									</tr>
									<tr>
										<th><strong>Nome do arquivo</strong></th>
										<th><strong>Hash arquivo</strong></th>
										<th><strong>Tipo do Arquivo</strong></th>
										<th><strong>Ação</strong></th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="documento" items="${importacao.documentos}"
										varStatus="status">
										<tr>
											<td>${documento.arquivo}</td>
											<td>${documento.arquivoHash}</td>
											<td>${documento.extensao}</td>
											<td><a class='btn btn-primary download'
												href='/sicap-webapp/manager/donwload?caminho=${documento.storage}/${documento.arquivo}'>
													<i class="fa fa-download"></i> Baixar arquivo
											</a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
						</c:if>
						
						<div class="col-md-12 col-xs-12">
							<label class="control-label">Resposta</label><br />
							<form:textarea cssClass="background form-control"
								path="textoResposta" id="textoResposta" disabled="disabled"
								cols="100" rows="12" readonly="true"></form:textarea>
						</div>
					</div>
				</div>
			</div>
			<div class="space-40"></div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2">
					<button onclick="history.go(-1); return false;" type="button" class="btn btn-default btn-block btn-pesquisa"><i class="fa fa-ban"></i> Cancelar</button>
				</div>
			</div>

			<br />

		</form:form>

	</tiles:putAttribute>
</tiles:insertDefinition>