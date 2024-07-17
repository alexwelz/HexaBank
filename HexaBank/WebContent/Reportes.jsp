<!DOCTYPE html>
<% 
    String MostrarForm = (String) request.getAttribute("MostrarForm");
    String textAreaReporte = (String) request.getAttribute("textAreaReporte");
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


<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">  
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reportes</title>
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
        .textAreaReporte{
              overflow: auto;
        }
    </style>
    <script>

	    function confirmacion() {  
	        return confirm('¿Desea realizar el reporte?'); 
	        if (confirmacion) {
	            return true; 
	        } else {
	            return false; 
	        }
	    }
	    
	    function confirmacionDescarga() {  
	        return confirm('¿Desea descargar el reporte?'); 
	        if (confirmacionDescarga) {
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
        <div class="w-1/12 bgLeft pt-24"></div>
        <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-24">
            <div class="container mx-auto px-4 py-8">
                <div class="w-2/3 mx-auto">
                    <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Reportes Prestamos</h2>
                    <br>
                     <%
                    if (MostrarForm == "MostrarForm") {
                    %>
                    <form action="ServletReportes" method="post" onsubmit="return confirmacion();">
                        <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="fechaInicio">Fecha de Inicio:</label>
                                <input type="date" id="fechaInicio" name="fechaInicio" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>
                            <div class="mb-4">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="fechaFin">Fecha de Fin:</label>
                                <input type="date" id="fechaFin" name="fechaFin" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                            </div>
                            <div class="mb-4">
                                <div class="relative">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="estado">Estado del Prestamo:</label>
                                <select id="estado" name="estado" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                                    <option value="Autorizado">Autorizado</option>
                                    <option value="Rechazado">Rechazado</option>
                                    <option value="En proceso">En proceso</option>
                                </select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
								        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20"><path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" /></svg>
								    </div>
								</div> 
                            </div>
                            <div class="mb-4">
                   <label class="block text-gray-700 text-sm font-bold mb-2" for="importe">Importe:</label>
                      <div class="flex items-center space-x-2">
                          <label class="text-gray-700 text-sm font-bold" for="importeEntre">Entre:</label>
                                  <select id="importeMin" name="importeMin" class="shadow appearance-none border rounded w-1/2 py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                                        <option value="500000" >500000.00</option>
									    <option value="1000000" >1000000.00</option>
									    <option value="1500000" >1500000.00</option>
									    <option value="2000000" >2000000.00</option>
									    <option value="2500000" >2500000.00</option>
                                 </select>
                             <label class="text-gray-700 text-sm font-bold" for="importeY">y</label>
                                 <select id="importeMax" name="importeMax" class="shadow appearance-none border rounded w-1/2 py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" required>
                                        <option value="500000" >500000.00</option>
									    <option value="1000000" >1000000.00</option>
									    <option value="1500000" >1500000.00</option>
									    <option value="2000000" >2000000.00</option>
									    <option value="2500000" >2500000.00</option>
                                </select>
                             <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                          <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                             <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 011.414 1.414l-4 4a1 1 01-1.414 0l-4-4a1 1 010-1.414z" />
                            </svg>
                            </div>
                       </div>
                       </div>
              
                        </div>
                           <div class="mb-4">
                              <label class="block text-gray-700 text-sm font-bold mb-2" for="DNIclienteReporte">Dni Cliente:</label>
                              <input type="text" id="DNIclienteReporte" minlength= "8" maxlength = "8" name="DNIclienteReporte" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                        <button type="submit" name="btnGenerarReporte" class="flex mx-auto mt-16 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Generar Reporte</button>
                    </form>
                    
                     <%
                    }
                    %>
                    <%
                    if (MostrarForm != "MostrarForm") {
                    %>
                    <form action="ServletReportes" method="post" onsubmit="return confirmacionDescarga();">       
	                    <div class="mb-4">
			               <label class="block text-gray-700 text-sm font-bold mb-2" for="textoExtenso">Texto Extenso:</label>
			                <textarea id="textAreaReporte" name="textAreaReporte" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" rows="30" cols="8"><%= textAreaReporte %></textarea>
			            </div>	
	                    <input type="hidden" name="reporte" value="<%= textAreaReporte %>">
	                    <button type="submit" id ="btnDescargar" name="btnDescargar" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Descargar Reporte</button>
                            </form>
                          <form action="ServletReportes" method="post"> 
                          <div class="flex justify-end w-full mt-4">
                            <button  id="btnAtras" name="btnAtras" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Atrás</button>
                        </div>
              
                    </form>
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
