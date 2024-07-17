package negocioImpl;

import daoImpl.TipoUsuarioDaoImpl;
import entidad.TipoUsuario;
import negocio.TipoUsuarioNegocio;

public class TipoUsuarioNegocioImpl implements TipoUsuarioNegocio {

    private TipoUsuarioDaoImpl tipoUsuarioDao = new TipoUsuarioDaoImpl();

	@Override
	public TipoUsuario get(int tipo_usuario_id) {
		return tipoUsuarioDao.get(tipo_usuario_id);
	}
}
