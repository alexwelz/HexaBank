<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
    </style>
</head>
<body>
    <jsp:include page="NavBar.jsp"/>
    <div class="flex">
        <div class="w-1/12 bgLeft pt-24"></div>
        <div class="w-10/12 p-4 bg-white bg-opacity-80 pt-24">
            <div class="container mx-auto px-4 py-8" style="overflow-y: auto;  min-height: 400px;">
                <div class="flex flex-col items-center w-full">
                 <br>
                  <br>
                    <h2 class="sm:text-3xl text-2xl font-medium title-font mb-2 text-gray-900">Transferencias</h2>
                    <br>
                    <div class="flex flex-col items-center w-full space-y-4">
                     <form action="ServletTransferenciasCliente" method="get"> 
                        <button type="submit" name="btnTransferencias2" class="w-60 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Cuentas propias</button>
                        <button type="submit" name="btnTransferencias1" class="w-60 text-white bg-purple-500 border-0 py-2 px-8 focus:outline-none hover:bg-purple-600 rounded text-lg">Cuentas de Terceros</button>
                      </form>
                    </div>
                    <br>
                     <br>                   
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
