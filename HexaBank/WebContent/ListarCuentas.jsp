<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cuenta" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
	ArrayList<Cuenta> listaCuentas = new ArrayList<Cuenta>();  
	listaCuentas = (ArrayList<Cuenta>) request.getAttribute("Lista_Cuentas");
	DecimalFormat formato = new DecimalFormat("#0.00");
	String saldoFormateado;  
%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Administrador Cuentas</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.4/css/jquery.dataTables.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" charset="utf8" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.js"></script>
    <link rel="icon" type="image/png" href="Images/logo.png">
</head>
<body>

	<jsp:include page="NavBar.jsp" />
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

	<jsp:include page="NavBar.jsp" />
	<div class="bg-white pt-24">
	
	<div class="container mx-auto px-4 py-8" style="width: 80%; overflow-y: auto;  min-height: 600px;">
	      
	    <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900" style="margin-top:3%;">Admistrador de cuentas</h2>
	        <br>
	         <br>
	    <table id="tablaCuentas" class="display compact">
	
	        <thead>
	            <tr>  
	                <th>Cliente</th>
	                <th>Fecha de creación</th>
	                <th>Tipo de Cuenta</th>
	                <th>N° de Cuenta</th>
	                <th>CBU</th>
	                <th>Saldo</th>
	                <th>Modificar</th>
	                <th>Eliminar</th>
	            </tr>
	        </thead>
	        <tbody>
	             <% if (listaCuentas != null && !listaCuentas.isEmpty()) { %>
                            <% for (Cuenta cuenta : listaCuentas) { 
                                    saldoFormateado = formato.format(cuenta.getSaldo()); %>
                                <tr>
                                    <td style="text-align: center"><%= cuenta.getCliente().getNombre() %> <%= cuenta.getCliente().getApellido() %></td>
                                    <td style="text-align: center"><%= cuenta.getFechaCreacion() %></td>
                                    <td style="text-align: center"><%= cuenta.getTipoCuenta() %></td>
                                    <td style="text-align: center"><%= cuenta.getNumeroCuenta() %></td>
                                    <td style="text-align: center"><%= cuenta.getCbu() %></td> 
                                    <td style="text-align: center"> $<%= saldoFormateado %></td>                                                        
                                    <td>
                                    <form action="ServletAdminCuentas" method="get">     
                                        <input type="hidden" name="nroCuenta" value="<%= cuenta.getNumeroCuenta() %>">   
                                        <button type="submit" name="btnModificar" value="modificar" class="flex mx-auto mt-6 text-white bg-purple-500 border-0 py-2 px-5 focus:outline-none hover:bg-purple-600 rounded">Modificar</button>
                                   </form >
                                   </td>
                                   <td> 
                                   <form action="ServletAdminCuentas" method="get" onsubmit="return confirmacion();">
                                        <input type="hidden" name="nroCuenta" value="<%= cuenta.getNumeroCuenta() %>">
                                        <button type="submit" name="btnEliminar" value="eliminar" class="flex mx-auto mt-6 text-white bg-red-500 border-0 py-2 px-5 focus:outline-none hover:bg-red-600 rounded">Eliminar</button>
                                   </form >     
                                   </td>
                                </tr>
                            <% } %>
                        <% } else { %>
                            <tr>
                                <td colspan="8" style="text-align: center">No hay cuentas disponibles</td>
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
	    $('#tablaCuentas').DataTable();
	});
	
	   function confirmacion() {  
	        return confirm('¿Desea eliminar la cuenta?'); 
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

