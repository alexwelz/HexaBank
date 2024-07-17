<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cuenta" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="javax.servlet.http.HttpSession" %>

<%        Cuenta auxCuenta = new Cuenta(); 
          auxCuenta = (Cuenta) request.getAttribute("cuenta");
          DecimalFormat formato = new DecimalFormat("#0.0");
          String saldoFormateado = formato.format(auxCuenta.getSaldo());

%>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modificar Cuenta</title>
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
</head>
 <body>
    <jsp:include page="NavBar.jsp"/>
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
	<div class="flex">
	 <div class="w-1/12 bgLeft pt-24"></div>
	   <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-24">
			<div class="container mx-auto px-4 py-8">
			    <div class="w-2/3  mx-auto">
			       <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Cuenta N° <%=auxCuenta.getNumeroCuenta() %></h2>
			       <br>
			       <form action="ServletAdminCuentas" method="post" onsubmit="return validarFormulario();">
					    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
					        <div class="mb-4">
					            <label class="block text-gray-700 text-sm font-bold mb-2" for="nombre">Nombre cliente:</label>
					            <input type="text" id="nombre" name="nombre" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCuenta.getCliente().getNombre() %>" readonly>
					        </div>
					        <div class="mb-4">
					            <label class="block text-gray-700 text-sm font-bold mb-2" for="apellido">Apellido cliente:</label>
					            <input type="text" id="apellido" name="apellido" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCuenta.getCliente().getApellido() %>" readonly>
					        </div>
					        <div class="mb-4">
					            <label class="block text-gray-700 text-sm font-bold mb-2" for="dni">DNI Cliente:</label>
					            <input type="text" id="dni" name="dni" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCuenta.getCliente().getDni() %>" readonly>
					        </div>
							<div class="mb-4">
							    <label class="block text-gray-700 text-sm font-bold mb-2" for="tipoCuenta">Tipo de Cuenta</label>
							    <div class="relative">
							        <select id="tipoCuenta" name="tipoCuenta" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
							            <option value="caja de ahorro" <%= "caja de ahorro".equals(auxCuenta.getTipoCuenta()) ? "selected" : "" %>>Caja de Ahorro</option>
							            <option value="cuenta corriente" <%= "cuenta corriente".equals(auxCuenta.getTipoCuenta()) ? "selected" : "" %>>Cuenta Corriente</option>
							        </select>
							        <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
							            <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" /></svg>
							        </div>
							    </div>
							</div>     
					        <div class="mb-4">
					            <label class="block text-gray-700 text-sm font-bold mb-2" for="cbu1">CBU:</label>
					            <input type="text" id="cbu1" name="cbu1" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCuenta.getCbu() %>" readonly>
					        </div>
					          <div class="mb-4">
					            <label class="block text-gray-700 text-sm font-bold mb-2" for="saldo">Saldo:</label>
					            <input required type="number" max="9999999999" min="0" step="any" pattern="[0-9]+([,\.][0-9]+)?" id="saldo" name="saldo" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%=auxCuenta.getSaldo() %>">
					        </div>		        					                             
					    </div>
					    <input type="hidden" name="nroCuenta" value="<%= auxCuenta.getNumeroCuenta() %>">
					    <button type="submit" name="btnModificarCuenta" class="flex mx-auto mt-16 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Guardar Cambios</button>
					</form>
      				
			        </div>
			           <br>
			         <div class="flex justify-end w-full mt-4">
                        <a href="MenuAdmin.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Volver al menú</a>
                    </div>
			    </div>
	    </div>
	    <div class="w-1/12 bgRight pt-24"></div>
	    </div>
	    
	 <script>
	 
	   function validarFormulario() {  
	        return confirm('¿Desea guardar los cambios?'); 
	        if (confirmacion) {
	            return true; 
	        } else {
	            return false; 
	        }
	    }
	    
	</script>
	
	<jsp:include page="Footer.jsp" />
	     

</body>
</html>