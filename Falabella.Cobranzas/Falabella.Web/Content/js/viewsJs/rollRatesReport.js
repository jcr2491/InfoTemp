var rollRatesReportJs = function () {
    var urlExportar;

	var aplicarHandlers = function() {
        $("#btnLimpiar").on("click", function () {
            webApp.clearForm("#formBusqueda");
        });
            
        $("#btnExportar").on("click", function(e) {
            var filters = new Object();
            var value = $("#txtMes").datepicker("getFormattedDate", "dd/mm/yyyy");

            if (value !== '') {
                filters.Fecha = value;
            } else {
                webApp.showMessageDialog("Seleccione mes.");
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

        	webApp.datepickerMonth();
        	aplicarHandlers();
        }
    };
}();