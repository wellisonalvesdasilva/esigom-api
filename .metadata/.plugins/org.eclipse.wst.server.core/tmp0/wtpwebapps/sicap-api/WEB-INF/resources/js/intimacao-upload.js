$(function () {
	
    $('#fileuploadIntimacao').fileupload({
        dataType: 'json',
        add: function (e, data) {
        	
        	//var acceptFileTypes = /\/(xml|pdf|x-zip-compressed|zip)$/i;
        	//var acceptFileTypes = /\/(x-zip-compressed|zip)$/i;
        	var acceptFileTypes = /\/(pdf)$/i;
        	console.log(data.originalFiles[0]);
        	/*
        	if($('#fileuploadIntimacao') != null){
				$('#fileuploadIntimacao').prop("disabled","disabled");
      
        	}
        	*/
        	if(data.originalFiles[0]['type'].length && !acceptFileTypes.test(data.originalFiles[0]['type'])) {
        		$( "#btn-file" ).removeClass( "btn-primary" ).addClass( "btn-danger" );
        		$("#menagem").show();
				$('#fileuploadIntimacao').prop("disabled","");
				
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
            	console.log(file);
            	//if(file.fileType == 'application/pdf' || file.fileType == 'application/octet-stream' || file.fileType == 'application/zip' || file.fileType == 'text/xml' || file.fileType == 'application/x-zip-compressed'){
            	 //if(file.fileType == 'application/octet-stream' || file.fileType == 'application/zip' || file.fileType == 'application/x-zip-compressed'){
            	  if(file.fileType == 'application/pdf' || file.fileType == 'application/octet-stream'){
                    $('#enviar').prop("disabled", "");
            	}
            	
                $("#uploaded-files").append(
                		$('<tr/>')
                		.append($('<td/>').text(file.fileName))
                		.append($('<td/>').text(file.fileSize))
                		.append($('<td/>').text(file.fileType))
                		.append($('<td/>').html("<a class='btn btn-danger' onclick='remover("+index+")' > <i class='fa fa-times-circle'></i> Remover</a>"))
                		)
            }); 
        }
    });
    
    
});


function remover(index){
	$.ajax({
		url: "/sicap-webapp/manager/intimacao/remover_arquivo",
		data: {id:index},
		method: "POST",
		success: function(data){
			$('#enviar').prop("disabled", "disabled");
				$("tr:has(td)").remove();
	          	$('#fileuploadIntimacao').prop("disabled", "");
				$.each(data, function (index, file) {
					
					
				//	if(file.fileType == 'application/zip' || file.fileType == 'text/xml' || file.fileType == 'application/x-zip-compressed'){
					//	$('#enviar').prop("disabled", "");
	            	//}

					/*if(file.fileType == 'application/zip' || file.fileType == 'application/x-zip-compressed'){
						$('#enviar').prop("disabled", "");
	            	}*/
					
					if(file.fileType == 'application/pdf' || file.fileType == 'application/octet-stream'){
						$('#enviar').prop("disabled", "");
	            	}
					
					 $("#uploaded-files").append(
		                		$('<tr/>')
		                		.append($('<td/>').text(file.fileName))
		                		.append($('<td/>').text(file.fileSize))
		                		.append($('<td/>').text(file.fileType))
		                		.append($('<td/>').html("<a class='btn btn-danger' onclick='remover("+index+")' > <i class='fa fa-times-circle'></i> Remover</a>"))
		                		)
	            }); 
		}
	})
}