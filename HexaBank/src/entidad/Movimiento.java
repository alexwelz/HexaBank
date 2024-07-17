package entidad;

import java.math.BigDecimal;
import java.sql.Date;

public class Movimiento {
	private int movimientoId;
	private Cuenta cuenta;
	private Date fecha;
	private String detalle;
	private BigDecimal importe;
	private String tipoMovimiento;
    
	public Movimiento() {
		this.movimientoId = -1;
		this.cuenta = null;
		this.fecha = Date.valueOf("1900-01-01");
		this.detalle = "";
		this.importe = new BigDecimal("0");
		this.tipoMovimiento = "";
	}
	
	public Movimiento(int movimientoId, Cuenta cuenta, Date fecha, String detalle, BigDecimal importe,
			String tipoMovimiento) {
		this.movimientoId = movimientoId;
		this.cuenta = cuenta;
		this.fecha = fecha;
		this.detalle = detalle;
		this.importe = importe;
		this.tipoMovimiento = tipoMovimiento;
	}
	
	public int getMovimientoId() {
		return movimientoId;
	}
	public void setMovimientoId(int movimientoId) {
		this.movimientoId = movimientoId;
	}
	public Cuenta getCuenta() {
		return cuenta;
	}
	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getDetalle() {
		return detalle;
	}
	public void setDetalle(String detalle) {
		this.detalle = detalle;
	}
	public BigDecimal getImporte() {
		return importe;
	}
	public void setImporte(BigDecimal importe) {
		this.importe = importe;
	}
	public String getTipoMovimiento() {
		return tipoMovimiento;
	}
	public void setTipoMovimiento(String tipoMovimiento) {
		this.tipoMovimiento = tipoMovimiento;
	}
}
