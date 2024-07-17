package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cliente;
import entidad.Cuenta;
import entidad.Cuota;
import entidad.Prestamo;
import exceptions.sqlPagoPrestamosException;
import negocioImpl.ClienteNegocioImpl;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.CuotaNegocioImpl;
import negocioImpl.PrestamoNegocioImpl;



@WebServlet("/ServletPagoPrestamos")
public class ServletPagoPrestamos extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private PrestamoNegocioImpl prestamoNegocioImpl = new PrestamoNegocioImpl();
	private CuotaNegocioImpl cuotaNegocioImpl = new CuotaNegocioImpl();
	private ArrayList<Cuota> listaCuotas = new ArrayList<Cuota>();
	private CuentaNegocioImpl cuentaNegocioImpl = new CuentaNegocioImpl();
	private ArrayList<Cuenta> cuentasPorCliente = new ArrayList<Cuenta>();
	private ArrayList<Prestamo> listaPrestamos= new ArrayList<Prestamo>();

       
  
    public ServletPagoPrestamos() {
        super();
      
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();      	
		if(request.getParameter("btnPagoDePrestamos")!=null) {
			
			int cantCuentas = (int) session.getAttribute("cantCuentas");
			if(cantCuentas !=0) {
				cargarPrestamos(request);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/PagoPrestamosCliente.jsp");
				dispatcher.forward(request, response);	
			}else {
				session.setAttribute("respuesta", "No tiene cuentas disponibles para acceder a esta opción.");
				RequestDispatcher dispatcher = request.getRequestDispatcher("/MenuCliente.jsp");
				dispatcher.forward(request, response);		
			}

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();  		   
		if(request.getParameter("btnPagarCuota") != null) {
			try {
				int cuotaId = Integer.parseInt(request.getParameter("idCuota"));
				int nroCuota = Integer.parseInt(request.getParameter("nroCuota"));
				String nroCuenta = request.getParameter("CuentaOrigen");
				int prestamoId =  Integer.parseInt(request.getParameter("prestamoId"));
				int pagada = cuotaNegocioImpl.update(cuotaId, nroCuenta);
				
				if(pagada == 0) {
					session.setAttribute("respuesta", "Cuota pagada con éxito");
					
				} else {
					if(pagada == 45000) {
						throw new sqlPagoPrestamosException("Error: " + String.valueOf(pagada) + ", saldo insuficiente para pagar la cuota.");
					}else {
						throw new Exception("Error: " + String.valueOf(pagada) + ", no fue posible pagar la cuota.");
					}
					
				}
				
				cargarPrestamos(request);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/PagoPrestamosCliente.jsp");
				dispatcher.forward(request, response);
				
			}catch(Exception e) {
				session.setAttribute("respuesta", e.getMessage());
				cargarPrestamos(request);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/PagoPrestamosCliente.jsp");
				dispatcher.forward(request, response);
			}
	     }
	}
	
    private void cargarPrestamos(HttpServletRequest request) {
		HttpSession session = request.getSession();  
		Cliente cliente = (Cliente)session.getAttribute("cliente");
		cuentasPorCliente = cuentaNegocioImpl.listCuentasPorCliente(cliente.getDni());
		request.setAttribute("Lista_Cuentas_cliente", cuentasPorCliente);
    	listaPrestamos = prestamoNegocioImpl.listIdPrestamosPorCliente(cliente.getDni());		
		if(listaPrestamos.isEmpty() || listaPrestamos == null) {
			listaPrestamos = null;
		}
		request.setAttribute("listaPrestamos", listaPrestamos);
	}

}
