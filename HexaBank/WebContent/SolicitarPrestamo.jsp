<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.*" %>
<%

ArrayList<Cuenta> cuentasPorCliente = (ArrayList<Cuenta>) request.getAttribute("Lista_Cuentas_cliente");
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
    <title>Solicitud Prestamo</title>
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
    
    <script type="text/javascript">
        function confirmarEnvio() {
            return confirm("¿Está seguro de que desea solicitar este prestamo?");
        }
    </script>
    <% 
    String montoSeleccionado = request.getParameter("Monto");
    String cuotasSeleccionadas = request.getParameter("Cuotas");
    String interes = request.getParameter("interes");
    String valorCuota = request.getParameter("valorCuota");
    String montoFinal = request.getParameter("montoFinal");
%>
</head>
<body>
    <jsp:include page="NavBar.jsp"/>
    <div class="flex">
        <div class="w-1/12 bgLeft pt-24"></div>
        <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-24">
            <div class="container mx-auto px-4 py-8">
                <div class="w-2/3 mx-auto">
                    <div class="flex flex-col items-center w-full">
                        <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Solicitud de Préstamo</h2>
                        <br>
                        <form id="prestamoForm" class="flex flex-col items-center w-full" action="ServletAdminPrestamos" method="post">
                            <div class="mb-4 ancho ">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="Cuenta de Destino">Cuenta de Destino</label>
                                <div class="relative">
                                              <select id="CuentaDestino" name="CuentaDestino" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
						                <% if (cuentasPorCliente != null && !cuentasPorCliente.isEmpty()) { %>
						                    <% for (Cuenta cuenta : cuentasPorCliente) { %>
						                        <option value="<%= cuenta.getNumeroCuenta() %>">N° <%= cuenta.getNumeroCuenta() %></option>
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
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="Monto">Monto a solicitar</label>
                                <div class="relative">
                                    <select id="Monto" name="Monto" onchange="this.form.submit()" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
									    <option value="500000" <%= "500000".equals(montoSeleccionado) ? "selected" : "" %>>500000.00</option>
									    <option value="1000000" <%= "1000000".equals(montoSeleccionado) ? "selected" : "" %>>1000000.00</option>
									    <option value="1500000" <%= "1500000".equals(montoSeleccionado) ? "selected" : "" %>>1500000.00</option>
									    <option value="2000000" <%= "2000000".equals(montoSeleccionado) ? "selected" : "" %>>2000000.00</option>
									    <option value="2500000" <%= "2500000".equals(montoSeleccionado) ? "selected" : "" %>>2500000.00</option>
									</select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                            <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="Cuotas">Cantidad de cuotas</label>
                                <div class="relative">
                                    <select id="Cuotas" name="Cuotas" onchange="this.form.submit()"  class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
									    <option value="12" <%= "12".equals(cuotasSeleccionadas) ? "selected" : "" %>>12</option>
									    <option value="24" <%= "24".equals(cuotasSeleccionadas) ? "selected" : "" %>>24</option>
									    <option value="36" <%= "36".equals(cuotasSeleccionadas) ? "selected" : "" %>>36</option>
									</select>
                                    <div class="pointer-events-none absolute inset-y-0 right-0 flex items-center px-2 text-gray-700">
                                        <svg class="fill-current h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20">
                                            <path d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" />
                                        </svg>
                                    </div>
                                </div>
                            </div>
                            <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="interes">Interés Anual:</label>
                                <input required type="text" readonly id="interes" name="interes" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%= request.getAttribute("interes") != null ? request.getAttribute("interes") : "" %>">
                            </div>
                            <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="valorCuota">Valor de cuota mensual:</label>
                                <input required type="text" readonly id="valorCuota" name="valorCuota" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%= request.getAttribute("valorCuota") != null ? request.getAttribute("valorCuota") : "" %>">
                            </div>
                            <div class="mb-4 ancho">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="montoFinal">Monto Final :</label>
                                <input required readonly id="montoFinal" name="montoFinal" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline" value="<%= request.getAttribute("montoFinal") != null ? request.getAttribute("montoFinal") : "" %>">
                            </div>
                          
                            <div class="flex flex-col items-center w-full">
                                <button type="submit" onclick="return confirmarEnvio();" id ="btnSolicitar"  name="btnSolicitar" class="form-control mx-auto mt-16 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Solicitar</button>
                            </div>
                        </form>
                    </div>
                          <br>
                       <div class="flex justify-end w-full mt-4">
                        <a href="MenuCliente.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Volver al menú</a>
                    </div>
                </div>
            </div>
        </div>
        <div class="w-1/12 bgRight pt-24"></div>
    </div>
    <jsp:include page="Footer.jsp"/>
</body>
</html>

