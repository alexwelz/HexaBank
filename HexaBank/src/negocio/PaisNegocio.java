package negocio;

import java.util.ArrayList;

import entidad.Pais;

public interface PaisNegocio {
	
	public Pais get(int idPais);
	public ArrayList<Pais> list();
	
}
