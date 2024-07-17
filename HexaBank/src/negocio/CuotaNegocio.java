package negocio;

import java.util.ArrayList;

import entidad.Cuota;
import entidad.Prestamo;

public interface CuotaNegocio {
	
	public int update(int idCuota, String nroCuenta);
	
	public ArrayList<Cuota> listPorIdPrestamo(Prestamo prestamo);
}
