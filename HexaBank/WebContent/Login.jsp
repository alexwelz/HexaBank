<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log in</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
     <link rel="icon" type="image/png" href="Images/logo.png">
       <style>
    
          .content-background {
            background: url('Svg/lines-2.svg') no-repeat;
            background-size: 70%;
        }

    </style>
</head>
<body>

 <jsp:include page="NavBar.jsp" />
 
 <div class="bg-white pt-24">
 
<div class="content-background min-h-screen flex items-center justify-center">

<section class="text-gray-600 body-font">
  <div class="container px-5 py-24 mx-auto flex flex-wrap items-center" style="margin-top: 7%;">
    <div class="lg:w-3/5 md:w-1/2 md:pr-16 lg:pr-0 pr-0">
      <div class="lg:w-3/5 md:w-1/2 md:pr-16 lg:pr-0 pr-0">
    <h1 class="title-font font-medium text-3xl text-gray-900">¡Hola! Te damos la bienvenida</h1>
    <br>
</div>
    <img src="Images/imagen1.PNG" alt="Descripción de la imagen" class="object-cover object-center rounded">
    </div>
    <div class="lg:w-2/6 md:w-1/2 bg-gray-100 rounded-lg p-8 flex flex-col md:ml-auto w-full mt-10 md:mt-0" style="margin-top: 3%;">
      <h2 class="text-gray-900 text-lg font-medium title-font mb-5">Log in</h2>
       <form action="ServletSesion" method="post"> 
      <div class="relative mb-4">
        <label for="username" class="leading-7 text-sm text-gray-600">Usuario</label>
        <input type="text" required id="username" name="username" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
      </div>
      <div class="relative mb-4">
        <label for="password" class="leading-7 text-sm text-gray-600">Contraseña</label>
        <input type="password" required id="password" name="password" class="w-full bg-white rounded border border-gray-300 focus:border-indigo-500 focus:ring-2 focus:ring-indigo-200 text-base outline-none text-gray-700 py-1 px-3 leading-8 transition-colors duration-200 ease-in-out">
        <input type="checkbox" id="show-password" class="ml-2">
        <label for="show-password" class="text-sm text-gray-600">Ver contraseña</label>
      </div>
       <button type="submit" name="btnIngresar" class="text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Ingresar</button>
         </form>
      <p class="text-xs text-gray-500 mt-3">No compartas por redes sociales, teléfono o email tus claves personales. Nadie en nombre del banco te lo va a pedir.</p>
    </div>
  </div>
</section>

</div>


<script>
    document.addEventListener("DOMContentLoaded", function() {
        var checkbox = document.getElementById("show-password");
        var passwordField = document.getElementById("password");
        
        checkbox.addEventListener("change", function() {
            if (this.checked) {
                passwordField.type = "text";
            } else {
                passwordField.type = "password";
            }
        });
    });
</script>

 <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <script>
            alert('<%= errorMessage %>');
        </script>
    <%
        }
    %>

</div>

</div>

     <jsp:include page="Footer.jsp" />
     
</body>
</html>