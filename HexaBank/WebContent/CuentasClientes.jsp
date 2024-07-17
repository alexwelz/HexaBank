<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.*" %>
<%

ArrayList<Cuenta> cuentasPorCliente = (ArrayList<Cuenta>) request.getAttribute("Lista_Cuentas_cliente");

%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cuentas clientes</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
        .bgLeft {
           background: linear-gradient(45deg, mediumslateblue,  blueviolet, darkviolet, darkviolet, blueviolet, mediumslateblue);
            background-size: cover;
        }
        .bgRight {
            background: linear-gradient(45deg, mediumslateblue,  blueviolet, darkviolet, darkviolet, blueviolet, mediumslateblue);
            background-size: cover;
        }
        .card {
            overflow-wrap: break-word;
            max-width: 100%;
        }
        .cbu-text {
            font-size: 0.875rem; 
        }
    </style>
</head>

<body>
<jsp:include page="NavBar.jsp"/>

<div class="flex">
 <div class="w-1/12 bgLeft"></div>
   <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-20">

<div class="container mx-auto px-4 py-8" style="overflow-y: auto;  min-height: 600px;">
    <div class="w-2/3 mx-auto">
            <section class="text-gray-600 body-font">
            <br>
             <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Cuentas</h2>
             <br>
              <div class="container px-5 py-15 mx-auto">
                <div class="flex flex-wrap -m-4">
                    <% for (Cuenta cuenta : cuentasPorCliente) { %>
                    <div class="xl:w-1/3 md:w-1/2 p-4">
                        <div class="border border-gray-200 p-6 rounded-lg card">
                            <div class="w-10 h-10 inline-flex items-center justify-center rounded-full bg-purple-100 text-purple-500 mb-4">
                                <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="size-6">
                                    <path stroke-linecap="round" stroke-linejoin="round" d="M2.25 18.75a60.07 60.07 0 0 1 15.797 2.101c.727.198 1.453-.342 1.453-1.096V18.75M3.75 4.5v.75A.75.75 0 0 1 3 6h-.75m0 0v-.375c0-.621.504-1.125 1.125-1.125H20.25M2.25 6v9m18-10.5v.75c0 .414.336.75.75.75h.75m-1.5-1.5h.375c.621 0 1.125.504 1.125 1.125v9.75c0 .621-.504 1.125-1.125 1.125h-.375m1.5-1.5H21a.75.75 0 0 0-.75.75v.75m0 0H3.75m0 0h-.375a1.125 1.125 0 0 1-1.125-1.125V15m1.5 1.5v-.75A.75.75 0 0 0 3 15h-.75M15 10.5a3 3 0 1 1-6 0 3 3 0 0 1 6 0Zm3 0h.008v.008H18V10.5Zm-12 0h.008v.008H6V10.5Z" />
                                </svg>
                            </div>
                            <h2 class="text-lg text-gray-900 font-medium title-font mb-2 cbu-text">CBU: <%= cuenta.getCbu() %></h2>
                            <p class="leading-relaxed text-base" style=" font-size: 0.950rem;">Tipo: <%= cuenta.getTipoCuenta() %></p>
                            <p class="leading-relaxed text-base">Saldo: $<%= cuenta.getSaldo() %></p>
                           <a href="ServletCliente?btnVerDetalleCuenta=true&nroCuenta=<%=cuenta.getNumeroCuenta()%>" class="mt-3 text-purple-500 inline-flex items-center">Ver detalle
                                <svg fill="none" stroke="currentColor" stroke-linecap="round" stroke-linejoin="round" stroke-width="2" class="w-4 h-4 ml-2" viewBox="0 0 24 24">
                                    <path d="M5 12h14M12 5l7 7-7 7"></path>
                                </svg>
                            </a>
                            <div class="flex justify-center">
                            	<form>
                            		<input type="hidden" id="nroCuentaDetalle" name="nroCuentaDetalle" value="<%= cuenta.getNumeroCuenta() %>">
                            		<button type="submit" name="btnMovimientosCuenta" value=true class="flex mx-auto mt-16 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Movimientos</button>
                            	</form>
                            </div>
                        </div>
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

    <div class="w-1/12 bgRight"></div>

</div>

<jsp:include page="Footer.jsp" />

</body>
</html>

