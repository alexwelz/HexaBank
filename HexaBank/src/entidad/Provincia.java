package entidad;

public class Provincia {
	private int provinciaId;
	private String nombre;
	private Pais pais;

	public Provincia() {
		this.provinciaId = -1;
		this.nombre = "";
		this.pais = null;
	}
	
	public Provincia(int provinciaId, String nombre, Pais pais) {
		this.provinciaId = provinciaId;
		this.nombre = nombre;
		this.pais = pais;
	}
	
	public int getProvinciaId() {
		return provinciaId;
	}
	public void setProvinciaId(int provinciaId) {
		this.provinciaId = provinciaId;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
	public Pais getPais() {
		return pais;
	}
	public void setPais(Pais pais) {
		this.pais = pais;
	}
}
