<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="tce" uri="/WEB-INF/taglib/sicap.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ page contentType="text/html; charset=UTF-8"%>

<tiles:insertDefinition name="DefaultTemplate">
	<tiles:putAttribute name="body">
		<h1 class="one">
			<span>Bem Vindo ao sistema SICAP!</span>
		</h1>
		<div class="row">
			<div class="col-lg-12 col-md-3 col-sm-4">
				<br> <br>
				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;A Resolução Normativa do TC/MS
					n. 67, de 03/03/2010, com redação dada pela Resolução Normativa nº
					71, de 08 de junho de 2011, instituiu o Sistema Informatizado de
					Controle de Atos de Pessoal – SICAP, com a finalidade de receber e
					de manter banco de dados atualizado com informações relativas a
					atos de pessoal, bem como adotar o meio eletrônico na tramitação de
					processos, comunicação de atos, notificações e intimações,
					atendendo aos preceitos da Resolução Normativa do TC/MS n. 65, de
					16/12/2009.</p>
				<br>

				<p>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;O SICAP permite ao
					jurisdicionado efetuar, pela internet, o envio de informações,
					documentos e dados relativos aos atos de pessoal.</p>
				<br> <br> <br><br><br>
			</div>
		</div>
		<div class="row panel-footer text-right">
			<a class="btn btn-info" title="Manual de Peças (Resolução 88)"
				data-toggle="tooltip"
				href="http://www.tce.ms.gov.br/portal-services/files/tipo_legislacao/arquivo/109/6692d7edfe56aa458ff896ad3246869e.pdf"
				target="_blank"> <i class="fa fa-info-circle"></i> Manual
				de Peças Obrigatórias (Resolução 88)
			</a> <a class="btn btn-info" title="Manual SICAP"
				data-toggle="tooltip"
				href="http://www.tce.ms.gov.br/portaljurisdicionado/files/conteudos/arquivo/10/56e4be869242ad1033188d8a734a8802.pdf"
				target="_blank"> <i class="glyphicon glyphicon-list-alt"></i>
				Manual do Jurisdicionado
			</a> <a class="btn btn-info" title="Tabela SICAP"
				data-toggle="tooltip"
				href="http://www.tce.ms.gov.br/portaljurisdicionado/files/conteudos/arquivo/134/bb92eba09da4dc4ff4005571bf33d4ff.pdf"
				target="_blank"> <i class="glyphicon glyphicon-file"></i>
				Tabela XML Sicap
			</a>
		</div>
		<script>
			var sucessoMessage = "${message}";
			if (sucessoMessage != "") {
				toastr.success("${message}");
			}
		</script>
	</tiles:putAttribute>
</tiles:insertDefinition>