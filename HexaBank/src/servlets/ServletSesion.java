package servlets;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cliente;
import entidad.Usuario;
import negocioImpl.ClienteNegocioImpl;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.UsuarioNegocioImpl;

@WebServlet("/ServletSesion")
public class ServletSesion extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private ClienteNegocioImpl clienteNegocioImpl = new ClienteNegocioImpl();

    public ServletSesion() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
      
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();  

        if(request.getParameter("btnIngresar") != null) {
            UsuarioNegocioImpl usuarioNegocioImpl = new UsuarioNegocioImpl();

            String nombreUsuario = request.getParameter("username");
            String password = request.getParameter("password");

            if (usuarioNegocioImpl.existeNombreUsuario(nombreUsuario)) {
                Usuario usuario = usuarioNegocioImpl.buscarUsuario(nombreUsuario);

                if (usuario.getPassword().equals(password)) {
                	
                	if(usuario.getTipoUsuario().getTipoUsuario().equals("administrador")) {
	                    session.setAttribute("tipoUsuario", "admin");
	                    session.setAttribute("usuario", nombreUsuario);
	
	                    RequestDispatcher dispatcher = request.getRequestDispatcher("/MenuAdmin.jsp");
	                    dispatcher.forward(request, response);
                	}else {               		
                		Cliente auxCliente = clienteNegocioImpl.getPorIdUsuario(usuario.getUsuarioId());
                		session.setAttribute("cliente", auxCliente);
                        session.setAttribute("tipoUsuario", "cliente");
                        session.setAttribute("usuario", nombreUsuario);
                    	
                        CuentaNegocioImpl cuentaNegocio = new CuentaNegocioImpl();
            			int cantCuentas = cuentaNegocio.listCuentasPorCliente(auxCliente.getDni()).size();
            			session.setAttribute("cantCuentas", cantCuentas);
                        
                        RequestDispatcher dispatcher = request.getRequestDispatcher("/MenuCliente.jsp");
	                    dispatcher.forward(request, response);	
                	}
                } else {
                    request.setAttribute("errorMessage", "Contraseña incorrecta.");
                    RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
                    dispatcher.forward(request, response);
                }
            } else {
                request.setAttribute("errorMessage", "Usuario no encontrado.");
                RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
                dispatcher.forward(request, response);
            }
        }

        if(request.getParameter("btnCerrarSesion") != null) {
            session.invalidate();
            RequestDispatcher dispatcher = request.getRequestDispatcher("/Login.jsp");
            dispatcher.forward(request, response);
        }
    }
}
