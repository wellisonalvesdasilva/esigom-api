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
			
			@media print {
				body{
					font-size: 10px !important;
				}
				
				h2, h1{
					font-size: 18px !important;
				}
				
				.btn-group, footer, nav{
					display:none !important;
				}
				.space-20{
					height: 0px;
				}
			}
			
		</style>
		<h1 class="one">
			<span>Detalhe Folha de Pagamento</span>
		</h1>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Dados da Folha de Pagamento</div>
				<div class="panel-body">
					<div class="row">
						<div class="col-md-2 col-xs-2">
							<div class="form-group">
								<label for="email">Mês Referência</label> <label
									class="form-control">${folhaServidor.mesReferencia}</label>
							</div>
						</div>
						<div class="col-md-2 col-xs-2">
							<div class="form-group">
								<label for="email">Ano Referência</label> <label
									class="form-control">${folhaServidor.anoReferencia}</label>
							</div>
						</div>
						<div class="col-md-5 col-xs-5">
							<div class="form-group">
								<label for="email">Descrição Cargo</label> <label
									class="form-control">${folhaServidor.cargo}</label>
							</div>
						</div>
						<div class="col-md-3 col-xs-3">
							<div class="form-group">
								<label for="cpf">Código CBO</label> <label class="form-control">${folhaServidor.codCbo}</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-2 col-xs-2">
							<div class="form-group">
								<label for="email">Número da Matrícula</label> <label
									class="form-control">${folhaServidor.matricula}</label>
							</div>
						</div>
						<div class="col-md-2 col-xs-2">
							<div class="form-group">
								<label for="email">Dígito Verificador</label> <label
									class="form-control">${folhaServidor.dvMatricula}</label>
							</div>
						</div>
						<div class="col-md-5 col-xs-5">
							<div class="form-group">
								<label for="email">Nome</label> <label class="form-control">${folhaServidor.nome}</label>
							</div>
						</div>
						<div class="col-md-3 col-xs-3">
							<div class="form-group">
								<label for="cpf">CPF</label> <label class="form-control">${folhaServidor.cpf}</label>
							</div>
						</div>

					</div>
					<div class="row">
						<div class="col-md-2 col-xs-3">
							<div class="form-group">
								<label for="email">Tipo Admissão</label> 
								<label class="form-control"> <tce:tipoAdmissao value="${folhaServidor.codTipo}"/> </label>
							</div>
						</div>
						<div class="col-md-2 col-xs-3">
							<div class="form-group">
								<label for="email">Situação Admissão</label> 
								<label class="form-control"> <tce:situacaoAdmissao value="${folhaServidor.codSituacao}"/> </label>
							</div>
						</div>
					</div>
					<div class="row"></div>
				</div>
			</div>
		</div>
		<div class="space-20"></div>
		<div class="panel panel-primary">
				<div class="panel-heading">Dados do Plano de Cargo</div>
				<div class="panel-body">
				<c:if test="${not empty cargo.cod}">
					<div class="row">
						<div class="col-md-2 col-xs-3">
							<div class="form-group">
								<label for="email">COD CBO</label> <label
									class="form-control">${cargo.codCbo}</label>
							</div>
						</div>
						<div class="col-md-10 col-xs-9">
							<div class="form-group">
								<label for="email">Descrição</label> <label
									class="form-control">${cargo.descricao}</label>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-12 col-xs-12">
							<table id="tableEspecificacoes"
								class="table table-striped table-responsive">
								<thead>
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
									<c:forEach var="cargoAtributo" items="${cargo.cargoAtributos}" varStatus="status">
										<tr>
											<td>${cargoAtributo.ordem}</td>
											<td>${cargoAtributo.descricao}</td>
											<td>${cargoAtributo.funcao}</td>
											<td><tce:escolaridade value="${cargoAtributo.escolaridade}"/> </td>
											<td>${cargoAtributo.cargaHoraria}</td>
											<td>${cargoAtributo.totalVagas}</td>
											<td>${cargoAtributo.numeroVagasLei}</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					</c:if>
					<c:if test="${empty cargo.cod}">
						<h2>Não foi encontrado Cargo ${folhaServidor.cargo} no Plano de Cargo</h2>
					</c:if>
				</div>
		</div>
		<div class="space-20"></div>
		<div class="row" style="margin: 0px;">
			<div class="panel panel-primary">
				<div class="panel-heading">Dados das Remunerações</div>
				<div class="panel-body">
					<div class="col-md-12 col-xs-12">
					<table id="tableAdmissao"
						class="table table-striped table-responsive">
						<thead>
							<tr>
								<th>Ordem</th>
								<th>Desconto ou Remuneração</th>
								<th>Tipo</th>
								<th>Descrição</th>
								<th>Valor</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="remuneracao" items="${remuneracoes}" varStatus="status">
								<tr>
									<td>${remuneracao.ordem}</td>
									<td><tce:tipoRemuneracao value="${remuneracao.descontar}"/> </td>
									<td>${remuneracao.descricao}</td>
									<td>${remuneracao.outroTipoRemuneracao}</td>
									<td>${remuneracao.valor}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row align-left" style="margin: 0px;">
			<div class="btn-group" role="group">
				<button onclick="window.print(); return false;" type="button" class="btn btn-info"><i class="fa fa-print"></i> Imprimir</button>
			</div>	
			<div class="btn-group" role="group">
				<button onclick="history.go(-1); return false;" type="button" class="btn btn-default"><i class="fa fa-undo"></i> Voltar</button>
			</div>
		</div>
		<div class="space-20"></div>
	</tiles:putAttribute>
</tiles:insertDefinition>
