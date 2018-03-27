var contencionCierreReportJs = function () {
    var _urls = {};
    var rangos = [];
    var paises;

    var cargarRangos = function(paisId) {
        rangos.forEach(function (value) {
            if (value.PaisId == paisId) {
                $('#txtRangoMin' + value.Rango).val(value.DiaMoraMin);
                $('#txtRangoMax' + value.Rango).val(value.DiaMoraMax);

                $("#chkFinal")
                    .prop('checked', value.DiaMoraMax == null)
                    .trigger('change');
            }
        });
    }

	var aplicarHandlers = function() {
	    $("input[id^=txtRango]").on("change", function () {
	        var paisId = $('input[name=rdbPais]:checked').val();
	        var inputId = $(this).prop('id');
	        var inputValue = $(this).val();

	        rangos.forEach(function(value) {
	            if (value.PaisId == paisId) {
	                if ('txtRangoMin' + value.Rango == inputId) {
	                    value.DiaMoraMin = inputValue;
	                }
	                else if ('txtRangoMax' + value.Rango == inputId) {
	                    value.DiaMoraMax = inputValue;
	                }
	            }
	        });
	    });

        $("#chkFinal").on("change", function () {
            if ($(this).is(":checked")) {
                $("#txtRangoMax8")
                    .val('')
                    .prop("disabled", true);
            } else {
                $("#txtRangoMax8").prop("disabled", false);
            }
        });

        $("#chkSoloHistorico").on("change", function () {
	        if ($(this).is(":checked")) {
	            $("#chkIncluirHistorico")
	                .prop("checked", true)
	                .prop("disabled", true);
	        } else {
	            $("#chkIncluirHistorico")
	                .prop("checked", false)
	                .prop("disabled", false);
	        }
        });

	    $("#chkEditarRangos").on("change", function () {
	        if ($(this).is(":checked")) {
	            $("input[id^=txtRango]").prop("disabled", false);
	            $("#chkFinal").prop("disabled", false);
	            $("#btnGuardarRangos").prop("disabled", false);
	            $("#txtRangoMax8").prop("disabled",  $("#chkFinal").is(":checked"));
	        } else {
	            $("input[id^=txtRango]").prop("disabled", true);
	            $("#chkFinal").prop("disabled", true);
	            $("#btnGuardarRangos").prop("disabled", true);
	        }
	    });

        $("input[name=rdbPais]").on("change", function () {
            cargarRangos($(this).val());
        });

	    $("#btnExportar").on("click", function (e) {
	        var filters = new Object();
	        var value = $("#txtMes").datepicker("getFormattedDate", "dd/mm/yyyy");
	        var msj = '';

	        if (value !== '') {
	            filters.Fecha = value;
	        } else {
	            msj = 'Seleccione mes.<br />';
	        }

	        if (msj !== '') {
	            webApp.showMessageDialog(msj);
	            e.preventDefault();
	            return;
	        }

	        filters.IncluirHistorico = $("#chkIncluirHistorico").is(":checked");
	        filters.SoloHistorico = $("#chkSoloHistorico").is(":checked");

	        $(this).prop("disabled", true);
	        webApp.Ajax({
	            url: _urls.urlExportar,
	            parametros: filters,
	            success: function (response) {
	                $("#btnExportar").prop("disabled", false);
	                if (response.Success) {
	                    if (filters.SoloHistorico === false) {
	                        webApp.showConfirmDialog(function () {
	                            $("#btnExportar").prop("disabled", true);
	                            webApp.Ajax({
	                                url: _urls.urlGuardarHistorico,
	                                parametros: filters,
	                                success: function (response) {
	                                    $("#btnExportar").prop("disabled", false);
	                                    if (response.Success) {
	                                        $.gritter.add({
	                                            title: 'Informaci&oacute;n',
	                                            text: response.Message,
	                                            class_name: 'gritter-success'
	                                        });
	                                    } else {
	                                        $.gritter.add({
	                                            title: 'Error',
	                                            text: response.Message,
	                                            class_name: 'gritter-error'
	                                        });
	                                    }
	                                }
	                            });
	                        }, "Desea guardar el resultado en el hist&oacute;rico?");
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
            
        $("#btnGuardarRangos").on("click", function(e) {
            var filters = new Object();
            var value = $("#txtMes").datepicker("getFormattedDate", "dd/mm/yyyy");
            var msj = '';

            if (value !== '') {
                filters.Fecha = value;
            } else {
                msj = 'Ingrese una fecha.<br />';
            }

            filters.Rangos = rangos;

            if (msj !== '') {
                webApp.showMessageDialog(msj);
                e.preventDefault();
                return;
            }
            
            $(this).prop("disabled", true);
            webApp.Ajax({
                url: _urls.urlGuardarRango,
    		    parametros: filters,
    		    success: function (response) {
		            $("#btnGuardarRangos").prop("disabled", false);
    		    	if(response.Success) {
			            $.gritter.add({
			                title: 'Informaci&oacute;n',
			                text: response.Message,
			                class_name: 'gritter-success'
			            });
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
            _urls = {
                urlExportar: parametros.urlExportar,
                urlGuardarRango: parametros.urlGuardarRango,
                urlGuardarHistorico: parametros.urlGuardarHistorico
            };
            rangos = parametros.rangos;
            paises = parametros.paises;

            webApp.datepickerMonth();
            webApp.datepickerYear();
            aplicarHandlers();
            cargarRangos($('input[name=rdbPais]:checked').val());
        }        
    };
}();