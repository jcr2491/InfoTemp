var carteraRefinanciadaReportJs = function() {
    var _urlExportar;

    var aplicarHandlers = function() {
        $("#btnLimpiar").on("click", function() {
            webApp.clearForm("#formBusqueda");
        });

        $("#btnExportar").on("click", function() {
            var filters = new Object();
            var value = $("#txtFecha").datepicker("getFormattedDate", "dd/mm/yyyy");

            if (value !== '') {
                filters.FechaFin = value;
            } else {
                webApp.showMessageDialog("Seleccione fecha.");
                e.preventDefault();
                return;
            }

            webApp.Ajax({
                url: _urlExportar,
                parametros: filters,
                success: function(response) {
                    if (response.Success) {
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
        init: function(parametros) {
            _urlExportar = parametros.urlExportar;

            webApp.datepicker();
            aplicarHandlers();
        }
    };
}();