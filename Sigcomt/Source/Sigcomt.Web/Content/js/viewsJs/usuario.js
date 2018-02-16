﻿var dataTableUsuario = null;
var formularioMantenimiento = "UsuarioForm";
var delRowPos = null;
var delRowID = 0;
var urlListar = baseUrl + 'Usuario/Listar';
var urlMantenimiento = baseUrlApiService + 'Usuario/';
var urlListaCargo = baseUrlApiService + 'Cargo/';
var rowUsuario = null;

$(document).ready(function () { 
    $.extend($.fn.dataTable.defaults, {
        language: { url: baseUrl + 'Content/js/dataTables/Internationalisation/es.txt' },
        responsive: true,
        "lengthMenu": [[10, 25, 50, 100], [10, 25, 50, 100]],
        "bProcessing": true,
        "dom": 'fltip'
    });   

    checkSession(function () {
        VisualizarDataTableUsuario();
    });     

    $('body').on('click', 'button.btnAgregarUsuario', function() {
        LimpiarFormulario();

        $("#UsuarioId").val(0);
        $("#accionTitle").text('Nuevo');
        $("#NuevoUsuario").modal("show");
    });

    $('body').on('click', 'a.editarUsuario', function () {
        rowUsuario = this;
        checkSession(function () {
            GetUsuarioById();
        });
    });      

    $('body').on('click', 'a.eliminarUsuario', function() {        
        var aPos = dataTableUsuario.fnGetPosition(this.parentNode.parentNode);
        var aData = dataTableUsuario.fnGetData(aPos[0]);
        var rowID = aData.Id;

        delRowPos = aPos[0];
        delRowID = rowID;

        webApp.showDeleteConfirmDialog(function () {
            checkSession(function () {
                EliminarUsuario();
              });
            },'Se eliminará el registro. ¿Está seguro que desea continuar?');
    });

    $('body').on('click', 'a.btnBuscarUsuario', function () {

        $("#searchFilterUsuario").modal("show");
    });

    $("#btnSearchUsuario").on("click", function (e) {
        if ($('#UsuarioSearchForm').valid()) {
            checkSession(function () {
            dataTableUsuario.fnReloadAjax();
            $("#searchFilterUsuario").modal("hide");
            });
        }
        e.preventDefault();
    });

    $("#btnGuardarUsuario").on("click", function (e) { 

        if($('#'+formularioMantenimiento).valid()){

            webApp.showReConfirmDialog(function () {
                checkSession(function () {
                    GuardarUsuario();
                });
            });
        }

        e.preventDefault();
    });  

    webApp.validarLetrasEspacio(['Username', 'Nombre', 'Apellido']);
    $('#Correo').validCampoFranz('@abcdefghijklmnÃ±opqrstuvwxyz_1234567890.');

    webApp.InicializarValidacion(formularioMantenimiento, 
        {
            Username: {
                required: true,
                noPasteAllowLetterAndSpace: true,
                firstCharacterBeLetter: true
            },
            Nombre: {
                required: true,
                noPasteAllowLetterAndSpace: true,
                firstCharacterBeLetter: true
            },
            Apellido: {
                required: true,
                noPasteAllowLetterAndSpace: true,
                firstCharacterBeLetter: true
            },
            Correo: {
                required: true,
                correoElectronico: true,
                firstCharacterBeLetter: true
            },
            CargoId: {
                required: true
            },
            RolId: {
                required: true
            }            
        },
        {
            Username: {
                required: "Por favor ingrese Usuario",
             
            },
            Nombre: {
                required: "Por favor ingrese Nombre"
            },
            Apellido: {
                required: "Por favor ingrese Apellido"
            },
            Correo: {
                required: "Por favor ingrese Correo",
                correoElectronico: "Por favor ingrese Correo válido"
            },
            CargoId: {
                required: "Por favor seleccione Cargo"
            },
            RolId: {
                required: "Por favor seleccione Rol"
            }            
        });
    CargarCargo();
    CargarRol();

});

