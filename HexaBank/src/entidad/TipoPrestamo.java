package entidad;

import java.math.BigDecimal;

public class TipoPrestamo {
    private int tipoPrestamoId;
    private BigDecimal importeTotal;
    private BigDecimal importeIntereses;
    private int nroCuotas;
    private BigDecimal cuotaMensual;
    private BigDecimal interesAnual;
    
    
    public TipoPrestamo() {
        this.tipoPrestamoId = 0;
        this.importeTotal = new BigDecimal(0);
        this.importeIntereses = new BigDecimal(0);
        this.nroCuotas = 0;
        this.cuotaMensual = new BigDecimal(0);
        this.interesAnual = new BigDecimal(0);
    }
    
    public TipoPrestamo(int tipoPrestamoId, BigDecimal importeTotal, BigDecimal importeIntereses, int nroCuotas, BigDecimal cuotaMensual, BigDecimal interesAnual) {
        this.tipoPrestamoId = tipoPrestamoId;
        this.importeTotal = importeTotal;
        this.importeIntereses = importeIntereses;
        this.nroCuotas = nroCuotas;
        this.cuotaMensual = cuotaMensual;
        this.interesAnual = interesAnual;
    }
    public TipoPrestamo( BigDecimal importeTotal, BigDecimal importeIntereses, int nroCuotas, BigDecimal cuotaMensual) {
    	this.tipoPrestamoId = 0;
        this.importeTotal = importeTotal;
        this.importeIntereses = importeIntereses;
        this.nroCuotas = nroCuotas;
        this.cuotaMensual = cuotaMensual;
        this.interesAnual =  new BigDecimal(0);
    }


    // Getters y setters
    public int getTipoPrestamoId() {
        return tipoPrestamoId;
    }

    public void setTipoPrestamoId(int tipoPrestamoId) {
        this.tipoPrestamoId = tipoPrestamoId;
    }

    public BigDecimal getImporteTotal() {
        return importeTotal;
    }

    public void setImporteTotal(BigDecimal importeTotal) {
        this.importeTotal = importeTotal;
    }

    public BigDecimal getImporteIntereses() {
        return importeIntereses;
    }

    public void setImporteIntereses(BigDecimal importeIntereses) {
        this.importeIntereses = importeIntereses;
    }

    public int getNroCuotas() {
        return nroCuotas;
    }

    public void setNroCuotas(int nroCuotas) {
        this.nroCuotas = nroCuotas;
    }

    public BigDecimal getCuotaMensual() {
        return cuotaMensual;
    }

    public void setCuotaMensual(BigDecimal cuotaMensual) {
        this.cuotaMensual = cuotaMensual;
    }

    public BigDecimal getInteresAnual() {
        return interesAnual;
    }

    public void setInteresAnual(BigDecimal interesMensual) {
        this.interesAnual = interesMensual;
    }

	

	@Override
	public boolean equals(Object obj) {
		
		TipoPrestamo other = (TipoPrestamo) obj;
		
		if (
				cuotaMensual.equals(other.cuotaMensual)&&
				importeIntereses.equals(other.importeIntereses)&&
				importeTotal.equals(other.importeTotal)&&
				nroCuotas == other.nroCuotas
				
				)
		{
			return true;
		}
		return true;
	}
}
