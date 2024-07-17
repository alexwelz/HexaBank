package entidad;

import java.math.BigDecimal;
import java.sql.Date;

public class Transferencia {
    private int IdTransferencia;
    private String dni;
    private String cbuOrigen;
    private String cbuDestino;
    private Date fecha;
    private String Detalle;
    private int IdMovimiento;
    private BigDecimal importe;

    public Transferencia() {

	}
    
    public Transferencia(int idTransferencia, String dni, String cbuOrigen, String cbuDestino, Date fecha,
			String detalle, int idMovimiento, BigDecimal importe) {
	
		IdTransferencia = idTransferencia;
		this.dni = dni;
		this.cbuOrigen = cbuOrigen;
		this.cbuDestino = cbuDestino;
		this.fecha = fecha;
		Detalle = detalle;
		IdMovimiento = idMovimiento;
		this.importe = importe;
	}

	
	public int getIdTransferencia() {
		return IdTransferencia;
	}

	public void setIdTransferencia(int idTransferencia) {
		IdTransferencia = idTransferencia;
	}

	public String getCbuOrigen() {
		return cbuOrigen;
	}

	public void setCbuOrigen(String cbuOrigen) {
		this.cbuOrigen = cbuOrigen;
	}

	public String getCbuDestino() {
		return cbuDestino;
	}

	public void setCbuDestino(String cbuDestino) {
		this.cbuDestino = cbuDestino;
	}

	public BigDecimal getImporte() {
		return importe;
	}

	public void setImporte(BigDecimal importe) {
		this.importe = importe;
	}

	public int getIdMovimiento() {
		return IdMovimiento;
	}

	public void setIdMovimiento(int idMovimiento) {
		IdMovimiento = idMovimiento;
	}

	public String getDetalle() {
		return Detalle;
	}

	public void setDetalle(String detalle) {
		Detalle = detalle;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public String getDni() {
		return dni;
	}

	public void setDni(String dni) {
		this.dni = dni;
	}
    
	
}
