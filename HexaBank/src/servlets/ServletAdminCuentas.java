package servlets;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cliente;
import entidad.Cuenta;
import negocioImpl.*;

@WebServlet("/ServletAdminCuentas")
public class ServletAdminCuentas extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CuentaNegocioImpl cuentaNegocioImpl = new CuentaNegocioImpl();
	private ClienteNegocioImpl clienteNegocioImpl = new ClienteNegocioImpl();
	private ArrayList<Cuenta> listaCuentas = new ArrayList<Cuenta>();
       

    public ServletAdminCuentas() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
		if(request.getParameter("btnAgregarCuenta")!=null)
	    {
	    	RequestDispatcher dispatcher = request.getRequestDispatcher("/AgregarCuenta.jsp");
			dispatcher.forward(request, response);
	    }
		
		if(request.getParameter("btnAdminCuentas")!=null)
	    {
			listaCuentas = cuentaNegocioImpl.list();
            request.setAttribute("Lista_Cuentas", listaCuentas);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/ListarCuentas.jsp");
			dispatcher.forward(request, response);
	    }
		
		if(request.getParameter("btnModificar")!=null)
	    {
		    String auxNro = request.getParameter("nroCuenta");
		    int nroCuenta = Integer.parseInt(auxNro);
            Cuenta auxCuenta = listaCuentas.stream().filter(x -> (x.getNumeroCuenta()) == nroCuenta).findFirst().orElse(null);
            request.setAttribute("cuenta", auxCuenta);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/ModificarCuenta.jsp");
			dispatcher.forward(request, response);
	    }
		
		else if(request.getParameter("btnEliminar") != null) {
			try {
	        	int nroCuenta = Integer.parseInt(request.getParameter("nroCuenta"));
				String resultadoBaja = cuentaNegocioImpl.delete(nroCuenta);
				session.setAttribute("respuesta", resultadoBaja);
	        	listaCuentas = cuentaNegocioImpl.list();
	            request.setAttribute("Lista_Cuentas", listaCuentas);   
	        	RequestDispatcher dispatcher = request.getRequestDispatcher("/ListarCuentas.jsp");
	        	dispatcher.forward(request, response);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		
	    if (request.getParameter("btnModificarCuenta") != null) {
	        String aux = request.getParameter("saldo");
	        BigDecimal saldo = new BigDecimal(aux);
	        
	        if (saldo.compareTo(BigDecimal.ZERO) < 0) {
	            session.setAttribute("respuesta", "No se aceptan saldos negativos");
	            String auxNro = request.getParameter("nroCuenta");
	            int nroCuenta = Integer.parseInt(auxNro);
                Cuenta auxCuenta = listaCuentas.stream().filter(x -> (x.getNumeroCuenta()) == nroCuenta).findFirst().orElse(null);
                request.setAttribute("cuenta", auxCuenta);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/ModificarCuenta.jsp");
	            dispatcher.forward(request, response);
	            return;
	        }
	        
	        Boolean modificado = cuentaNegocioImpl.update(
	            Integer.parseInt(request.getParameter("nroCuenta")),
	            request.getParameter("tipoCuenta"),
	            saldo
	        );

	        if (modificado) {
	            session.setAttribute("respuesta","Los cambios fueron guardados con éxito");
	        } else {
	            session.setAttribute("respuesta","Error. Los cambios no han sido guardados");
	        }

	        listaCuentas = cuentaNegocioImpl.list();
	        request.setAttribute("Lista_Cuentas", listaCuentas);
	        RequestDispatcher dispatcher = request.getRequestDispatcher("/ListarCuentas.jsp");
	        dispatcher.forward(request, response);
	    } 
	    
	    else if (request.getParameter("btnAgregarNuevaCuenta") != null) {
	       	    	
	    	String dni = request.getParameter("dni");
	        List<Cliente> listaCliente = clienteNegocioImpl.list();
	        List<Cliente> auxListaCliente = listaCliente.stream().filter(x -> x.getDni().equals(dni)).collect(Collectors.toList());

	        listaCuentas = cuentaNegocioImpl.list();
	        List<Cuenta> auxLista = listaCuentas.stream().filter(x -> x.getCliente().getDni().equals(dni)).collect(Collectors.toList());

	        // Verificamos que el cliente exista
	        
	        if (auxListaCliente == null || auxListaCliente.isEmpty()) {
	        	
	        		session.setAttribute("respuesta", "Cliente inexistente");
	                RequestDispatcher dispatcher = request.getRequestDispatcher("/AgregarCuenta.jsp");
	                dispatcher.forward(request, response);
	                return;
	        	
	        } else if (auxLista.size() == 3) {
	        	session.setAttribute("respuesta", "El cliente nro " + auxLista.get(0).getCliente().getNombre() + " " + auxLista.get(0).getCliente().getApellido() + " ya ha alcanzado su cantidad maxima de cuentas (3 cuentas por cliente)");
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/AgregarCuenta.jsp");
	            dispatcher.forward(request, response);
	            return;
	        } else {
	        	 System.out.println("inserto");
	            String tipoCuenta = request.getParameter("tipoCuenta");
	            int id = cuentaNegocioImpl.getLastId() + 1;
                
	            String cbu = String.format("%022d", id);  

	            Cuenta newCuenta = new Cuenta();
	            Cliente cliente = clienteNegocioImpl.get(dni);
	            newCuenta.setCliente(cliente);
	            newCuenta.setCbu(cbu);
	            newCuenta.setTipoCuenta(tipoCuenta);

	            boolean inserto = cuentaNegocioImpl.insert(newCuenta);
	            if (inserto) {
	            	session.setAttribute("respuesta", "La cuenta para el DNI: "+ dni + " fue agregada exitosamente");
	            } else {
	            	session.setAttribute("respuesta", "Error. La cuenta no se pudo agregar");
	            }
	            RequestDispatcher dispatcher = request.getRequestDispatcher("/AgregarCuenta.jsp");
	            dispatcher.forward(request, response);
	        }
	    }
	}



}
