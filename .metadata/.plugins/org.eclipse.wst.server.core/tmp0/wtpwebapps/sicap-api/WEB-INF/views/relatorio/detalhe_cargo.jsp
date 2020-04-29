<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<style>
svg {
	background-color: none;
}
</style>
		<h1 class="one">
			<span>Detalhe Cargo</span>
		</h1>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Dados Cargo</div>
				<div class="panel-body">
					<div class="col-md-4">
						<div class="form-group">
							<label for="email">Data</label> <label class="form-control">
								<fmt:formatDate pattern="dd/MM/yyyy"
									value="${cargo.remessa.dthInicio}" />
							</label>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label for="email">Tipo Cargo</label> <label class="form-control"><tce:tipoCargo
									value="${cargo.grupo.categoria}" /></label>
						</div>
					</div>
					<div class="col-md-4">
						<div class="form-group">
							<label for="email">Código CBO</label> <label class="form-control">${cargo.codCbo}</label>
						</div>
					</div>
					<div class="col-md-12">
						<div class="form-group">
							<label for="cpf">Descrição</label> <label class="form-control">${cargo.descricao}</label>
						</div>
					</div>
					<div class="space-20"></div>
					<div class="row">
						<div class="col-md-12">

							<table id="tableEspecificacao"
								class="table table-striped table-responsive">
								<thead>
									<tr>
										<td colspan="7"><h3>Especificação do cargo</h3></td>
									</tr>
									<tr>
										<th>Ordem</th>
										<th>Descrição</th>
										<th>Função</th>
										<th>Escolaridade</th>
										<th>Carga Horária</th>
										<th>Total Vagas</th>
										<th>Número Vagas Lei</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="especificacao" items="${especificacoes}"
										varStatus="status">
										<tr>
											<td>${especificacao.ordem}</td>
											<td>${especificacao.descricao}</td>
											<td>${especificacao.funcao}</td>
											<td><tce:escolaridade
													value="${especificacao.escolaridade}" /></td>
											<td>${especificacao.cargaHoraria}</td>
											<td>${especificacao.totalVagas}</td>
											<td>${especificacao.numeroVagasLei}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="space-20"></div>
		<c:if test="${not empty historicos}">
			<div class="row" style="margin: 0px;">
				<div class="panel panel-primary">
					<div class="panel-heading">Histórico de Atualização</div>
					<div class="panel-body">
						<table id="tableAdmissao"
							class="table table-striped table-responsive">
							<thead>
								<tr>
									<th>Descrição cargo</th>
									<th>Função</th>
									<th>Escolaridade</th>
									<th>Carga Horária</th>
									<th>Total Vagas</th>
									<th>Número Vagas Lei</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="especificacao" items="${historicos}"
									varStatus="status">
									<tr>
										<td>${especificacao.cargoDescricao}</td>
										<td>${especificacao.funcao}</td>
										<td><tce:escolaridade
												value="${especificacao.escolaridade}" /></td>
										<td>${especificacao.cargaHoraria}</td>
										<td>${especificacao.totalVagas}</td>
										<td>${especificacao.numeroVagasLei}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</c:if>
		<div class="row align-right" style="margin: 0px; text-align: right;">
			<div class="btn-group" role="group">
				<button onclick="javascript: history.go(-1)" type="button"
					class="btn btn-default">Voltar</button>
			</div>
		</div>
		<div class="space-20"></div>
	</tiles:putAttribute>
</tiles:insertDefinition>
