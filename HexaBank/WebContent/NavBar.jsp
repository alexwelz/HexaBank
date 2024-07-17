<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="javax.servlet.http.HttpSession" %>
<%
 String usuario = null;
 String tipoUsuario = null;
 

if (session != null && session.getAttribute("usuario") != null && session.getAttribute("tipoUsuario") != null) {
	usuario = (String) session.getAttribute("usuario");
	tipoUsuario = (String) session.getAttribute("tipoUsuario");
}



%>


<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HexaBank</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
    <style>
    #menu-toggle1:checked + label + #menu {
    display: block;
    z-index: 1000; 
    opacity: 1; 
    }
</style>
</head>
<body class="bg-gray-100">
<header class="text-gray-600 body-font fixed top-0 w-full z-10 bg-gray-100 shadow">
  <div class="container mx-auto flex flex-wrap p-5 flex-col md:flex-row items-center">
      <nav class="flex lg:w-2/5 flex-wrap items-center text-base md:ml-auto">
      <input type="hidden" class="mr-5 hover:text-gray-900">
    </nav>
    <a class="flex order-first lg:order-none lg:w-1/5 title-font font-medium items-center text-gray-900 lg:items-center lg:justify-center mb-4 md:mb-0">
      <img src="Images/logo.png" alt="Logo" class="w-10 h-10 bg-purple-500 rounded-full">
      <span class="ml-3 text-xl">HexaBank</span>
    </a>
    <div class="lg:w-2/5 inline-flex lg:justify-end ml-5 lg:ml-0">
    <% if (usuario == null) { %>
      <a href="Login.jsp" class="inline-flex items-center bg-gray-100 border-0 py-1 px-3 focus:outline-none hover:bg-gray-200 rounded text-base mt-4 md:mt-0">Log in
      </a>
      <% } else if(tipoUsuario.equals("admin")){ %>
      <div class="relative inline-block text-left ml-4" >
           <a href="MenuAdmin.jsp" class="inline-flex items-center bg-gray-100 border-0 py-1 px-3 focus:outline-none hover:bg-gray-200 rounded text-base mt-4 md:mt-0"><%= usuario %>
      </a>
        </div>
      <div class="relative inline-block text-left ml-4">
        <input type="checkbox" class="hidden" id="menu-toggle1"/>
        <label for="menu-toggle1" class="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 cursor-pointer">
          Menú
          <svg class="-mr-1 ml-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
          </svg>
        </label>

        <div class="origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 hidden" id="menu">
          <div class="py-1" role="none">
            <form action="ServletSesion" method="post">
            <button type="submit" name="btnCerrarSesion" value="true" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Cerrar Sesión</button>
            </form>
            <a href="MenuAdmin.jsp" class="border-t text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Menú</a>
            <a href="ServletAdminCliente?btnAgregarCliente" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Agregar Cliente</a>
            <a href="ServletAdminCliente?btnAdminClientes" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Administrar clientes</a>
            <a href="ServletAdminCuentas?btnAgregarCuenta" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Agregar Cuenta</a>
            <a href="ServletAdminCuentas?btnAdminCuentas" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Administrar cuentas</a>
            <a href="ServletAdminPrestamos?btnPrestamos" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Préstamos</a>
            <a href="ServletReportes?btnReportes" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Reportes</a>
          </div>
        </div>
      </div>
       <% } else { %>
              <div class="relative inline-block text-left ml-4" >
           <a href="MenuCliente.jsp" class="inline-flex items-center bg-gray-100 border-0 py-1 px-3 focus:outline-none hover:bg-gray-200 rounded text-base mt-4 md:mt-0"><%= usuario %>
      </a>
        </div>
      <div class="relative inline-block text-left ml-4">
        <input type="checkbox" class="hidden" id="menu-toggle1"/>
        <label for="menu-toggle1" class="inline-flex justify-center w-full rounded-md border border-gray-300 shadow-sm px-4 py-2 bg-white text-sm font-medium text-gray-700 hover:bg-gray-50 cursor-pointer">
          Menú
          <svg class="-mr-1 ml-2 h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
            <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd"/>
          </svg>
        </label>

        <div class="origin-top-right absolute right-0 mt-2 w-56 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 hidden" id="menu">
          <div class="py-1" role="none">
            <form action="ServletSesion" method="post">
            <button type="submit" name="btnCerrarSesion" value="true" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Cerrar Sesión</button>
            </form>
            <a href="MenuCliente.jsp" class="border-t text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Menú</a>
            <a href="ServletCliente?btnPerfil" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Perfil</a>
            <a href="ServletCliente?btnCuentas" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Cuentas</a>
            <a href="ServletTransferenciasCliente?btnTransferencias" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Transferencias</a>
            <a href="ServletAdminPrestamos?btnSolicitarPrestamos" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Solicitar préstamo</a>
            <a href="ServletPagoPrestamos?btnPagoDePrestamos" class="text-gray-700 block px-4 py-2 text-sm hover:bg-gray-100">Pago de préstamos</a>
          </div>
        </div>
      </div>
       <%} %>
    </div>
  </div>
</header>


</body>
</html>

