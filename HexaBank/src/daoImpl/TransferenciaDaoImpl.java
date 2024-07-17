package daoImpl;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.mysql.jdbc.CallableStatement;

import dao.TransferenciaDao;
import entidad.Transferencia;

import java.sql.Date;


public class TransferenciaDaoImpl implements TransferenciaDao {

    private static final String call = "CALL SP_TRANSFERENCIAS(?, ?, ?, ?)";

    @Override
    public boolean insert(String cbuOrigen, String cbuDestino, String detalle, BigDecimal importe) {
        try {
            Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        CallableStatement statement = null;
        Connection conexion = Conexion.getConexion().getSQLConexion();
        boolean isInsertExitoso = false;

        try {
            statement = (CallableStatement) conexion.prepareCall(call);
            statement.setString(1, cbuOrigen);
            statement.setString(2, cbuDestino);
            statement.setBigDecimal(3, importe);
            statement.setString(4, detalle);

            statement.execute();

            conexion.commit();
            isInsertExitoso = true;
            
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                conexion.rollback();
                isInsertExitoso=false;
            } catch (SQLException e1) {
                e1.printStackTrace();
            }
        } 
        
        return isInsertExitoso;
    }
}

	

