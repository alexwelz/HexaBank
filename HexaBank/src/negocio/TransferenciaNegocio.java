package negocio;


import java.math.BigDecimal;


public interface TransferenciaNegocio {
	public boolean insert(String cbuOrigen, String cbuDestino, String detalle, BigDecimal importe);
	
}
