package entidad;

public class Localidad {
	private int localidadId;
	private String nombre;
	private Provincia provincia;
    
	public Localidad() {
		this.localidadId = -1;
		this.nombre = "";
		this.provincia = null;
	}
	
	public Localidad(int localidadId, String nombre, Provincia provincia) {
		this.localidadId = localidadId;
		this.nombre = nombre;
		this.provincia = provincia;
	}
	
	public int getLocalidadId() {
		return localidadId;
	}
	public void setLocalidadId(int localidadId) {
		this.localidadId = localidadId;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public Provincia getProvincia() {
		return provincia;
	}
	public void setProvincia(Provincia provincia) {
		this.provincia = provincia;
	}
}
