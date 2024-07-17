package negocio;

import java.util.ArrayList;

import entidad.Movimiento;

public interface MovimientosNegocio {

	public ArrayList<Movimiento> listByNumeroCuenta(int numero_cuenta);
	
}
