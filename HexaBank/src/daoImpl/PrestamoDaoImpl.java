package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.mysql.jdbc.CallableStatement;

import dao.PrestamoDao;
import entidad.Prestamo;
import entidad.Cliente;
import entidad.Cuenta;
import entidad.TipoPrestamo;

public class PrestamoDaoImpl implements PrestamoDao {
    private static final String update       = "UPDATE prestamos SET numero_cuenta = ?, fecha = ?, plazo_pago = ?, tipo_prestamo_id = ?, estado_prestamo = ? WHERE prestamo_id = ?";
    private static final String updateEstado = "UPDATE prestamos SET estado_prestamo = ? WHERE prestamo_id = ?";
    private static final String updateEstadoCancelado = "UPDATE prestamos SET estado = ? WHERE prestamo_id = ?";
    private static final String insert = "INSERT INTO prestamos(numero_cuenta, fecha, plazo_pago, tipo_prestamo_id, estado_prestamo) VALUES(?, ?, ?, ?, ?)";  
    private static final String list = "SELECT p.*, cli.nombre, cli.apellido FROM prestamos as p JOIN cuentas c ON p.numero_cuenta = c.numero_cuenta JOIN clientes cli ON c.dni = cli.dni WHERE p.estado_prestamo = 'En proceso'";
    private static final String get = "SELECT * FROM prestamos WHERE prestamo_id = ?";
    private static final String call = "CALL SP_AUTORIZAR_PRESTAMO(?, ?)";
    private static final String obtenerPrestamosPorDni = "CALL ObtenerPrestamos(?, ?, ?, ?, ?, ?)";
    private static final String obtenerPrestamosSinDni = "CALL ObtenerPrestamosSinDni(?, ?, ?, ?, ?)";
    private static final String listIdPrestamosPorCliente = "SELECT p.prestamo_id, p.plazo_pago FROM prestamos as p INNER JOIN cuentas c ON p.numero_cuenta = c.numero_cuenta INNER JOIN clientes cl ON c.dni = cl.dni WHERE cl.dni = ? AND p.estado_prestamo = 'Autorizado' AND p.estado = 'Vigente'";

