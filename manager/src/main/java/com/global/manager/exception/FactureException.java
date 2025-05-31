package com.global.manager.exception;

public class FactureException extends RuntimeException {
    
    public FactureException(String message) {
        super(message);
    }

    public FactureException(String message, Throwable cause) {
        super(message, cause);
    }
} 