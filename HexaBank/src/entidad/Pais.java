package entidad;

public class Pais {
	private int paisId;
	private String nombre;

	public Pais() {
		this.paisId = -1;
		this.nombre = "";
	}
	
	public Pais(int paisId, String nombre) {
		this.paisId = paisId;
		this.nombre = nombre;
	}
	
	public int getPaisId() {
		return paisId;
	}
	public void setPaisId(int paisId) {
		this.paisId = paisId;
	}
	public String getNombre() {
		return nombre;
	}
	public void setNombre(String nombre) {
		this.nombre = nombre;
	}
}
