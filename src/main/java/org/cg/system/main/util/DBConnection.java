package org.cg.system.main.util;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;
import org.cg.system.main.exceptions.DataAccessException;

/** Fabrica de conexiones JDBC. Lee credenciales de db.properties. */
public final class DBConnection {

    private static final Properties PROPS = new Properties();

    static {
        try (InputStream in = DBConnection.class.getResourceAsStream("/db.properties")) {
            if (in == null) {
                throw new IllegalStateException("No se encontro db.properties en resources");
            }
            PROPS.load(in);
        } catch (IOException e) {
            throw new ExceptionInInitializerError(e);
        }
    }

    private DBConnection() { }

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(
                    PROPS.getProperty("db.url"),
                    PROPS.getProperty("db.user"),
                    PROPS.getProperty("db.password"));
        } catch (SQLException e) {
            throw new DataAccessException("No se pudo conectar a MySQL", e);
        }
    }
}
