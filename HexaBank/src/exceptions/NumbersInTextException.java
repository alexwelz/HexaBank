package exceptions;

public class NumbersInTextException extends Exception {
	public NumbersInTextException(String message) {
		super(message);
	}
	
	public NumbersInTextException(Throwable cause) {
		super(cause);
	}
}
