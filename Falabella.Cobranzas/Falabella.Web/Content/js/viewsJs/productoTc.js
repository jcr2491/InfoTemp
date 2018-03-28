var productoTcJs = function () {
    var _urls = {};
    var _dtListar;
    var _actions = { crear: "1", editar: "2", eliminar: "3" };

    var initializeGrid = function (data) {
        _dtListar = $('#dtListar').DataTable({
            responsive: true,
            "bAutoWidth": false,
            language: {
                "url": _urls.urlLanguage
            },
            data: data,
            columns: [
                { data: "Codigo", type: 'integer', width: "25%" },
                { data: "FechaRegistro", type: 'datetime', width: "25%" },
                {
                    data: function (oObj) {
                        return '<td>\
                                <div class="hidden-sm hidden-xs action-buttons">\
									<a class="red" href="javascript:void(0)" data-action="' + _actions.eliminar + '" data-info="' + oObj.Id + '">\
										<i class="ace-icon fa fa-trash-o bigger-130"></i>\
									</a>\
								</div>\
								<div class="hidden-md hidden-lg">\
									<div class="inline pos-rel">\
										<button class="btn btn-minier btn-yellow dropdown-toggle" data-toggle="dropdown" data-position="auto">\
											<i class="ace-icon fa fa-caret-down icon-only bigger-120"></i>\
										</button>\
										<ul class="dropdown-menu dropdown-only-icon dropdown-yellow dropdown-menu-right dropdown-caret dropdown-close">\
											<li>\
												<a href="javascript:void(0)" class="tooltip-error" data-action="' + _actions.eliminar + '" data-info="' + oObj.Id + '" data-rel="tooltip" title="Eliminar">\
													<span class="red">\
														<i class="ace-icon fa fa-trash-o bigger-120"></i>\
													</span>\
												</a>\
											</li>\
										</ul>\
									</div>\
								</div>\
                            </td>';
                    },
                    orderable: false,
                    searchable: false,
                    width: "5%"
                }
            ],
            order: [[0, 'desc']]
        });
    }

    var listar = function () {
        webApp.Ajax({
            url: _urls.urlListar,
            success: function (response) {
                if (response.Success) {
                    initializeGrid(response.Data);
                }
            }
        });
    }

    var aplicarHandlers = function() {
        $("#dtListar").on("click", "a[data-info]", function () {
            var id = $(this).data('info');
            webApp.showConfirmDialog(function() {
                    webApp.Ajax({
                        url: _urls.urlEliminar,
                        parametros: { id: id },
                        success: function(response) {
                            if (response.Success) {
                                $.gritter.add({
                                    title: 'Informaci&oacute;n',
                                    text: response.Message,
                                    class_name: 'gritter-success'
                                });
                                _dtListar.clear();
                                _dtListar.destroy();
                                listar();
                            } else {
                                $.gritter.add({
                                    title: 'Error',
                                    text: response.Message,
                                    class_name: 'gritter-error'
                                });
                            }
                        }
                    });
                },
                'Se eliminar&aacute; el registro. Est&aacute; seguro que desea continuar?');
        });

        $("#btnAgregar").on("click",
            function() {
                var codigo = $("#txtCodigo").val().trim();

                if (codigo == '') {
                    webApp.showMessageDialog("Ingrese un c&oacute;digo");
                    return;
                }

                webApp.showConfirmDialog(function() {
                        webApp.Ajax({
                            url: _urls.urlAgregar,
                            parametros: { codigo: codigo },
                            success: function(response) {
                                if (response.Success) {
                                    $.gritter.add({
                                        title: 'Informaci&oacute;n',
                                        text: response.Message,
                                        class_name: 'gritter-success'
                                    });

                                    $("#txtCodigo").val('');
                                    _dtListar.clear();
                                    _dtListar.destroy();
                                    listar();
                                }
                            }
                        });
                    },
                    'Se guardar&aacute;n los datos; seguro que desea continuar?');
            });

        $("#txtCodigo").on('keyup', function() {
            this.value = (this.value + '').replace(/[^0-9]/g, '');
        });
    }

    return {
        //main function to initiate page
        init: function (parametros) {
            _urls = {
                urlLanguage: parametros.urlLanguage,
                urlListar: parametros.urlListar,
                urlEliminar: parametros.urlEliminar,
                urlAgregar: parametros.urlAgregar
            };
            aplicarHandlers();
            listar();
        }
    };
}();