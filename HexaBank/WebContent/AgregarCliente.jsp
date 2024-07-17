<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.*" %>
<% 
	ArrayList<Pais> lista_Paises = (ArrayList<Pais>) request.getAttribute("Lista_Paises");
	ArrayList<Localidad> lista_Localidades =(ArrayList<Localidad>) request.getAttribute("Lista_Localidades");
	ArrayList<Provincia> lista_Provincias  = (ArrayList<Provincia>) request.getAttribute("Lista_Provincias");
	
	   
	String respuesta = null;
	if(session != null && session.getAttribute("respuesta") != null){
	respuesta = (String)session.getAttribute("respuesta");
	session.removeAttribute("respuesta");
	%>
	<script> 
	  alert('<%= respuesta%>');
	</script>   
	<%
	respuesta = null;}
%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .bgLeft {
            background: linear-gradient(45deg, mediumslateblue, blueviolet, darkviolet, darkviolet, blueviolet, mediumslateblue);
            background-size: cover;
        }
        .bgRight {
            background: linear-gradient(45deg, mediumslateblue, blueviolet, darkviolet, darkviolet, blueviolet, mediumslateblue);
            background-size: cover;
        }
    </style>
    
     <script>

    function validarFormulario(event) {
        const contrasena = document.getElementById('contrasena').value;
        const confirmarContrasena = document.getElementById('ConfirmarContrasena').value;
        const dniInput = document.getElementById('dni');
        const dniValue = dniInput.value.trim();
        const cuilInput = document.getElementById('cuil');
        const cuilValue = cuilInput.value.trim();
        const telefonoInput = document.getElementById('telefono');
        const telefonoValue = telefonoInput.value.trim();

        
        const nombreInput = document.getElementById('nombre');
        const nombreValue = nombreInput.value.trim();
        const usuarioInput = document.getElementById('usuario').value;
        const apellidoInput = document.getElementById('apellido');
        const apellidoValue = apellidoInput.value.trim();

        const textoValido = /^[a-zA-Z\s]+$/;
        const textoValidoUsuario = /^[a-zA-Z0-9]+$/;
        
        if (contrasena !== confirmarContrasena) {
            alert('Las contraseñas no coinciden.');
            return false; 
        }
        
        if (!textoValidoUsuario.test(usuarioInput) || usuarioInput === '') {
            alert('Usuario incorrecto. El usuario no debe contener espacios.');
            usuarioInput.focus();
            event.preventDefault();
            return false;
        }
        
        if (!textoValido.test(nombreValue) || nombreValue === '') {
            alert('Nombre incorrecto. El nombre no debe contener números ni estar vacío.');
            nombreInput.focus();
            event.preventDefault();
            return false;
        }

        if (!textoValido.test(apellidoValue) || apellidoValue === '') {
            alert('Apellido incorrecto. El apellido no debe contener números ni estar vacío.');
            apellidoInput.focus();
            event.preventDefault();
            return false;
        }
        
        if (dniValue.length !== 8) {
            alert('DNI incorrecto. El DNI debe contener 8 números.');
            dniInput.focus();
            event.preventDefault(); 
            return false;
        }
        
        if (cuilValue.length !== 11) {
            alert('CUIL incorrecto. El CUIL debe ingresarse sin guiones y debe contener exactamente 11 números.');
            cuilInput.focus(); 
            event.preventDefault(); 
            return false;
        }
        
        
        if (telefonoValue.length > 15 || telefonoValue.length < 8) {
            alert('Telefono incorrecto. El telefono ingresado debe contener de 8 a 15 dígitos.');
            telefonoInput.focus(); 
            event.preventDefault(); 
            return false;
        }
        
        
        const confirmacion = confirm('¿Desea agregar el cliente?');
        if (confirmacion) {
            return true; 
        } else {
        	event.preventDefault();
            return false; 
        }
     
    }
</script>
  
