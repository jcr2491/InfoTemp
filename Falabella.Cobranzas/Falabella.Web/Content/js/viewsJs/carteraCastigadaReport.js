var carteraCastigadaReportJs = function () {
    var _dtEstudios;
    var _urlLanguage;
    var _urlExportar;
    var _urlEstudios;
    var _estudioSinMetas;

    var initializeGrid = function (data) {
        _dtEstudios = $('#dtEstudios').DataTable({
            responsive: true,
            "bAutoWidth": false,
            language: {
                "url": _urlLanguage
            },
            data: data,
            columns: [
                {
                    data: function (oObj) {
                        var checked = oObj.Meta != null ? 'checked="true"' : '';
                        return '<label class="pos-rel">\
									<input type="checkbox" class="ace" value="' + oObj.Codigo + '" ' + checked + ' />\
									<span class="lbl"></span>\
								</label>';
                     },
                     orderable: false,
                     searchable: false,
                     width: "5%"
                },
	            { data: "Codigo", width: "15%" },
	            { data: "Nombre", width: "30%" },
	            { data: "Region", width: "15%" },
                { data: "Grupo", width: "12%" },
                {
                    data: function (oObj) {
                        return '<label class="pos-rel">\
									<input type="number" class="ace" data-codigo="' + oObj.Codigo + '" value="' + oObj.Meta + '" />\
									<span class="lbl"></span>\
								</label>';
                    },
                    orderable: false,
                    searchable: false,
                    width: "15%"
                }
            ],
            columnDefs: [
                {
                    targets: [0],
                    className: "center"
                },
	            {
	                targets: [2, 3, 4],
	                className: "hidden-480"
	            }
            ],
            lengthMenu: [25, 50, 100],
            order: [[3, 'asc']]
        });
    }

    var cargaDatos = function () {
        webApp.Ajax({
            url: _urlEstudios,
            parametros: { fecha: $("#txtFecha").datepicker("getFormattedDate", "dd/mm/yyyy") },
            success: function (response) {
                if (_dtEstudios != null) {
                    _dtEstudios.clear();
                    _dtEstudios.destroy();
                }
                initializeGrid(response.Data);
            }
        });
    }

    var getDatosMeta = function () {
        var estudioMetas = [];
        var meta = 0;
        var rows = _dtEstudios.rows().nodes();
        _estudioSinMetas = '';

        $.each(_dtEstudios.rows().data(), function( index, value ) {
            if ($('input[type="checkbox"][value=' + value.Codigo + ']', rows).is(':checked')) {
                meta = $('input[type="number"][data-codigo=' + value.Codigo + ']', rows).val();
                if (meta === '') _estudioSinMetas += '<br/>' + value.Codigo;
                estudioMetas.push({ CodEstudio: value.Codigo, Meta: meta });
            }
        });

        return estudioMetas;
    }

    var aplicarHandlers = function () {
        $("#txtFecha").datepicker().on("changeDate", function () {
            cargaDatos();
        });

        $("#btnLimpiar").on("click", function() {
            webApp.clearForm("#formBusqueda");
        });

        $('#dtEstudios > thead > tr > th input[type=checkbox]').eq(0).on('click', function () {
            // Get all rows
            var rows = _dtEstudios.rows().nodes();
            // Check/uncheck checkboxes for all rows in the table
            $('input[type="checkbox"]', rows).prop('checked', this.checked);
        });

        $('#dtEstudios').on('change', 'tbody input[type="checkbox"]', function () {
            // If checkbox is not checked
            if (!this.checked) {
                var el = $('#dtEstudios > thead > tr > th input[type=checkbox]').eq(0);
                // If "Select all" control is checked and has 'indeterminate' property
                if (el && el.checked && ('indeterminate' in el)) {
                    // Set visual state of "Select all" control 
                    // as 'indeterminate'
                    el.indeterminate = true;
                }
            }
        });

        $("#btnExportar").on("click", function (e) {
            var filters = new Object();
            var value = $("#txtFecha").datepicker("getFormattedDate", "dd/mm/yyyy");

            if (value !== '') {
                filters.FechaIni = value;
            } else {
                webApp.showMessageDialog("Seleccione fecha.");
                e.preventDefault();
                return;
            }

            value = $("#txtFactor").val();
            if (value !== '' && $.isNumeric(value)) {
                filters.FactorCrecimiento = value;
            } else {
                webApp.showMessageDialog("Ingrese un valor n&uacute;merico en factor de crecimiento.");
                e.preventDefault();
                return;
            }

            filters.EstudioMetaList = getDatosMeta();
            if (filters.EstudioMetaList.length === 0) {
                webApp.showMessageDialog("Seleccione al menos un estudio.");
                e.preventDefault();
                 return;
            } else if (_estudioSinMetas !== '') {
                webApp.showMessageDialog("Los siguientes estudios no tienen meta asignada: " + _estudioSinMetas);
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
            _urlLanguage = parametros.urlLanguage;
            _urlEstudios = parametros.urlEstudios;

            webApp.datepicker();
            aplicarHandlers();
        }
    };
}();