<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Agregar Cuenta</title>
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
			<div class="container mx-auto px-4 py-8" style="width: 80%; overflow-y: auto;  min-height: 400px;">
			    <div class="w-2/3  mx-auto">
			       <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Nueva Cuenta</h2>
			       <br>
			       <form action="ServletAdminCuentas" method="post" onsubmit = " validarFormulario(event)">
					    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
					        <div class="mb-4">
					            <label class="block text-gray-700 text-sm font-bold mb-2" for="dni">DNI Cliente:</label>
					            <input type="text" id="dni" name="dni" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
					        </div>
					        <div class="mb-4">
					            <label class="block text-gray-700 text-sm font-bold mb-2" for="tipoCuenta">Tipo de Cuenta</label>				              
					            <div class="relative">
								    <select id="tipoCuenta" name="tipoCuenta" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
								        
								        <option value="caja de ahorro">caja de ahorro</option>
								        <option value="cuenta corriente">cuenta corriente</option>
								    </select>
								    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
								        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" /></svg>
								    </div>
								</div>       
					        </div>                           
					    </div>
					    <button type="submit" id = "btnAgregarNuevaCuenta" name="btnAgregarNuevaCuenta" value = "AgregarNuevaCuenta"   class="flex mx-auto mt-16 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Agregar</button>
					</form>
					   <br>
                       <div class="flex justify-end w-full mt-4">
                        <a href="MenuAdmin.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Volver al menú</a>
                    </div>
			        </div>
			    </div>
	    </div>
	     
	    <div class="w-1/12 bgRight pt-24"></div>
	    
	     <script>
	
	    	function validarFormulario(event) {
	        const dniInput = document.getElementById('dni');
	        const dniValue = dniInput.value.trim();      
	        
	        if (dniValue.length !== 8) {
	            alert('DNI incorrecto. El DNI debe contener 8 números.');
	            dniInput.focus();
	            event.preventDefault(); 
	            return false;
	        }
	        
	        const confirmacion = confirm('¿Desea agregar la cuenta?');
	        if (confirmacion) {
	            return true; 
	        } else {
	        	event.preventDefault();
	            return false; 
	        }
	     
	    }
	</script>
	    </div>
	 
	 <jsp:include page="Footer.jsp" />
	 
</body>
</html>