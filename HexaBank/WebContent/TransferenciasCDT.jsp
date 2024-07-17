<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.*" %>
<%

ArrayList<Cuenta> cuentasPorTerceros = (ArrayList<Cuenta>) request.getAttribute("Lista_Cuentas_cliente");
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
    <title>Transferencias</title>
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
        .ancho {
            width: 100%;
            max-width: 400px;
        }
    </style>
</head>
<body>
    <jsp:include page="NavBar.jsp"/>
    <div class="flex">
        <div class="w-1/12 bgLeft pt-24"></div>
        <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-24">
            <div class="container mx-auto px-4 py-8" style="overflow-y: auto;  min-height: 600px;">
                <div class="w-2/3 mx-auto">
                    <div class="flex flex-col items-center w-full">
                        <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Transferencias</h2>
                        <br>
                        <form class="flex flex-col items-center w-full" action="ServletTransferenciasCliente" method="post" onsubmit="return confirmacion();">
                        <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="CuentaOrigen">CBU de Origen:</label>
                                <div class="relative">
                                     <select id="CuentaOrigen" name="CuentaOrigen" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						                <% if (cuentasPorTerceros != null && !cuentasPorTerceros.isEmpty()) { %>
						                    <% for (Cuenta cuenta : cuentasPorTerceros) { %>
						                        <option value="<%= cuenta.getCbu() %>"> <%= cuenta.getCbu() %></option>
						                    <% } %>
						                <% } else { %>
						                    <option value="">No tiene cuentas disponibles</option>
						                <% } %>
						            </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                            <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>

                            <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="CuentaDestino">CBU de Destino:</label>
                                <input type="number" required id="CuentaDestino" max="9999999999999999999999" name="CuentaDestino" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="detalleTransferencia2">Detalle:</label>
                                <input type="text" required minlength="3" maxlength="150" id="detalleTransferencia2" name="detalleTransferencia2" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="importe">Importe:</label>
                                <input required type="number" max="9999999999" step="any" min="1"   type="number" id="importe" name="importe" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div class="flex flex-col items-center w-full">
                                <button type="submit" name="btnTransferir2" class="form-control mx-auto mt-16 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Transferir</button>
                            </div>
                        </form>
                    </div>
                       <br>
                       <div class="flex justify-end w-full mt-4">
                        <a href="TransferenciasCliente.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Atrás</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="w-1/12 bgRight pt-24"></div>
            <script>
	$(document).ready(function() {
	    $('#tablaCuentas').DataTable();
	});
	
	
	   function confirmacion() {  
	        return confirm('¿Desea realizar la transferencia?'); 
	        if (confirmacion) {
	            return true; 
	        } else {
	            return false; 
	        }
	    }
	    
	</script>
    </div>
    <jsp:include page="Footer.jsp"/>
</body>
</html>
