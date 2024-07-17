package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.sql.Date;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.Localidad;
import entidad.Usuario;
import dao.ClienteDao;
import dao.CuentaDao;
import daoImpl.UsuarioDaoImpl;
import daoImpl.LocalidadDaoImpl;

public class CuentaDaoImpl implements CuentaDao {
	
	private static final String list = "SELECT c.*, t.tipo_cuenta FROM cuentas c JOIN tiposcuentas t ON c.id_tipoCuenta = t.id_tipoCuenta WHERE c.estado = 1";	    
	private static final String listPorDni = "SELECT c.*, t.tipo_cuenta FROM cuentas c JOIN tiposcuentas t ON c.id_tipoCuenta = t.id_tipoCuenta WHERE c.estado = 1 and c.dni = ?";	    
	private static final String get =  "SELECT c.*, t.tipo_cuenta FROM cuentas c JOIN tiposcuentas t ON c.id_tipoCuenta = t.id_tipoCuenta WHERE c.numero_cuenta = ?";    
	private static final String getlastId = "SELECT c.numero_cuenta FROM cuentas c ORDER BY c.numero_cuenta DESC LIMIT 1";	    
	private static final String insert = "INSERT INTO cuentas(id_tipoCuenta, cbu, dni, fecha_creacion) VALUES((SELECT id_tipoCuenta FROM tiposcuentas WHERE tipo_cuenta = ?), ?, ?, CURDATE())";	    
	private static final String update = "UPDATE cuentas SET id_tipoCuenta = (SELECT id_tipoCuenta FROM tiposcuentas WHERE tipo_cuenta = ?), saldo = ? WHERE numero_cuenta = ?";	    
	private static final String delete = "UPDATE cuentas SET estado = 0 where numero_cuenta = ?";
	private static final String prestamosPorCuenta = "SELECT COUNT(*) FROM prestamos WHERE numero_cuenta = ? AND estado_prestamo <> 'Rechazado' AND estado = 'Vigente'";


	
	@Override
	public ArrayList<Cuenta> list() {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    ArrayList<Cuenta> list_cuentas = new ArrayList<Cuenta>();
	    try {
	        Connection conexion = Conexion.getConexion().getSQLConexion();
	        Statement statement = conexion.createStatement();
	        ResultSet result_set = statement.executeQuery(list);
	        while(result_set.next()) {
	            ClienteDaoImpl clienteDaoImpl = new ClienteDaoImpl();
	            Cliente cliente = clienteDaoImpl.get(result_set.getString("dni"));
	            
	            list_cuentas.add(
	                new Cuenta(
	                    cliente,
	                    result_set.getDate("fecha_creacion"),
	                    result_set.getString("tipo_cuenta"),
	                    result_set.getInt("numero_cuenta"),
	                    result_set.getString("cbu"),
	                    result_set.getBigDecimal("saldo"),
	                    result_set.getBoolean("estado")
	                )
	            );
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }

	    return list_cuentas;
	}
	
	@Override
	public ArrayList<Cuenta> listCuentasPorCliente(String dni) {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    ArrayList<Cuenta> list_cuentas = new ArrayList<Cuenta>();
	    try {
	        Connection conexion = Conexion.getConexion().getSQLConexion();
	        PreparedStatement statement = conexion.prepareStatement(listPorDni);
	        statement.setString(1, dni);
	        ResultSet result_set = statement.executeQuery();
	        
	        while (result_set.next()) {
	            ClienteDaoImpl clienteDaoImpl = new ClienteDaoImpl();
	            Cliente cliente = clienteDaoImpl.get(result_set.getString("dni"));
	            
	            list_cuentas.add(
        		  new Cuenta(
  	                    cliente,
  	                    result_set.getDate("fecha_creacion"),
  	                    result_set.getString("tipo_cuenta"),
  	                    result_set.getInt("numero_cuenta"),
  	                    result_set.getString("cbu"),
  	                    result_set.getBigDecimal("saldo"),
  	                    result_set.getBoolean("estado")
  	                )
	            );
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return list_cuentas;

	}

	

	@Override
	public boolean insert(Cuenta cuenta_a_agregar) {
		try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	}

		PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    boolean isInsertExitoso = false;
	    try
	    {
	    
	        statement = conexion.prepareStatement(insert);
	        
	        statement.setString(1, String.valueOf(cuenta_a_agregar.getTipoCuenta()));
	        statement.setString(2,cuenta_a_agregar.getCbu());
	        statement.setString(3,cuenta_a_agregar.getCliente().getDni());

	        
	        if(statement.executeUpdate() > 0)
	        {
	            conexion.commit();
	            isInsertExitoso = true;
	        }
	    } 
	    catch (SQLException e) 
	    {
	        e.printStackTrace();
	        try {
         	     conexion.rollback();

	            
	        } catch (SQLException e1) {
	            e1.printStackTrace();
	        }
	    }
	    return isInsertExitoso;
	}


	@Override
	public String delete(int nroCuenta) {
		 try {
		        Class.forName("com.mysql.jdbc.Driver");
		    } catch (ClassNotFoundException e) {
		        e.printStackTrace();
		    }

		    PreparedStatement statement;
		    Connection conexion = Conexion.getConexion().getSQLConexion();
		    String respuesta=null;

		    try {
		    	if (!prestamosPorCuenta(nroCuenta)) {
		        statement = conexion.prepareStatement(delete);
		        statement.setInt(1, nroCuenta);
		        

	            if (statement.executeUpdate() > 0) {
	                conexion.commit();
	                respuesta = "La cuenta nro " + nroCuenta + " fue eliminada exitosamente";
	            } else {
	                respuesta = "La cuenta nro " + nroCuenta + " no se pudo eliminar";
	            }
	        } else {
	            respuesta = "La cuenta tiene préstamos vigentes y no puede darse de baja.";
	        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		        try {
		            conexion.rollback();
		        } catch (SQLException e1) {
		            e1.printStackTrace();
		        }
		    }
		    return respuesta;

	}
	
	
	public boolean prestamosPorCuenta(int nroCuenta) {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	        return false;
	    }

	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    PreparedStatement statement;
	    boolean tienePrestamos = false;

	    try {
	        statement = conexion.prepareStatement(prestamosPorCuenta);
	        statement.setInt(1, nroCuenta);
	        ResultSet resultSet = statement.executeQuery();
	        
	        if (resultSet.next()) {
	            int prestamosActivos = resultSet.getInt(1);
	            tienePrestamos = prestamosActivos > 0;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return tienePrestamos;
	}




	@Override
	public boolean update(int nroCuenta, String tipoCuenta, BigDecimal saldo) {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    boolean isUpdateExitoso = false;

	    try {
	        statement = conexion.prepareStatement(update);
	        statement.setString(1, tipoCuenta);
	        statement.setBigDecimal(2, saldo);
	        statement.setInt(3, nroCuenta);
	        
	        if (statement.executeUpdate() > 0) {
	            conexion.commit();
	            isUpdateExitoso = true;
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	        try {
	            conexion.rollback();
	        } catch (SQLException e1) {
	            e1.printStackTrace();
	        }
	    }
	    return isUpdateExitoso;
	}



	@Override
	public Cuenta get(int nroCuenta) {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    try {
	        statement = conexion.prepareStatement(get);
	        statement.setInt(1, nroCuenta);
	        ResultSet result_set = statement.executeQuery();
	        while(result_set.next()) {
	            ClienteDaoImpl clienteDaoImpl = new ClienteDaoImpl();
	            Cliente cliente = clienteDaoImpl.get(result_set.getString("dni"));

	            Cuenta cuenta = new Cuenta(
	                cliente,
	                result_set.getDate("fecha_creacion"),
	                result_set.getString("tipo_cuenta"),
	                result_set.getInt("numero_cuenta"),
	                result_set.getString("cbu"),
	                result_set.getBigDecimal("saldo"),
	                result_set.getBoolean("estado")
	            );
	            return cuenta;
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return null;
	}
	@Override
	public int getLastId() {
	    try {
	        Class.forName("com.mysql.jdbc.Driver");
	    } catch (ClassNotFoundException e) {
	        e.printStackTrace();
	    }

	    PreparedStatement statement;
	    Connection conexion = Conexion.getConexion().getSQLConexion();
	    try {
	        statement = conexion.prepareStatement(getlastId);
	        ResultSet result_set = statement.executeQuery();
	        while(result_set.next()) {
	            int lastId = result_set.getInt("numero_cuenta");
	            return lastId;
	        }
	    } catch(Exception e) {
	        e.printStackTrace();
	    }
	    return 0;
	}
}
