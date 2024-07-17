package negocioImpl;

import java.util.ArrayList;
import daoImpl.PaisDaoImpl;
import entidad.Pais;
import negocio.PaisNegocio;

public class PaisNegocioImpl implements PaisNegocio {

    private PaisDaoImpl PaisDaoImpl = new PaisDaoImpl();


    @Override
    public Pais get(int id_pais) {
        return PaisDaoImpl.get(id_pais);
    }

    @Override
    public ArrayList<Pais> list() {
        return PaisDaoImpl.list();
    }

}