    @Override
    public boolean insert(Prestamo prestamo) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isInsertExitoso = false;
        try {
            statement = conexion.prepareStatement(insert);
            statement.setInt(1, prestamo.getCuenta().getNumeroCuenta());
            statement.setDate(2, prestamo.getFecha());
            statement.setInt(3, prestamo.getPlazoPago());
            statement.setInt(4, prestamo.getTipoPrestamo().getTipoPrestamoId());
            statement.setString(5, "En proceso");

            if (statement.executeUpdate() > 0) {
                conexion.commit();
                isInsertExitoso = true;
            }
        } catch (SQLException e) {
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
    public boolean update(int idPrestamo, String estado) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isUpdateExitoso = false;
        try {
            statement = conexion.prepareStatement(updateEstado);
            statement.setString(1, estado);
            statement.setInt(2, idPrestamo);

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
    
    public boolean update(int idPrestamo) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isUpdateExitoso = false;
        try {
            statement = conexion.prepareStatement(updateEstadoCancelado);
            statement.setString(1, "Cancelado");
            statement.setInt(2, idPrestamo);

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
    
    public boolean update(int idPrestamo, int cuentaDestino) {
    	 try {
             Class.forName("com.mysql.jdbc.Driver");
         } catch (ClassNotFoundException e) {
             e.printStackTrace();
         }

         CallableStatement statement = null;
         Connection conexion = Conexion.getConexion().getSQLConexion();
         boolean isExitoso = false;

         try {
             statement = (CallableStatement) conexion.prepareCall(call);
             statement.setInt(1, idPrestamo);
             statement.setInt(2, cuentaDestino);

             statement.execute();


             conexion.commit();
             isExitoso = true;
             
         } catch (SQLException e) {
             e.printStackTrace();
             try {
                 conexion.rollback();
                 isExitoso=false;
             } catch (SQLException e1) {
                 e1.printStackTrace();
             }
         } 
         

         return isExitoso;
     }
    
    @Override
    public Prestamo get(int prestamo_id) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        Cuenta cuenta = new Cuenta();

        try {
            statement = conexion.prepareStatement(get);
            statement.setInt(1, prestamo_id);
            ResultSet result_set = statement.executeQuery();
            while (result_set.next()) {
                int prestamoId = result_set.getInt("prestamo_id");
                cuenta.setNumeroCuenta(result_set.getInt("numero_cuenta"));
                java.sql.Date fecha = result_set.getDate("fecha");
                int plazoPago = result_set.getInt("plazo_pago");
                int tipoPrestamoId = result_set.getInt("tipo_prestamo_id");
                String estadoPrestamo = result_set.getString("estado_prestamo");

                TipoPrestamoDaoImpl tipoPrestamoDaoImpl = new TipoPrestamoDaoImpl();
                TipoPrestamo tipoPrestamo = tipoPrestamoDaoImpl.get(tipoPrestamoId);
                Cliente cliente = new Cliente();

                Prestamo prestamo = new Prestamo(prestamoId, cuenta, cliente, tipoPrestamo, fecha, estadoPrestamo,plazoPago);
                return prestamo;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public ArrayList<Prestamo> list() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        ArrayList<Prestamo> list_prestamos = new ArrayList<Prestamo>();
        Cuenta cuenta = new Cuenta();
        try {
            Connection conexion = Conexion.getConexion().getSQLConexion();
            Statement statement = conexion.createStatement();
            ResultSet result_set = statement.executeQuery(list);
            while (result_set.next()) {
                int prestamoId = result_set.getInt("prestamo_id");
                cuenta.setNumeroCuenta(result_set.getInt("numero_cuenta"));
                java.sql.Date fecha = result_set.getDate("fecha");
                int plazoPago = result_set.getInt("plazo_pago");
                int tipoPrestamoId = result_set.getInt("tipo_prestamo_id");
                String estadoPrestamo = result_set.getString("estado_prestamo");
                String nombre = result_set.getString("nombre");
                String apellido = result_set.getString("apellido");
                
                Cliente cliente = new Cliente();
                cliente.setApellido(apellido);
                cliente.setNombre(nombre);

                TipoPrestamoDaoImpl tipoPrestamoDaoImpl = new TipoPrestamoDaoImpl();
                TipoPrestamo tipoPrestamo = tipoPrestamoDaoImpl.get(tipoPrestamoId);         
                Prestamo prestamo = new Prestamo(prestamoId, cuenta,cliente, tipoPrestamo, fecha, estadoPrestamo,plazoPago);

                list_prestamos.add(prestamo);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list_prestamos;
    }
    
    public ArrayList<Prestamo> obtenerPrestamosPorDni(String dniCliente, Date fechaInicio, Date fechaFin,
            String estadoPrestamo, BigDecimal importeMin, BigDecimal importeMax) {
        ArrayList<Prestamo> listaPrestamos = new ArrayList<>();
        try {
            CallableStatement statement = null;
            Connection conexion = Conexion.getConexion().getSQLConexion();
            statement = (CallableStatement) conexion.prepareCall(obtenerPrestamosPorDni);
            statement.setString(1, dniCliente);
            statement.setDate(2, fechaInicio);
            statement.setDate(3, fechaFin);
            statement.setString(4, estadoPrestamo);
            statement.setBigDecimal(5, importeMin);
            statement.setBigDecimal(6, importeMax);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int prestamoId = resultSet.getInt("prestamo_id");
                int numeroCuenta = resultSet.getInt("numero_cuenta");
                Date fecha = resultSet.getDate("fecha");
                int plazoPago = resultSet.getInt("plazo_pago");
                int tipoPrestamoId = resultSet.getInt("tipo_prestamo_id");

                Cuenta cuenta = new Cuenta();
                Cliente cliente = new Cliente();
                TipoPrestamo tipoPrestamo  = new TipoPrestamo();
                
                TipoPrestamoDaoImpl tipoPrestamoDaoImpl = new TipoPrestamoDaoImpl();
                tipoPrestamo = tipoPrestamoDaoImpl.get(tipoPrestamoId);
                
                CuentaDaoImpl cuentaDaoImpl = new CuentaDaoImpl();
                cuenta =  cuentaDaoImpl.get(numeroCuenta);
                
                ClienteDaoImpl clienteDaoImpl = new ClienteDaoImpl();
                cliente = clienteDaoImpl.get(cuenta.getCliente().getDni());

                Prestamo prestamo = new Prestamo(prestamoId, cuenta, cliente, tipoPrestamo, fecha, estadoPrestamo, plazoPago);
                listaPrestamos.add(prestamo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaPrestamos;
    }

    public ArrayList<Prestamo> obtenerPrestamosSinDni(Date fechaInicio, Date fechaFin,
            String estadoPrestamo, BigDecimal importeMin, BigDecimal importeMax) {
        ArrayList<Prestamo> listaPrestamos = new ArrayList<>();
        try {
            CallableStatement statement = null;
            Connection conexion = Conexion.getConexion().getSQLConexion();
            statement = (CallableStatement) conexion.prepareCall(obtenerPrestamosSinDni);
            statement.setDate(1, fechaInicio);
            statement.setDate(2, fechaFin);
            statement.setString(3, estadoPrestamo);
            statement.setBigDecimal(4, importeMin);
            statement.setBigDecimal(5, importeMax);
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                int prestamoId = resultSet.getInt("prestamo_id");
                int numeroCuenta = resultSet.getInt("numero_cuenta");
                Date fecha = resultSet.getDate("fecha");
                int plazoPago = resultSet.getInt("plazo_pago");
                int tipoPrestamoId = resultSet.getInt("tipo_prestamo_id");
                
                Cuenta cuenta = new Cuenta();
                Cliente cliente = new Cliente();
                TipoPrestamo tipoPrestamo  = new TipoPrestamo();
                
                TipoPrestamoDaoImpl tipoPrestamoDaoImpl = new TipoPrestamoDaoImpl();
                tipoPrestamo = tipoPrestamoDaoImpl.get(tipoPrestamoId);
                
                CuentaDaoImpl cuentaDaoImpl = new CuentaDaoImpl();
                cuenta =  cuentaDaoImpl.get(numeroCuenta);
                
                ClienteDaoImpl clienteDaoImpl = new ClienteDaoImpl();
                cliente = clienteDaoImpl.get(cuenta.getCliente().getDni());

                Prestamo prestamo = new Prestamo(prestamoId, cuenta, cliente, tipoPrestamo, fecha, estadoPrestamo, plazoPago);
                listaPrestamos.add(prestamo);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return listaPrestamos;
    }

	@Override
	public ArrayList<Prestamo> listIdPrestamosPorCliente(String dni) {

		 try {
	            Class.forName("com.mysql.jdbc.Driver");
	        } catch (ClassNotFoundException e) {
	            e.printStackTrace();
	        }
	        ArrayList<Prestamo> listPrestamos = new ArrayList<Prestamo>();
	        CuotaDaoImpl cuotaDao = new CuotaDaoImpl();
	        PreparedStatement statement;
	        Connection conexion = Conexion.getConexion().getSQLConexion();
	        try {
	            statement = conexion.prepareStatement(listIdPrestamosPorCliente);
	            statement.setString(1, dni);
	            ResultSet result_set = statement.executeQuery();
	            while (result_set.next()) {
	                int prestamoId = result_set.getInt("prestamo_id");
	                int plazoPago = result_set.getInt("plazo_pago");
	                Prestamo prestamo = new Prestamo();
	                prestamo.setPlazoPago(plazoPago);
	                prestamo.setPrestamoId(prestamoId);
	                prestamo.setCuotas(cuotaDao.listPorIdPrestamo(prestamo));
	                listPrestamos.add(prestamo);
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	
	        return listPrestamos;
	}
	
}
