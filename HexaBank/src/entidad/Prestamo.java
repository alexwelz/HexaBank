
package entidad;

import java.sql.Date;
import java.util.ArrayList;

public class Prestamo {
	private int prestamoId;
	private Cuenta cuenta;
	private Cliente cliente;
    private TipoPrestamo tipoPrestamo;
    private Date fecha;
    private int plazoPago;
    private String estado;
    private ArrayList<Cuota> cuotas = new ArrayList<Cuota>();

	public Prestamo() {
		this.prestamoId = -1;
		this.cuenta = null;
		this.cliente = null;
		this.tipoPrestamo = null;
		this.fecha = Date.valueOf("1900-01-01");
		this.estado = "En proceso";
		this.plazoPago = -1;
	}
	
	public Prestamo(int prestamoId, Cuenta cuenta, Cliente cliente, TipoPrestamo tipoPrestamo, Date fecha, String estado,int plazopago) {
		this.prestamoId = prestamoId;
		this.cuenta =cuenta;
		this.cliente = cliente;
		this.tipoPrestamo = tipoPrestamo;
		this.fecha = fecha;
		this.estado = estado;
		this.plazoPago = plazopago;
	}
	public Prestamo( Cuenta cuenta, TipoPrestamo tipoPrestamo, Date fecha, String estado,int plazopago) {
		
		this.cuenta = cuenta;
		this.tipoPrestamo = tipoPrestamo;
		this.fecha = fecha;
		this.estado = estado;
		this.plazoPago = plazopago;
	}
	
	public int getPrestamoId() {
		return prestamoId;
	}
	public void setPrestamoId(int prestamoId) {
		this.prestamoId = prestamoId;
	}
	public TipoPrestamo getTipoPrestamo() {
		return tipoPrestamo;
	}
	public void setTipoPrestamo(TipoPrestamo tipoPrestamo) {
		this.tipoPrestamo = tipoPrestamo;
	}
	public Date getFecha() {
		return fecha;
	}
	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}
	public String getEstado() {
		return estado;
	}
	public void setEstado (String estado) {
		this.estado = estado;
	}

	public int getPlazoPago() {
		return plazoPago;
	}

	public void setPlazoPago(int plazoPago) {
		this.plazoPago = plazoPago;
	}

	public Cuenta getCuenta() {
		return cuenta;
	}

	public void setCuenta(Cuenta cuenta) {
		this.cuenta = cuenta;
	}

	public Cliente getCliente() {
		return cliente;
	}

	public void setCliente(Cliente cliente) {
		this.cliente = cliente;
	}
	
	public ArrayList<Cuota> getCuotas() {
		return cuotas;
	}

	public void setCuotas(ArrayList<Cuota> cuotas) {
		this.cuotas = cuotas;
	}
}
