package exceptions;

public class matchLocacionException extends RuntimeException {
	public matchLocacionException(String message) {
		super(message);
	}
	
	public matchLocacionException(Throwable cause) {
		super(cause);
	}

}
