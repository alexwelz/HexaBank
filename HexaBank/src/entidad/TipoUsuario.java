package entidad;

public class TipoUsuario {
    private int tipo_usuario_id;
    private String tipo_usuario;

    public TipoUsuario() {
        this.tipo_usuario_id = 0;
        this.tipo_usuario = "";
    }

    public TipoUsuario(int tipo_usuario_id, String tipo_usuario){
        this.tipo_usuario_id = tipo_usuario_id;
        this.tipo_usuario = tipo_usuario;
    }

    public int getTipoUsuarioId() {
        return tipo_usuario_id;
    }

    public void setTipoUsuarioId(int tipo_usuario_id) {
        this.tipo_usuario_id = tipo_usuario_id;
    }

    public String getTipoUsuario() {
        return tipo_usuario;
    }

    public void setTipoUsuario(String tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }
    
}
