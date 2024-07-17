package negocio;

import java.util.ArrayList;

import entidad.Provincia;

public interface ProvinciaNegocio {
	
	
	public Provincia get(int idProvincia);
	public ArrayList<Provincia> list();
	
}
