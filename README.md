# Clínica Médica SaludVital
MySQL 8 · JavaFX 21 · DAO Pattern · Paquete base: `org.cg.system.main`

## Puesta en marcha
1. Ejecutar en MySQL, en orden: `sql/01_schema.sql`, `sql/02_stored_procedures.sql`, `sql/03_seeders.sql`
2. Editar `src/main/resources/db.properties` (copiado de `db.properties.example`)
3. `mvn clean javafx:run`

## Estructura
```
org.cg.system.main
├── Main.java
├── model/        entidades
├── dao/          interfaces DAO
├── dao/impl/     implementaciones JDBC (CALL sp_*)
├── controller/   controladores JavaFX
├── view/         clases de vista (FXML en resources)
├── util/         DBConnection
└── exceptions/   DataAccessException
```

## Apache NetBeans (21 o superior) + JDK 21
1. `File > Open Project...` y elegir la carpeta `saludvital-clinica` (se detecta como proyecto Maven).
2. Verificar el JDK: `Tools > Java Platforms` debe tener JDK 21 (o superior).
3. Clic derecho al proyecto > `Build with Dependencies` (descarga JavaFX y MySQL Connector).
4. Ejecutar la BD (`sql/*.sql`) y ajustar `src/main/resources/db.properties`.
5. Botón **Run** (F6) o **Debug** (Ctrl+F5): `nbactions.xml` lo redirige a `javafx:run`.
