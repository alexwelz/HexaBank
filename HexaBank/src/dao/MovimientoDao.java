package dao;

import java.util.ArrayList;

import entidad.Movimiento;

public interface MovimientoDao {

	public ArrayList<Movimiento> listByNumeroCuenta(int numero_cuenta);
	
}
