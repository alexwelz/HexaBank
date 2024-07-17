package negocioImpl;

import java.util.ArrayList;
import daoImpl.LocalidadDaoImpl;
import entidad.Localidad;
import negocio.LocalidadNegocio;

public class LocalidadNegocioImpl implements LocalidadNegocio {

    private LocalidadDaoImpl LocalidadDao = new LocalidadDaoImpl();

    @Override
    public Localidad get(int idLocalidad) {
        return LocalidadDao.get(idLocalidad);
    }

    @Override
    public ArrayList<Localidad> list() {
        return LocalidadDao.list();
    }

}
