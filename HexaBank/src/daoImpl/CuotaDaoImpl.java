package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.StringJoiner;

import com.mysql.jdbc.CallableStatement;

import dao.CuotaDao;
import entidad.Cuota;
import entidad.Prestamo;

public class CuotaDaoImpl implements CuotaDao {

    //private static final String update = "UPDATE cuotas SET fecha_pago = ? WHERE cuota_id = ?";
    private static final String listPorIdPrestamo = "SELECT * FROM cuotas WHERE fecha_pago is null AND prestamo_id = ?";
    private static final String call = "CALL SP_PAGO_CUOTA(?, ?)";

    //@Override
    /*public boolean update(Cuota cuota) {
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
            statement.setString(1, );

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
    }*/
    
	@Override
	public ArrayList<Cuota> listPorIdPrestamo(Prestamo prestamo) {
		 try {
		        Class.forName("com.mysql.jdbc.Driver");
		    } catch (ClassNotFoundException e) {
		        e.printStackTrace();
		    }
		    
		    ArrayList<Cuota> listaCuotas = new ArrayList<>();    
		    PreparedStatement statement;
	        Connection conexion = Conexion.getConexion().getSQLConexion();
		    try {

		        statement = conexion.prepareStatement(listPorIdPrestamo);
		        statement.setInt(1, prestamo.getPrestamoId());
		        ResultSet resultSet = statement.executeQuery();
		        
		        while (resultSet.next()) {
		        	int cuotaId = resultSet.getInt("cuota_id");
	                int numeroCuota = resultSet.getInt("numero_cuota");
	                java.sql.Date fechaVencimiento = resultSet.getDate("fecha_vencimiento");
	                BigDecimal importe = resultSet.getBigDecimal("importe");
	                java.sql.Date fechaPago = resultSet.getDate("fecha_pago");
	                	                
	                Cuota cuota = new Cuota(cuotaId, numeroCuota, fechaVencimiento, importe, fechaPago);
		            
		            listaCuotas.add(cuota);
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    
		    return listaCuotas;
	}

	public int update(int idCuota, String nroCuenta) {
   	 try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        CallableStatement statement = null;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        int isExitoso = 1;

        try {
            statement = (CallableStatement) conexion.prepareCall(call);
            statement.setInt(1, idCuota);
            statement.setString(2, nroCuenta);

            statement.execute();

            conexion.commit();
            isExitoso = 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conexion.rollback();
                isExitoso=Integer.parseInt(e.getSQLState());

            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } 
        
        return isExitoso;
    }

}
