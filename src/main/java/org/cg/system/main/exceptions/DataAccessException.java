package org.cg.system.main.exceptions;

/** Excepcion de la capa de acceso a datos (envuelve SQLException). */
public class DataAccessException extends RuntimeException {
    public DataAccessException(String message, Throwable cause) {
        super(message, cause);
    }
}