function VisualizarDataTableUsuario() {
    dataTableUsuario = $('#UsuarioDataTable').dataTable({
        "bFilter": false,
        "bProcessing": true,
        "serverSide": true,  
        //"scrollY": "350px",              
        "ajax": {
            "url": urlListar,
            "type": "POST",
            "data": function (request) {
                request.filter = new Object();
               
                request.filter = {
                    UsernameSearch: $("#UsuarioSearch").val(),
                    RolIdSearch : $("#RolIdSearch").val()
                }
            },
            dataFilter: function (data) {
                if (data.substring(0, 9) == "<!DOCTYPE") {
                    redireccionarLogin("Sesión Terminada", "Se terminó la sesión");
                } else {
                    return data;
                    //var json = jQuery.parseJSON(data);
                    //return JSON.stringify(json); // return JSON string
                }                
            }
        },
        "bAutoWidth": false,
        "columns": [
            {
                "data": function (obj) {

                    return '<div class="action-buttons">\
                    <a class="green editarUsuario" href="javascript:void(0)"><i class="ace-icon fa fa-pencil bigger-130"></i></a>\
                    <a class="red eliminarUsuario" href="javascript:void(0)"><i class="ace-icon fa fa-trash-o bigger-130"></i></a>\
                    </div>';
                }
            },
            { "data": "Id" },
            { "data": "Username" },
            { "data": "Nombre" },
            { "data": "Apellido" },
            { "data": "Correo" },
            { "data": "RolNombre" },
            { "data": function(obj){
                    if(obj.Estado == "1")
                        return '<span class="label label-info label-sm arrowed-in arrowed-in-right">Activo</span>';
                    else
                        return '<span class="label label-sm arrowed-in arrowed-in-right">Inactivo</span>';
                }
            }
        ],
        "aoColumnDefs": [
            { "bSortable": false, "sClass": "center", "aTargets": [0], "width": "10%"},
            { "bVisible": false,  "aTargets": [1]},
            { "aTargets": [2], "width": "10%"},
            { "className": "hidden-1200", "aTargets": [3], "width": "18%" },
            { "className": "hidden-992", "aTargets": [4], "width": "18%" },
            { "className": "hidden-768", "aTargets": [5], "width": "20%"},
            { "className": "hidden-600", "aTargets": [6], "width": "10%" },
            { "bSortable": false, "className": "hidden-480", "aTargets": [7], "width": "10%" }

        ],
        "order": [[1, "desc"]],
        "initComplete": function (settings, json) {
            AddSearchFilter();
        },
        "fnDrawCallback": function (oSettings) {
            
        }
    });
}

function GetUsuarioById() {
        var aPos = dataTableUsuario.fnGetPosition(rowUsuario.parentNode.parentNode);
        var aData = dataTableUsuario.fnGetData(aPos[0]);
        var rowID = aData.Id;

        var modelView = {
            Id : aData.Id
        };        

        webApp.Ajax({
            url: urlMantenimiento + 'GetById',
            parametros: modelView
        }, function(response){            
            if(response.Success){                
                if(response.Warning){                           
                    $.gritter.add({
                        title: 'Alerta',
                        text: response.Message,
                        class_name: 'gritter-warning gritter'
                    });                         
                }else{
                    LimpiarFormulario();
                    var usuario = response.Data;                    
                    $("#Username").val(usuario.Username);
                    $("#Nombre").val(usuario.Nombre);
                    $("#Apellido").val(usuario.Apellido);
                    $("#Correo").val(usuario.Correo);
                    $("#CargoId").val(usuario.CargoId);
                    $("#RolId").val(usuario.RolId);
                    $("#Estado").val(usuario.Estado);
                    $("#UsuarioId").val(usuario.Id);

                    $("#accionTitle").text('Editar');
                    $("#NuevoUsuario").modal("show");
                }           

            }else{
                $.gritter.add({
                    title: 'Error',
                    text: response.Message,
                    class_name: 'gritter-error gritter'
                });                     
            }
        }, function(response){
            $.gritter.add({
                title: 'Error',
                text: response,
                class_name: 'gritter-error gritter'
            });
        }, function(XMLHttpRequest, textStatus, errorThrown){
            $.gritter.add({
                title: 'Error',
                text: "Status: " + textStatus + "<br/>Error: " + errorThrown,
                class_name: 'gritter-error gritter'
            });
        });
}

function EliminarUsuario(){
    var modelView = {
        Id: delRowID,
        UsuarioRegistro: $("#usernameLogOn strong").text()
    };

    webApp.Ajax({
        url: urlMantenimiento + 'Delete',
        async: false,
        parametros: modelView
    }, function(response){        
        if (response.Success) {            
            if(response.Warning){                           
                $.gritter.add({
                    title: 'Alerta',
                    text: response.Message,
                    class_name: 'gritter-warning gritter'
                });                         
            } else {
                $("#NuevoUsuario").modal("hide");
                dataTableUsuario.fnDeleteRow(delRowPos);
                $.gritter.add({
                    title: response.Title,
                    text: response.Message,
                    class_name: 'gritter-success gritter'
                });
            }
        }else{
            $.gritter.add({
                title: 'Error',
                text: response.Message,
                class_name: 'gritter-error gritter'
            });                     
        }
    }, function(response){
        $.gritter.add({
            title: 'Error',
            text: response,
            class_name: 'gritter-error gritter'
        });
    }, function(XMLHttpRequest, textStatus, errorThrown){
        $.gritter.add({
            title: 'Error',
            text: "Status: " + textStatus + "<br/>Error: " + errorThrown,
            class_name: 'gritter-error gritter'
        });
    });
    delRowPos = null;
    delRowID = 0;
} 

