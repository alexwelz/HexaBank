<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="entidad.Cliente" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Localidad" %>
<%@ page import="entidad.Provincia" %>
<%@ page import="entidad.Pais" %>
<%       

       Cliente auxCliente =  (Cliente) request.getAttribute("ClienteDetalle");
       ArrayList<Localidad> localidades =(ArrayList<Localidad>) request.getAttribute("Lista_Localidades");
       ArrayList<Provincia> provincias =  (ArrayList<Provincia>) request.getAttribute("Lista_Provincias");
       ArrayList<Pais> paises = (ArrayList<Pais>) request.getAttribute("Lista_Paises");
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
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Cliente</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>  
        .bgLeft {
           background: linear-gradient(45deg, mediumslateblue,  blueviolet, darkviolet, darkviolet,blueviolet, mediumslateblue);
            background-size: cover;           
        }
        .bgRight {
            background: linear-gradient(45deg, mediumslateblue,  blueviolet, darkviolet, darkviolet,blueviolet, mediumslateblue);
            background-size: cover;
        }
    </style>
         <script>

    function validarFormulario2() {
        const contrasena = document.getElementById('contrasena').value;
        const confirmarContrasena = document.getElementById('ConfirmarContrasena').value;
        const dniInput = document.getElementById('dni');
        const dniValue = dniInput.value.trim();
        const cuilInput = document.getElementById('cuil');
        const cuilValue = cuilInput.value.trim();
        const telefonoInput = document.getElementById('telefonos');
        const telefonoValue = telefonoInput.value.trim();
        
        const nombreInput = document.getElementById('nombre');
        const nombreValue = nombreInput.value.trim();
        const apellidoInput = document.getElementById('apellido');
        const apellidoValue = apellidoInput.value.trim();

        const textoValido = /^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$/;
        
        if (contrasena !== confirmarContrasena) {
            alert('Las contraseñas no coinciden.');
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
        
        
        var confirmacion = confirm('¿Guardar los cambios del cliente?');
        if (confirmacion) {
            return true; 
        } else {
            return false; 
        }
     
    }
</script>
  
</head>

 <body>
<jsp:include page="NavBar.jsp"/>

   

<div class="flex">
 <div class="w-1/12 bgLeft"></div>
   <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-24">
   
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
   

<div class="container mx-auto px-4 py-8">
    <div class="w-2/3  mx-auto">
        <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Modificar Cliente</h2>
        <br>
        <form action="ServletAdminCliente" method="post" onsubmit="return validarFormulario2();">
            <div class="grid grid-cols-1 md:grid-cols-2 gap-4">

                <div class="col-span-1 md:col-span-2 border-b pb-4">
                    <h3 class="text-lg font-medium title-font mb-2 text-gray-700">Datos Personales</h3>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="nombre">Nombre:</label>
                    <input required type="text" id="nombre" name="nombre" maxlength="100" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getNombre() %>"  >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="apellido">Apellido:</label>
                    <input required type="text" id="apellido" maxlength="100" name="apellido" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getApellido() %>"  >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="dni">DNI:</label>
                    <input readonly required type="number" id="dni" name="dni" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getDni() %>"  >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="cuil">CUIL:</label>
                    <input required type="number" id="cuil" name="cuil" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getCuil()%>"  >
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
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="nacionalidad">Nacionalidad:</label>
                    <div class="relative">
                        <select id="nacionalidad" name="nacionalidad" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <% for (Pais pais: paises){ %>
								<% if (pais.getNombre().equals(auxCliente.getNacionalidad())){%>
                            		 <option selected value=<%= pais.getPaisId() %>><%= pais.getNombre() %></option> 
                            	<% } else { %>
                            		 <option value=<%= pais.getPaisId() %>><%= pais.getNombre() %></option>                       	
                            	<% } %>
                            <%} %>
                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" /></svg>
                        </div>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="fecha-nacimiento">Fecha de Nacimiento:</label>
                    <input required type="date" max="2006-01-01" min="1930-01-01" id="fecha-nacimiento" name="fecha-nacimiento" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getFechaNacimiento()%>"  >
                </div>              
                <div class="col-span-1 md:col-span-2 border-b pb-4 mt-4">
                    <h3 class="text-lg font-medium title-font mb-2 text-gray-700">Datos de Contacto</h3>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="direccion">Dirección:</label>
                    <input required type="text" id="direccion" maxlength="100" name="direccion" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getDireccion()%>"  >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="localidad">Localidad:</label>
                    <div class="relative">
                        <select id="localidad" name="localidad" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <% for (Localidad localidad: localidades){ %>
								<% if (localidad.getLocalidadId() ==  auxCliente.getLocalidad().getLocalidadId()){%>
                            		 <option selected value=<%= localidad.getLocalidadId() %>><%= localidad.getNombre() %></option> 
                            	<% } else { %>
                            		 <option value=<%= localidad.getLocalidadId() %>><%= localidad.getNombre() %></option>                         	
                            	<% } %>
                            <%} %>
                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" /></svg>
                        </div>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="provincia">Provincia:</label>
                    <div class="relative">
                        <select id="provincia" name="provincia" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            <% for (Provincia provincia: provincias){ %>
                            	<% if (provincia.getProvinciaId() ==  auxCliente.getLocalidad().getProvincia().getProvinciaId()){%>
                            		<option value=<%= provincia.getProvinciaId() %> selected><%= provincia.getNombre() %></option>  
                            	<% } else { %>
                            		<option value=<%= provincia.getProvinciaId() %>><%= provincia.getNombre() %></option>                            	
                            	<% } %>
                            <%} %>
                        </select>
                        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" /></svg>
                        </div>
                    </div>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="telefonos">Teléfono:</label>
                    <input required type="number" id="telefonos" name="telefonos" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getTelefono()%>"  >
                </div> 
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="telefonos">Email:</label>
                    <input required type="Email" id="Email" maxlength="100" name="Email" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getCorreo()%>"  >
                </div>     
                <div class="col-span-1 md:col-span-2 border-b pb-4 mt-4">
                    <h3 class="text-lg font-medium title-font mb-2 text-gray-700">Datos de la Cuenta</h3>
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="nombre-usuario">Nombre de Usuario:</label>
                    <input readonly type="text" id="nombre-usuario" name="nombre-usuario" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getUsuario().getNombreUsuario()%>"  >
                </div>
                <div class="mb-4">
                    <label class="block text-gray-700 text-sm font-bold mb-2" for="contrasena">Contraseña:</label>
                    <input required type="password" maxlength="15"  minlength="8" id="contrasena" name="contrasena" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCliente.getUsuario().getPassword()%>"  >
                </div>  
                <div class="mb-4">
                      <label class="block text-gray-700 text-sm font-bold mb-2" for="ConfirmarContrasena">Confirmar contraseña:</label>
                      <input required type="password" maxlength="15"  minlength="8" id="ConfirmarContrasena" name="ConfirmarContrasena" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required value="<%=auxCliente.getUsuario().getPassword()%>" >
                </div>         
            </div>           
			<div class="mb-4">

				<button type="submit" id="btnGuardarCambios" name="btnGuardarCambios" value="guardarCambios" class="flex mx-auto mt-6 text-white bg-purple-500 border-0 py-2 px-5 focus:outline-none hover:bg-purple-600 rounded">Guardar cambios</button>
			</div>
          
           </div>
           </form>
              <br>
           <div class="flex justify-end w-full mt-4">
                        <a href="MenuAdmin.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Volver al menú</a>
                    </div>
    </div>
</div>

    <div class="w-1/12 bgRight"></div>

</div>


 <jsp:include page="Footer.jsp" />

 
     

</body>
</html>