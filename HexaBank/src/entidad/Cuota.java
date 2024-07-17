package entidad;

import java.math.BigDecimal;
import java.sql.Date;

public class Cuota {
	private int cuotaId;
	private int numeroCuota;
	private Date fechaVencimiento;
	private BigDecimal importe;
	private Date fechaPago;
    
    public Cuota() {
		this.cuotaId = -1;
		this.numeroCuota = 0;
		this.fechaVencimiento = Date.valueOf("1900-01-01");
		this.importe = new BigDecimal("0");
		this.fechaPago = Date.valueOf("1900-01-01");
	}
    
    public Cuota(int cuotaId, int numeroCuota, Date fechaVencimiento, BigDecimal importe,
		Date fechaPago) {
		this.cuotaId = cuotaId;
		this.numeroCuota = numeroCuota;
		this.fechaVencimiento = fechaVencimiento;
		this.importe = importe;
		this.fechaPago = fechaPago;
	}
    
	public int getCuotaId() {
		return cuotaId;
	}
	public void setCuotaId(int cuotaId) {
		this.cuotaId = cuotaId;
	}
	public int getNumeroCuota() {
		return numeroCuota;
	}
	public void setNumeroCuota(int numeroCuota) {
		this.numeroCuota = numeroCuota;
	}
	public Date getFechaVencimiento() {
		return fechaVencimiento;
	}
	public void setFechaVencimiento(Date fechaVencimiento) {
		this.fechaVencimiento = fechaVencimiento;
	}
	public BigDecimal getImporte() {
		return importe;
	}
	public void setImporte(BigDecimal importe) {
		this.importe = importe;
	}
	public Date getFechaPago() {
		return fechaPago;
	}
	public void setFechaPago(Date fechaPago) {
		this.fechaPago = fechaPago;
	} 
}
