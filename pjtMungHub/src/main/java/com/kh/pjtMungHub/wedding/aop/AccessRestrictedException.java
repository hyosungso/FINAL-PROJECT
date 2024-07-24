package com.kh.pjtMungHub.wedding.aop;

import java.time.LocalDateTime;

public class AccessRestrictedException extends RuntimeException {
	private LocalDateTime restrictedUntil;
	
	public AccessRestrictedException(String message, LocalDateTime restrictedUntil) {
		super(message);
		this.restrictedUntil = restrictedUntil;
	}
	
	public LocalDateTime getRestrictedUntil() {
		return restrictedUntil;
	}
}
