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
