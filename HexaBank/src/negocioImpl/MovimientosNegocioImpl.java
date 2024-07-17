package negocioImpl;

import java.util.ArrayList;

import entidad.Movimiento;
import negocio.MovimientosNegocio;
import daoImpl.MovimientoDaoImpl;

public class MovimientosNegocioImpl implements MovimientosNegocio {
	
	private MovimientoDaoImpl movimientoDaoImpl = new MovimientoDaoImpl();

	@Override
	public ArrayList<Movimiento> listByNumeroCuenta(int numero_cuenta) {
		return movimientoDaoImpl.listByNumeroCuenta(numero_cuenta);
	}

}
