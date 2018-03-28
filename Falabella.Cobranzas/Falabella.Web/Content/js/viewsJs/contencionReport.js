var contencionReportJs = function () {
    var urlExportar;

	var aplicarHandlers = function() {
        $("#btnLimpiar").on("click", function () {
            webApp.clearForm("#formBusqueda");
        });
            
        $("#btnExportar").on("click", function(e) {
            var filters = new Object();
            var value = $("#txtFecha").datepicker("getFormattedDate", "dd/mm/yyyy");
            var msj = '';
        		
            if (value !== '') {
                filters.Fecha = value;
            } else {
                msj = 'Ingrese una fecha.<br />';
            }

            if (msj !== '') {
                webApp.showMessageDialog(msj);
                e.preventDefault();
                return;
            }
            
            webApp.Ajax({
                url: urlExportar,
    		    parametros: filters,
    		    success: function(response) {
    		    	if(response.Success) {
    		    		window.location.href = response.Data;
    		    	} else {
    	    			$.gritter.add({
    	    				title: 'Error',
    	    				text: response.Message,
    	    				class_name: 'gritter-error'
    	    			});                		
    	        	}
    		    }	    
    		});
        });
	}

    return {
        //main function to initiate page
        init: function (parametros) {
            urlExportar = parametros.urlExportar;

            webApp.datepicker();
        	aplicarHandlers();
        }        
    };
}();