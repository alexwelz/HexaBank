<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="entidad.Prestamo" %>
<%@ page import="entidad.Cuota" %>
<%@ page import="entidad.Cuenta" %>
<%
    ArrayList<Prestamo> prestamos = null;
    prestamos = (ArrayList<Prestamo>)request.getAttribute("listaPrestamos");
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
    <title>Pago Préstamos</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
</head>
<body>

<jsp:include page="NavBar.jsp" />
<div class="flex">
    <div class="w-1/12 bgLeft pt-24"></div>
    <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-5">
        <div class="bg-white pt-5">
            <div class="container mx-auto px-4 py-4" style="width: 100%; overflow-y: auto;  min-height: 600px;">
                <section class="text-gray-600 body-font">
                    <div class="container px-5 py-24 mx-auto">
                        <div class="flex flex-col text-center w-full mb-6">
                            <h1 class="sm:text-4xl text-3xl font-medium title-font mb-2 text-gray-900">Pago Préstamos</h1>
                           <% if (prestamos == null || prestamos.isEmpty()) { %>
                                <h1 >No hay pagos disponibles</h1>
                            <% } else { %>
                            <p class="lg:w-2/3 mx-auto leading-relaxed text-base">Ingrese en el préstamo que desea pagar.</p>
                        </div>
                        <div class="lg:w-3/4 w-full mx-auto overflow-auto">                
                                <div class="shadow-md">
                                    <% for (Prestamo prestamo : prestamos) { %>
                                    <div class="border-t-2 border-gray-200">
                                        <button class="w-full px-4 py-2 text-left focus:outline-none focus:bg-gray-200" onclick="toggleSection('section<%= prestamo.getPrestamoId() %>')">Id Préstamo: <%= prestamo.getPrestamoId() %></button>
                                        <div id="section<%= prestamo.getPrestamoId() %>" class="hidden px-4 py-2">
                                            <section class="text-gray-600 body-font">
                                                <div class="container px-5 py-5 mx-auto">   
                                                 <form id="prestamoForm" class="flex flex-col items-center w-full" action="ServletPagoPrestamos" method="post" onsubmit="return confirmacion();">   
                                                 <div class="mb-4" style="width: 100%">
                                <label class="block text-gray-700 text-sm font-bold mb-2" for="CuentaOrigen">Cuenta a debitar</label>
                                <div class="relative">
                                     <select id="CuentaOrigen" name="CuentaOrigen" class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
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
                                                   <div class="flex flex-col text-center w-full mb-10">
                                                        <p class="lg:w-2/3 mx-auto leading-relaxed text-base">Seleccione la cuota que desea pagar:</p>
                                                    </div>
                                                    <div class="lg:w-2/3 w-full mx-auto overflow-auto">
                                                        <table class="table-auto w-full text-left whitespace-no-wrap">
                                                            <thead>
                                                                <tr>
                                                                    <th class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100 rounded-tl rounded-bl">ID cuota</th>
                                                                    <th class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100">N° de Cuota</th>
                                                                    <th class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100">Fecha Vencimiento</th>
                                                                    <th class="px-4 py-3 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100">Importe</th>
                                                                    <th class="w-10 title-font tracking-wider font-medium text-gray-900 text-sm bg-gray-100 rounded-tr rounded-br"></th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (Cuota cuota : prestamo.getCuotas()) { %>
                                                                <tr>
                                                                    <td class="px-4 py-3"><%= cuota.getCuotaId() %></td>
                                                                    <td class="px-4 py-3"><%= cuota.getNumeroCuota() %></td>
                                                                    <td class="px-4 py-3"><%= cuota.getFechaVencimiento() %></td>
                                                                    <td class="px-4 py-3">$<%= cuota.getImporte() %></td>
                                                                    <td class="w-10 text-center">
                                                                        <input type="hidden" name="nroCuota" id="nroCuota"  value="<%= cuota.getNumeroCuota()  %>">
                                                                        <input required name="idCuota" id="idCuota" type="radio" value="<%= cuota.getCuotaId() %>">

                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                     <input type="hidden" name="prestamoId" id="prestamoId"  value="<%= prestamo.getPrestamoId() %>">
                                                    
                                                    <div class="flex pl-4 mt-4 lg:w-2/3 w-full mx-auto">
                                                        <button type="submit" name="btnPagarCuota" class="flex ml-auto text-white bg-purple-500 border-0 py-2 px-6 focus:outline-none hover:bg-purple-600 rounded">Pagar</button>
                                                    </div>
                                                  </form>
                                                </div>
                                            </section>
                                        </div>
                                    </div>
                                    <% } %>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </section>
                   <br>
                <div class="flex justify-end w-full mt-4">
                        <a href="MenuCliente.jsp" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Volver al menú</a>
                </div>
          </div>
        </div>
    </div>
    <div class="w-1/12 bgRight pt-24"></div>
</div>

<jsp:include page="Footer.jsp" />

<script>
    function toggleSection(sectionId) {
        const section = document.getElementById(sectionId);
        section.classList.toggle('hidden');
    }
    function confirmacion() {
        return confirm("¿Está seguro que desea pagar esta cuota?");
        if (confirmacion) {
            return true; 
        } else {
            return false; 
        }
    }
</script>

</body>
</html>
