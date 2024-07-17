package negocio;

import java.util.ArrayList;

import entidad.Localidad;

public interface LocalidadNegocio {
	
	public Localidad get(int idLocalidad);
	public ArrayList<Localidad> list();
}