</head>
<body>
    <jsp:include page="NavBar.jsp"/>
    <div class="flex">
        <div class="w-1/12 bgLeft pt-24"></div>
        <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-24">
            <div class="container mx-auto px-4 py-8">
                <div class="w-2/3 mx-auto">
                    <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Nuevo Cliente</h2>
                    <br>
                    <form action="ServletAdminCliente" method="post" onsubmit="return validarFormulario(event);">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="col-span-1 md:col-span-2 border-b pb-4">
                                <h3 class="text-lg font-medium title-font mb-2 text-gray-700">Datos Personales</h3>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="nombre">Nombre:</label>
                                <input type="text" id="nombre" name="nombre" maxlength="100" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="apellido">Apellido:</label>
                                <input type="text" id="apellido" name="apellido" maxlength="100" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="dni">DNI:</label>
                                <input type="number" id="dni" name="dni" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"  required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="cuil">CUIL:</label>
                                <input type="number" id="cuil" name="cuil" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" maxlength="13" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="sexo">Sexo:</label>
                                <div class="relative">
                                    <select id="sexo" name="sexo" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                                        <option value="M">M</option>
                                        <option value="F">F</option>
                                        <option value="X">X</option>         
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                            <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>                      
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="nacionalidad1">Nacionalidad:</label>
                                <div class="relative">
                                    <select id="nacionalidad1" name="nacionalidad1" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                                        <% 
                                        if (lista_Paises == null) { %>
                                            <option value="no_items">no items</option>
                                        <% } else {
                                            for (Pais pais : lista_Paises) { %>
                                                <option value="<%= pais.getPaisId() %>"><%= pais.getNombre() %></option>
                                            <% }
                                        } %>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                            <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="fecha-nacimiento">Fecha de Nacimiento:</label>
                                <input type="date" max="2006-01-01" min="1930-01-01" id="fecha-nacimiento" name="fechanacimiento" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required max="2005-01-01">
                            </div>
                            <div class="col-span-1 md:col-span-2 border-b pb-4 mt-4">
                                <h3 class="text-lg font-medium title-font mb-2 text-gray-700">Datos de Contacto</h3>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="direccion">Dirección:</label>
                                <input type="text" id="direccion" maxlength="100" name="direccion" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="localidad">Localidad:</label>
                                <div class="relative">                              
                                    <select id="localidad" name="localidad" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                                        <% 
                                        if (lista_Localidades == null) { %>
                                            <option value="no_items">no items</option>
                                        <% } else {
                                            for (Localidad localidad : lista_Localidades) { %>
                                                <option value="<%= localidad.getLocalidadId() %>"><%= localidad.getNombre() %></option>
                                            <% }
                                        } %>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                            <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="provincia">Provincia:</label>
                                <div class="relative">
                                    <select id="provincia" name="provincia" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                                        <% 
                                        if (lista_Provincias == null) { %>
                                            <option value="no_items">no items</option>
                                        <% } else {
                                            for (Provincia provincia : lista_Provincias) { %>
                                                <option value="<%= provincia.getProvinciaId() %>"><%= provincia.getNombre() %></option>
                                            <% }
                                        } %>
                                    </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                            <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="telefono">Teléfono:</label>
                                <input type="number" id="telefono" name="telefono" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="email">Email:</label>
                                <input type="email" id="email" maxlength="100" name="email" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div> 
                            <div class="col-span-1 md:col-span-2 border-b pb-4 mt-4">
                                <h3 class="text-lg font-medium title-font mb-2 text-gray-700">Datos de la Cuenta</h3>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="usuario">Nombre de Usuario:</label>
                                <input type="text" id="usuario" maxlength="15" name="usuario" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="contrasena">Contraseña:</label>
                                <input type="password" id="contrasena" maxlength="15"  minlength="8" name="contrasena" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>      
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="ConfirmarContrasena">Confirmar contraseña:</label>
                                <input type="password" id="ConfirmarContrasena" maxlength="15" minlength="8" name="ConfirmarContrasena" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>     
                        </div>
                        
                        <button type="submit" id="btnAgregarClienteNuevo" name="btnAgregarClienteNuevo" value="AgregarClienteNuevo" class="flex mx-auto mt-16 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Agregar</button>
                    </form>   
                    <%
                    String message = (String) request.getAttribute("message");
                    if (message != null) {
                    %>
                        <script>
                            alert('<%= message %>');
                        </script>
                    <%
                    }
                    %>
                       <br>
                    <div class="flex justify-end w-full mt-4">
                        <a href="MenuAdmin.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Volver al menú</a>
                    </div>
                </div>
            </div>
   
    </div> 
        <div class="w-1/12 bgRight pt-24"></div>
    </div>
    
    <jsp:include page="Footer.jsp" />
    
 
    
 
</body>
</html>

