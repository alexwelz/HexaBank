package exceptions;

public class sqlPagoPrestamosException extends Exception {

	private static final long serialVersionUID = 1L;

	public sqlPagoPrestamosException(String message) {
		super(message);
	}
	
	public sqlPagoPrestamosException(Throwable cause) {
		super(cause);
	}
}
