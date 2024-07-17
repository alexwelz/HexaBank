package entidad;

import java.math.BigDecimal;
import java.sql.Date;

public class Cuenta {

	private Cliente cliente;
	private Date fechaCreacion;
	private String tipoCuenta;
	private int numeroCuenta;
	private String cbu;
	private BigDecimal saldo;
	private boolean estado;
    
	public Cuenta() {
		this.cliente = null;
		this.fechaCreacion = Date.valueOf("1900-01-01");
		this.tipoCuenta = "";
		this.setNumeroCuenta(-1);
		this.cbu = "";
		this.saldo = new BigDecimal("0");
	}
	
	public Cuenta(Cliente cliente, Date fechaCreacion, String tipoCuenta, int numeroCuenta,
			String cbu, BigDecimal saldo, boolean estado) {
		this.cliente = cliente;
		this.fechaCreacion = fechaCreacion;
		this.tipoCuenta = tipoCuenta;
		this.setNumeroCuenta(numeroCuenta);
		this.cbu = cbu;
		this.saldo = saldo;
		this.estado = true;
	}
	

	public Cliente getCliente() {
		return cliente;
	}
	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	public Date getFechaCreacion() {
		return fechaCreacion;
	}
	public void setFechaCreacion(Date fechaCreacion) {
		this.fechaCreacion = fechaCreacion;
	}
	public String getTipoCuenta() {
		return tipoCuenta;
	}
	public void setTipoCuenta(String tipoCuenta) {
		this.tipoCuenta = tipoCuenta;
	}

	public String getCbu() {
		return cbu;
	}
	public void setCbu(String cbu) {
		this.cbu = cbu;
	}
	public BigDecimal getSaldo() {
		return saldo;
	}
	public void setSaldo(BigDecimal saldo) {
		this.saldo = saldo;
	}

	public boolean getEstado() {
		return estado;
	}

	public void setEstado(boolean estado) {
		this.estado = estado;
	}

	public int getNumeroCuenta() {
		return numeroCuenta;
	}

	public void setNumeroCuenta(int numeroCuenta) {
		this.numeroCuenta = numeroCuenta;
	}
    
    
}
