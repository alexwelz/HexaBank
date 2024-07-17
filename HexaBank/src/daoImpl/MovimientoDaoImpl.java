package daoImpl;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import entidad.Movimiento;
import dao.MovimientoDao;
import daoImpl.CuentaDaoImpl;

public class MovimientoDaoImpl implements MovimientoDao{

	private static final String listByNumeroCuenta = "SELECT * FROM movimientos where numero_cuenta = ?";

	@Override
	public ArrayList<Movimiento> listByNumeroCuenta(int numero_cuenta) {
		try 
    	{
    		Class.forName("com.mysql.jdbc.Driver");
    	}catch (ClassNotFoundException e){
    		e.printStackTrace();
    	}
		ArrayList<Movimiento> lista_movimientos = new ArrayList<Movimiento>();
		PreparedStatement statement;
		try {
			Connection conexion = Conexion.getConexion().getSQLConexion();
			statement = conexion.prepareStatement(listByNumeroCuenta);
			statement.setInt(1, numero_cuenta);
			ResultSet result_set = statement.executeQuery();
			while(result_set.next()) {
				CuentaDaoImpl cuentaDaoImpl = new CuentaDaoImpl();
				Movimiento movimiento = new Movimiento(
						result_set.getInt("movimiento_id"),
						cuentaDaoImpl.get(result_set.getInt("numero_cuenta")),
						result_set.getDate("fecha"),
						result_set.getString("detalle"),
						result_set.getBigDecimal("importe"),
						result_set.getString("tipo_movimiento")
					);
				lista_movimientos.add(movimiento);
			}
		}
		catch(Exception e) {
			e.printStackTrace();
		}
		
		return lista_movimientos;
	}
}
