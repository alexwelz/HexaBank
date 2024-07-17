<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cliente" %>
 <%
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
    <title>Administrador Clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.js"></script>
    <link rel="icon" type="image/png" href="Images/logo.png">
</head>
<body>

    <jsp:include page="NavBar.jsp" />
    
    <div class="bg-white pt-24">
    
    <div class="container mx-auto px-4 py-8" style="width: 80%; overflow-y: auto;  min-height: 600px;">

        <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900" style="margin-top:3%;">Administrador de clientes</h2>
            <br>
             <br>
        
            <%
            ArrayList<Cliente> listaClientes = new ArrayList<Cliente>();  
            listaClientes = (ArrayList<Cliente>) request.getAttribute("Lista_Clientes");
            %>
            
                <table id="tablaClientes" class="display compact">
                    <thead>
                        <tr>
                            <th>Nombre</th>
                            <th>Apellido</th>
                            <th>DNI</th>
                            <th>Sexo</th>
                            <th>Nacionalidad</th>
                            <th>Detalle</th>
                            <th>Modificar</th>
                            <th>Eliminar</th>
                        </tr>
                    </thead>
                    <tbody>
                 
                        <% if (listaClientes != null && !listaClientes.isEmpty()) { %>
                            <% for (Cliente cliente : listaClientes) { %>
                                <tr>
                                    <td style="text-align: center"><%= cliente.getNombre() %></td>
                                    <td style="text-align: center"><%= cliente.getApellido() %></td>
                                    <td style="text-align: center"><%= cliente.getDni() %></td>
                                    <td style="text-align: center"><%= cliente.getSexo() %></td>
                                    <td style="text-align: center"><%= cliente.getNacionalidad() %></td> 
                                    <form action="ServletAdminCliente" method="get" >                              
                                    <td>  
                                       <input type="hidden" name="dni" value="<%= cliente.getDni() %>">
                                       <button type="submit" name="btnDetalle" value="detalle" class="flex mx-auto mt-6 text-white bg-purple-500 border-0 py-2 px-5 focus:outline-none hover:bg-purple-600 rounded">Detalle</button>                             
                                    </td>                                                            
                                    <td>
                                        
                                        <button type="submit" name="btnModificar" value="modificar" class="flex mx-auto mt-6 text-white bg-purple-500 border-0 py-2 px-5 focus:outline-none hover:bg-purple-600 rounded">Modificar</button>
                                    </td>
                                    </form >
                                     <form action="ServletAdminCliente" method="get" onsubmit="return confirmacion();" >
                                    <td>
                                        <input type="hidden" name="dni" value="<%= cliente.getDni() %>">
                                        <button type="submit" name="btnEliminar" value="eliminar" class="flex mx-auto mt-6 text-white bg-red-500 border-0 py-2 px-5 focus:outline-none hover:bg-red-600 rounded">Eliminar</button>
                                    </td>
                                    </form >

                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="8" style="text-align: center">No hay clientes disponibles</td>
                            </tr>
                        <% } %>
                         
                    </tbody>
                </table>
                      <br>
                    <div class="flex justify-end w-full mt-4">
                        <a href="MenuAdmin.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Volver al menú</a>
                    </div>
    </div>
    
    <script>
    $(document).ready(function() {
        $('#tablaClientes').DataTable();
    });

    function confirmacion() {  
        return confirm('¿Desea eliminar al cliente?'); 
        if (confirmacion) {
            return true; 
        } else {
            return false; 
        }
    }
    

</script>
  
    
    </div>
    
    <jsp:include page="Footer.jsp" />

</body>
</html>

