package entidad;

public class Usuario {
	private int usuarioId;
	private String nombreUsuario;
	private String password;
	private TipoUsuario tipoUsuario;

	public Usuario() {
		this.usuarioId = -1;
		this.nombreUsuario = "";
		this.password = "";
		this.tipoUsuario = new TipoUsuario();
	}
	
	public Usuario(int usuarioId, String nombreUsuario, String password, TipoUsuario tipoUsuario) {
		this.usuarioId = usuarioId;
		this.nombreUsuario = nombreUsuario;
		this.password = password;
		this.tipoUsuario = tipoUsuario;
	}
	
	public int getUsuarioId() {
		return usuarioId;
	}
	public void setUsuarioId(int usuarioId) {
		this.usuarioId = usuarioId;
	}
	public String getNombreUsuario() {
		return nombreUsuario;
	}
	public void setNombreUsuario(String nombreUsuario) {
		this.nombreUsuario = nombreUsuario;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public TipoUsuario getTipoUsuario() {
		return tipoUsuario;
	}
	public void setTipoUsuario(TipoUsuario tipoUsuario) {
		this.tipoUsuario = tipoUsuario;
	}
}
