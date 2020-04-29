$(function () {
	
    $('#fileupload').fileupload({
        dataType: 'json',
        add: function (e, data) {
        	
        	var acceptFileTypes = /\/(xml|pdf|x-zip-compressed|zip)$/i;
        	
        	
        	if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
        		$( "#btn-file" ).removeClass( "btn-primary" ).addClass( "btn-danger" );
        		$("#menagem").show();
        		return false;
            }else{
            	$( "#btn-file" ).removeClass( "btn-danger" ).addClass( "btn-primary" );
            	$("#menagem").hide();
            }
        	
            data.submit();
        },
        
        done: function (e, data) {
        	$('#enviar').prop("disabled", "disabled");
        	$("tr:has(td)").remove();
            $.each(data.result, function (index, file) {
            	if(file.fileType == 'application/octet-stream' || file.fileType == 'application/zip' || file.fileType == 'text/xml' || file.fileType == 'application/x-zip-compressed'){
            		$('#enviar').prop("disabled", "");
            	}
            	
                $("#uploaded-files").append(
                		$('<tr/>')
                		.append($('<td/>').text(file.fileName))
                		.append($('<td/>').text(file.fileSize))
                		.append($('<td/>').text(file.fileType))
                		.append($('<td/>').html("<a class='btn btn-danger' onclick='remover_importacao("+index+")' > <i class='fa fa-times-circle'></i> Remover</a>"))
                		)
            }); 
        }
    });
    
    
});


function remover_importacao(index){
	console.log(index);
	$.ajax({
		url: "/sicap-webapp/manager/importacao/remover_arquivo",
		data: {id:index},
		method: "POST",
		success: function(data){
			$('#enviar').prop("disabled", "disabled");
				$("tr:has(td)").remove();
				$.each(data, function (index, file) {
					
					if(file.fileType == 'application/zip' || file.fileType == 'text/xml' || file.fileType == 'application/x-zip-compressed'){
						$('#enviar').prop("disabled", "");
	            	}
					
					 $("#uploaded-files").append(
		                		$('<tr/>')
		                		.append($('<td/>').text(file.fileName))
		                		.append($('<td/>').text(file.fileSize))
		                		.append($('<td/>').text(file.fileType))
		                		.append($('<td/>').html("<a class='btn btn-danger' onclick='remover_importacao("+index+")' > <i class='fa fa-times-circle'></i> Remover</a>"))
		                		)
	            }); 
		}
	});
}