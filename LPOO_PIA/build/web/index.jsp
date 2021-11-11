<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.*" %>
<%@page import="java.io.*" %>
<%@page import="logic.*" %>

<%
    String msg = "";
    int encontrado=0;
    //LLAMADO A FUNCIONES DEL CONTROLADOR DEPENDIENDO EL BOTÓN PRESIONADO
   
    Persona loPersona = new Persona();
    Controlador.application=application;
    Controlador control = new Controlador();
    control.RecibirPropiedades();
    if (request.getParameter("btn") != null) {
        if (request.getParameter("btn").equals("Crear")) {
            
            loPersona = Controlador.GetPerson(
                    request.getParameter("txtEmail"),
                    request.getParameter("txtTel"));
            if (loPersona.getNombre().isEmpty()) {
                if(!control.Vacio(request.getParameter("txtID"),
                        request.getParameter("txtNombre"),
                        request.getParameter("txtApPaterno"),
                        request.getParameter("txtEmail"),
                        request.getParameter("txtTel"),
                        request.getParameter("txtFecha")))
                {
                            control.Agregar(
                                request.getParameter("txtNombre"),
                                request.getParameter("txtApPaterno"),
                                request.getParameter("txtApMaterno"),
                                request.getParameter("txtEmail"),
                                request.getParameter("txtTel"),
                                request.getParameter("txtFecha"));
                            msg="Registro agregado con exito";
                }
                else{
                    msg="Faltan datos obligatorios (*)";
                }
                
                
            }
            
            else{
                msg="Ya se registró ese Numero de Telefono o Email";
            }
            
            encontrado=0;

        } else if (request.getParameter("btn").equals("Consultar")) {
            
            loPersona = control.GetPerson(
                    request.getParameter("txtEmail"),
                    request.getParameter("txtTel"));
            
            if (!loPersona.getNombre().isEmpty()) {
                msg="";
                encontrado=1;
            }
            else{
                msg="Registro no encontrado";
                encontrado=0;
            }

        } else if (request.getParameter("btn").equals("Modificar")) {
            
            if (request.getParameter("txtEncontrado").equals("1")) {
                if(!control.Vacio(request.getParameter("txtID"),
                        request.getParameter("txtNombre"),
                        request.getParameter("txtApPaterno"),
                        request.getParameter("txtEmail"),
                        request.getParameter("txtTel"),
                        request.getParameter("txtFecha")))
                {
                    control.Modificar(
                        request.getParameter("txtID"),
                        request.getParameter("txtNombre"),
                        request.getParameter("txtApPaterno"),
                        request.getParameter("txtApMaterno"),
                        request.getParameter("txtEmail"),
                        request.getParameter("txtTel"),
                        request.getParameter("txtFecha"));
                
                    msg="Registro modificado";
                }
                else{
                    msg="Faltan datos obligatorios (*)";
                }
                
            }
            else{
                msg="Primero se debe realizar una consulta";
            }
            encontrado=0;
        } else if (request.getParameter("btn").equals("Eliminar")) {
            if(request.getParameter("txtEncontrado").equals("1")){
                control.Eliminar(request.getParameter("txtID"));
                msg="Registro Eliminado";
            }
            else{
                msg="Primero se debe realizar una consulta";
            }
            
            encontrado=0;
        }

    } %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="newcss.css" type="text/css"/>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Principal</title>
        <%
            if(!msg.isEmpty()){ %>
        <script language="javascript">
            alert("<%= msg %>");
        </script>
        <% } %>
    </head>
    <body>
        <div class="container">
            <div class="title">Registro </div>
            <div class="content">
                <form action="." method="POST" >
                    <div class="user-details">
                        <div class="input-box">
                            <span class="details">Nombre*</span>
                            <input type="text" name="txtNombre" placeholder="Ingresa tu Nombre" value="<%= loPersona.getNombre()%>">
                        </div>
                        <div class="input-box">
                            <span class="details">Apellido Paterno*</span>
                            <input type="text" name="txtApPaterno" placeholder="Ingresa tu Primer Apellido" value="<%= loPersona.getApellidoP()%>">
                        </div>
                        <div class="input-box">
                            <span class="details">Apellido Materno</span>
                            <input type="text" name="txtApMaterno" placeholder="Ingresa tu Segundo Apellido"value="<%= loPersona.getApellidoM()%>">
                        </div>
                        <div class="input-box">
                            <span class="details">Email*</span>
                            <input type="text" name="txtEmail" placeholder="Ingresa tu Correo Electrónico"value="<%= loPersona.getCorreo()%>" >
                        </div>
                        <div class="input-box">
                            <span class="details">Teléfono*</span>
                            <input type="number" name="txtTel" placeholder="Ingresa tu Numero de Teléfono" value="<%= loPersona.getTelefono() %>">
                        </div>
                        <div class="input-box">
                            <span class="details">Fecha (dd/mm/aaaa)*</span>
                            <input type="text" name="txtFecha" placeholder="Ingresa tu fecha de Nacimiento" value="<%= loPersona.getFecha()%>" >
                        </div>
                        
                        <input type="hidden" name="txtID" value="<%= loPersona.getID() %>" >
                        <input type="hidden" name="txtEncontrado" value="<%= encontrado %>" >
                    </div>

                    <div class="button">
                        <input type="submit" name="btn" value="Crear">
                    </div>
                    <center><div class="details" >Para consultar un registro ingresar Teléfono o Email</div></center>

                    <div class="button">
                        <input type="submit" name="btn" value="Consultar">
                    </div>
                    <div class="button2">
                        <center>
                            <div class="details" >Para modificar o eliminar un registro es necesario consultar primero</div>
                            <input type="submit" name="btn" value="Modificar" >
                            <input type="submit" name="btn" value="Eliminar">
                        </center>
                    </div>
                </form>
            </div>
        </div>
    </body>
</html>
