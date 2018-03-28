var productividadReportJs = function () {
    var _urlExportar;

    var aplicarHandlers = function() {
        $("#btnLimpiar").on("click", function() {
            webApp.clearForm("#formBusqueda");
        });

        $("#btnExportar").on("click", function (e) {
            var filters = new Object();
            var value = $("#txtFecha").datepicker("getFormattedDate", "dd/mm/yyyy");

            if (value === '') {
                webApp.showMessageDialog("Seleccione fecha.");
                e.preventDefault();
                return;
            }

            filters.Fecha = value;
            value = $("#selTramo").val();

            if (value === null) {
                webApp.showMessageDialog("Seleccione un tramo.");
                e.preventDefault();
                return;
            }
            filters.Tramos = value;

            webApp.Ajax({
                url: _urlExportar,
                parametros: filters,
                success: function(response) {
                    if (response.Success) {
                        if (response.Message !== "") {
                            $.gritter.add({
                                title: 'Advertencia',
                                text: response.Message,
                                class_name: 'gritter-warning'
                            });
                        }
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