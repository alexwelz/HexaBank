package negocioImpl;

import java.math.BigDecimal;

import daoImpl.TransferenciaDaoImpl;
import negocio.TransferenciaNegocio;

public class TransferenciaNegocioImpl implements TransferenciaNegocio {
	
	TransferenciaDaoImpl aux = new TransferenciaDaoImpl();

	@Override
	public boolean insert(String cbuOrigen, String cbuDestino, String detalle, BigDecimal importe) {	
		return aux.insert(cbuOrigen, cbuDestino, detalle, importe);
	}

}
