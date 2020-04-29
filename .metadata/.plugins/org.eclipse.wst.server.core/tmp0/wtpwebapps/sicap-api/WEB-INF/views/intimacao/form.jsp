<%@taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<meta charset="utf-8">

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
			<span>Responder Intimação</span>
		</h1>
		<div class="space-20"></div>
		<form:form id="form" method="post"
			action="${pageContext.request.contextPath}/manager/intimacao/salvar"
			commandName="intimacao" enctype="multipart/form-data">
			<form:hidden path="cod" />
			<div class="row">
				<h3>Análise Técnica</h3>
				<div class="col-lg-12 col-md-12 col-sm-12 imp">
					<div class="panel-body">
						<div class="row" style="margin: 0px;!important">
							<div class="col-md-3 col-xs-3">
								<div class="form-group">
									<label for="processo">Processo</label> <label
										class="form-control background">${ato.processo}</label>
								</div>
							</div>
							<div class="col-md-3 col-xs-3">
								<div class="form-group">
									<label for="processo">Protocolo</label> <label
										class="form-control background">${ato.protocolo}</label>
								</div>
							</div>
							<div class="col-md-3 col-xs-3">
								<div class="form-group">
									<label for="processo">Baixar Arquivo</label><br /> <a
										class="btn btn-primary" target="_blank" href="${ato.caminho}">Baixar
										arquivo</a>
								</div>
							</div>


						</div>
					</div>
				</div>
			</div>
			<div class="row">
				<h3>Adicionar Arquivo .PDF</h3>
				<div class="col-lg-6 col-md-6 col-sm-6 imp">
					<div class="form-group">
						<span id="btn-file" class="btn btn-primary btn-file"> <%--accept=".zip,.xml, .pdf"--%>
							Selecionar arquivo<input accept=".pdf" class="form-control"
							id="fileuploadIntimacao" type="file"
							title="Selecione apenas um único arquivo" name="files"
							data-url="${pageContext.request.contextPath}/manager/intimacao/upload">
						</span> <span id="menagem"
							style="margin-left: 10px; color: red; display: none;">
							Tipo de arquivo inválido </span>
					</div>
					<span> **OBS: Deverá ser encaminhado o conteúdo de resposta
						em arquivo(s) formato PDF.</span>
				</div>
			</div>
			<div class="row">
				<h3>Lista de arquivo selecionado</h3>
				<table id="uploaded-files"
					class="table table-striped table-responsive">
					<thead>
						<tr>
							<th>Nome do arquivo</th>
							<th>Tamanho do Arquivo</th>
							<th>Tipo do Arquivo</th>
							<th>Ação</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="row">
				<label class="control-label">Resposta</label><br />
				<form:textarea path="textoResposta" id="textoResposta" cols="90"
					rows="12"></form:textarea>
			</div>
			<div class="space-40"></div>
			<div class="row">
				<div class="col-lg-2 col-md-2 col-sm-2">
					<button id="enviar" class="btn btn-primary btn-block btn-pesquisa "
						disabled="disabled" type="submit">
						<i class="fa fa-upload"></i> Responder / Enviar
					</button>
				</div>
				<div class="col-lg-2 col-md-2 col-sm-2">
					<button onclick="history.go(-1); return false;" type="button"
						class="btn btn-default btn-block btn-pesquisa">
						<i class="fa fa-ban"></i> Cancelar
					</button>
				</div>
			</div>
			<div class="space-40"></div>
			<%--<div class="row">
				<div class="col-lg-8">
					<h4>Mais informações:</h4>
					<ul>
						<li>Quando fizer-se necessário encaminhar um novo arquivo
							XML, os arquivos de importação deverão seguir também o formato
							ZIP, contendo um arquivo em formato XML e os arquivos em formato
							PDF, correspondentes às informações contidas no arquivo XML.</li>
					</ul>
				</div>
			</div>
			<br />--%>
		</form:form>
	</tiles:putAttribute>
</tiles:insertDefinition>

<script>
	var erroMessage = "${erro}";
	if (erroMessage != "") {
		toastr.error("${erro}");
	}
</script>
