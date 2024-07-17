package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import dao.TipoPrestamoDao;
import entidad.TipoPrestamo;

public class TipoPrestamoDaoImpl implements TipoPrestamoDao {
	
	private static final String get = "SELECT * FROM tipos_prestamo WHERE importe_total = ? and nro_cuotas = ?";
    private static final String getbyId = "SELECT * FROM tipos_prestamo WHERE tipo_prestamo_id = ?";
    

    //private static final String list = "SELECT * FROM tipos_prestamo";
    
    
    @Override
    public TipoPrestamo get(int cuotas, BigDecimal monto) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        
        try {
            statement = conexion.prepareStatement(get);
            statement.setBigDecimal(1, monto);
            statement.setInt(2, cuotas);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                TipoPrestamo tipoPrestamo = new TipoPrestamo(
                    resultSet.getInt("tipo_prestamo_id"),
                    resultSet.getBigDecimal("importe_total"),
                    resultSet.getBigDecimal("importe_intereses"),
                    resultSet.getInt("nro_cuotas"),
                    resultSet.getBigDecimal("cuota_mensual"),
                    resultSet.getBigDecimal("interes_anual")
                );
                return tipoPrestamo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public TipoPrestamo get(int tipoprestamoid) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        PreparedStatement statement;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        
        try {
            statement = conexion.prepareStatement(getbyId);
            statement.setInt(1, tipoprestamoid);
            ResultSet resultSet = statement.executeQuery();
            
            if (resultSet.next()) {
                TipoPrestamo tipoPrestamo = new TipoPrestamo(
                    resultSet.getInt("tipo_prestamo_id"),
                    resultSet.getBigDecimal("importe_total"),
                    resultSet.getBigDecimal("importe_intereses"),
                    resultSet.getInt("nro_cuotas"),
                    resultSet.getBigDecimal("cuota_mensual"),
                    resultSet.getBigDecimal("interes_anual")
                );
                return tipoPrestamo;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
}
