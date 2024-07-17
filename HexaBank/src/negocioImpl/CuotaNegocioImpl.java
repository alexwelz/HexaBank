package negocioImpl;

import negocio.CuotaNegocio;

import java.util.ArrayList;

import daoImpl.CuotaDaoImpl;
import entidad.Cuota;
import entidad.Prestamo;


public class CuotaNegocioImpl implements CuotaNegocio {
	private CuotaDaoImpl cuotaDao = new CuotaDaoImpl();
	
	@Override
	public int update(int idCuota, String nroCuenta) {
		return cuotaDao.update(idCuota, nroCuenta);
	}

	@Override
	public ArrayList<Cuota> listPorIdPrestamo(Prestamo prestamo){
		return cuotaDao.listPorIdPrestamo(prestamo);
	}
	
}
