<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>


<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<style>
svg {
	background-color: none;
}
</style>
		<h1 class="one">
			<span>Detalhe Admissão</span>
		</h1>
		<div class="row">
			<div class="col-md-12 text-right">
				<a class='btn btn-default'
					href='/sicap-webapp/manager/relatorio/pessoa'><i
					class="fa fa-undo"></i> Voltar à Consulta Resumo de Admitido</a>
			</div>
		</div>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Dados Pessoais</div>
				<div class="panel-body">
					<div class="col-md-6">
						<div class="form-group">
							<label for="email">Nome</label> <label class="form-control">${pessoa.nome}</label>
						</div>
					</div>
					<div class="col-md-6">
						<div class="form-group">
							<label for="cpf">CPF</label> <label class="form-control">${pessoa.cpf}</label>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Dados Admissões</div>
				<div class="panel-body">
					<table id="tableAdmissao"
						class="table table-striped table-responsive">
						<thead>
							<tr>
								<th>Matrícula</th>
								<th>Data Admissão</th>
								<th>Tipo Admissão</th>
								<th>Unidade Gestora</th>
								<th>Descrição Cargo</th>
								<th>CBO Cargo</th>
								<th>Situação</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="admissao" items="${admissoes}" varStatus="status">
								<tr>
									<td>${admissao.matricula}-${admissao.dvMatricula}</td>
									<td><fmt:formatDate pattern="dd/MM/yyyy"
											value="${admissao.dataNomeacao}" /></td>
									<td><tce:tipoAdmissao value="${admissao.tipoAdmissao}" />
									</td>
									<td>${admissao.remessa.importacao.nomeUg}</td>
									<td>${admissao.cargoAtributo.cargo.descricao}</td>
									<td>${admissao.cargoAtributo.cargo.codCbo}</td>
									<td><tce:situacaoAdmissao value="${admissao.codStatus}" />
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<div class="space-20"></div>
	</tiles:putAttribute>
</tiles:insertDefinition>