function GuardarUsuario() { 

    var modelView = {
        Id : $("#UsuarioId").val(),    
        Username : $("#Username").val(),
        Nombre : $("#Nombre").val(),
        Apellido : $("#Apellido").val(),
        Correo: $("#Correo").val(),
        CargoId: $("#CargoId").val(),
        RolId : $("#RolId").val(),
        Estado: $("#Estado").val(),
        UsuarioRegistro: $("#usernameLogOn strong").text()
    };

    if(modelView.Id == 0)
        action = 'Add';
    else
        action = 'Update';

    webApp.Ajax({
        url: urlMantenimiento + action,
        parametros: modelView
    }, function(response){        
        if (response.Success) {            
            if(response.Warning){                           
                $.gritter.add({
                    title: response.Title,
                    text: response.Message,
                    class_name: 'gritter-warning gritter'
                });                         
            } else {
                $("#NuevoUsuario").modal("hide");
                dataTableUsuario.fnReloadAjax();
                $.gritter.add({
                    title: response.Title,
                    text: response.Message,
                    class_name: 'gritter-success gritter'
                });
            }
        }else{
            $.gritter.add({
                title: 'Error',
                text: response.Message,
                class_name: 'gritter-error gritter'
            });                     
        }
    }, function(response){
        $.gritter.add({
            title: 'Error',
            text: response,
            class_name: 'gritter-error gritter'
        });
    }, function(XMLHttpRequest, textStatus, errorThrown){
        $.gritter.add({
            title: 'Error',
            text: "Status: " + textStatus + "<br/>Error: " + errorThrown,
            class_name: 'gritter-error gritter'
        });
    });
}

function CargarCargo() {
    var WhereFilters = {
        whereFilter: 'WHERE Estado IN (1,2)'
    };
    webApp.Ajax({
        url: urlListaCargo +'GetAll',
        async: false,
        parametros: WhereFilters,
    }, function (response) {
        if (response.Success) {

            if (response.Warning) {
                $.gritter.add({
                    title: 'Alerta',
                    text: response.Message,
                    class_name: 'gritter-warning gritter'
                });
            } else {
                $.each(response.Data, function (index, item) {
                    $("#CargoId").append('<option value="' + item.Id + '">' + item.Nombre + '</option>');
                });
            }
        } else {
            $.gritter.add({
                title: 'Error',
                text: response.Message,
                class_name: 'gritter-error gritter'
            });
        }
    }, function (response) {
        $.gritter.add({
            title: 'Error',
            text: response,
            class_name: 'gritter-error gritter'
        });
    }, function (XMLHttpRequest, textStatus, errorThrown) {
        $.gritter.add({
            title: 'Error',
            text: "Status: " + textStatus + "<br/>Error: " + errorThrown,
            class_name: 'gritter-error gritter'
        });
    });
}

function CargarRol(){

    webApp.Ajax({
        url: baseUrlApiService + 'Rol/GetAllActives',
        async: false,
    }, function(response){
        if(response.Success){
            
            if(response.Warning){                           
                $.gritter.add({
                    title: 'Alerta',
                    text: response.Message,
                    class_name: 'gritter-warning gritter'
                });                         
            } else {
                $("#RolIdSearch").append('<option value=""> - TODOS - </option>');
                $.each(response.Data, function(index, item){
                    $("#RolId,#RolIdSearch").append('<option value="' + item.Id + '">' + item.Nombre + '</option>');
                });
                webApp.clearForm('UsuarioSearchForm');
            }
        }else{
            $.gritter.add({
                title: 'Error',
                text: response.Message,
                class_name: 'gritter-error gritter'
            });                     
        }
    }, function(response){
        $.gritter.add({
            title: 'Error',
            text: response,
            class_name: 'gritter-error gritter'
        });
    }, function(XMLHttpRequest, textStatus, errorThrown){
        $.gritter.add({
            title: 'Error',
            text: "Status: " + textStatus + "<br/>Error: " + errorThrown,
            class_name: 'gritter-error gritter'
        });
    });
}

function AddSearchFilter() {
    $("#UsuarioDataTable_wrapper").prepend($("#searchFilterDiv").html());
}

function LimpiarFormulario(){
    webApp.clearForm(formularioMantenimiento);
    $("#CargoId").val(1);
    $("#RolId").val(1);
    $("#Estado").val(1);
    $("#Username").focus();
}