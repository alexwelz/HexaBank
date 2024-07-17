package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Prestamo;
import negocioImpl.ClienteNegocioImpl;
import negocioImpl.PrestamoNegocioImpl;
import negocioImpl.TipoPrestamoNegocioImpl;

@WebServlet("/ServletReportes")
public class ServletReportes extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private TipoPrestamoNegocioImpl tipoPrestamoImpl = new TipoPrestamoNegocioImpl();
	private PrestamoNegocioImpl prestamoImpl = new PrestamoNegocioImpl();
	private ArrayList<Prestamo> listaTipoPrestamos = new ArrayList<Prestamo>();

    public ServletReportes() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("btnReportes")!=null) {
		    request.setAttribute("MostrarForm", "MostrarForm");
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/Reportes.jsp");
			dispatcher.forward(request, response);
	    }

	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();  
	    if(request.getParameter("btnAtras")!=null) {
	        request.setAttribute("MostrarForm", "MostrarForm");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/Reportes.jsp");
	        dispatcher.forward(request, response);
	        
	    } else if(request.getParameter("btnDescargar")!=null) {
	        String reporte = request.getParameter("reporte");
	        request.setAttribute("MostrarForm", "NoMostrarForm");
	        response.setContentType("text/plain");
	        response.setHeader("Content-Disposition", "attachment;filename=reporte.txt");

	        PrintWriter out = response.getWriter();
	        out.print(reporte);
	        out.flush();
	        out.close();
	        
	        return;
	    } else if(request.getParameter("btnGenerarReporte")!=null) {
	    	
	        String fmin = request.getParameter("fechaInicio");
	        String fmax = request.getParameter("fechaFin");
	        String montoMin = request.getParameter("importeMin");
	        String montoMax = request.getParameter("importeMax");
	        Date fechaMin = Date.valueOf(fmin);
	        Date fechaMAx = Date.valueOf(fmax);
	        String estadoPrestamo = request.getParameter("estado");
	        BigDecimal bdMontoMin = new BigDecimal(montoMin);
	        BigDecimal bdMontoMax = new BigDecimal(montoMax);
	        String dni = request.getParameter("DNIclienteReporte");
	        
	        ClienteNegocioImpl cNegocio =new ClienteNegocioImpl();
	        boolean existe = cNegocio.existeCliente(dni);

			if (dni.isEmpty() || dni == null) {
				listaTipoPrestamos = prestamoImpl.obtenerPrestamosSinDni(fechaMin, fechaMAx, estadoPrestamo, bdMontoMin,bdMontoMax);
			} else if (!existe) {
 				   
                session.setAttribute("respuesta", "El cliente ingresado no existe.");
                request.setAttribute("MostrarForm", "MostrarForm");
    	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/Reportes.jsp");
    			dispatcher.forward(request, response);

    	        return;
                
			} else {
				listaTipoPrestamos = prestamoImpl.obtenerPrestamosPorDni(dni, fechaMin, fechaMAx, estadoPrestamo,bdMontoMin, bdMontoMax);

			}

	        String textAreaReporte = "";
	        textAreaReporte = "   Nombre y Apellido   " + "       DNI       " + "   Fecha de solicitud   " + "   Importe solicitado   " + "   Estado   "+ "\n";
	        for(Prestamo prestamo : listaTipoPrestamos) {
		        textAreaReporte += "------------------------------------------------------------------------------------------------------" + "\n";
	            textAreaReporte +="     "+ prestamo.getCliente().getNombre() + " " + prestamo.getCliente().getApellido() + "             "  + prestamo.getCliente().getDni() + "         "  + prestamo.getFecha().toString() + "                " + prestamo.getTipoPrestamo().getImporteTotal() + "              "  + prestamo.getEstado() + "\n";
	        }

	        request.setAttribute("textAreaReporte", textAreaReporte);
	        request.setAttribute("MostrarForm", "NoMostrarForm");
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/Reportes.jsp");
	        dispatcher.forward(request, response);
	    }
	}
}
