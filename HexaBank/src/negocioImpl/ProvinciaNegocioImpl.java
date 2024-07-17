package negocioImpl;

import java.util.ArrayList;
import daoImpl.ProvinciaDaoImpl;
import entidad.Provincia;
import negocio.ProvinciaNegocio;

public class ProvinciaNegocioImpl implements ProvinciaNegocio {

    private ProvinciaDaoImpl ProvinciaDao = new ProvinciaDaoImpl();

    @Override
    public Provincia get(int id_provincia) {
        return ProvinciaDao.get(id_provincia);
    }

    @Override
    public ArrayList<Provincia> list() {
        return ProvinciaDao.list();
    }

}
