package org.cg.system.main.controller;

import javafx.collections.FXCollections;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import org.cg.system.main.dao.PacienteDAO;
import org.cg.system.main.dao.impl.PacienteDAOImpl;
import org.cg.system.main.model.Paciente;

public class MainController {

    @FXML private TableView<Paciente> tblPacientes;
    @FXML private TableColumn<Paciente, String> colDpi;
    @FXML private TableColumn<Paciente, String> colNombres;
    @FXML private TableColumn<Paciente, String> colApellidos;
    @FXML private TableColumn<Paciente, String> colTelefono;
    @FXML private Label lblEstado;

    private final PacienteDAO pacienteDAO = new PacienteDAOImpl();

    @FXML
    public void initialize() {
        colDpi.setCellValueFactory(new PropertyValueFactory<>("dpi"));
        colNombres.setCellValueFactory(new PropertyValueFactory<>("nombres"));
        colApellidos.setCellValueFactory(new PropertyValueFactory<>("apellidos"));
        colTelefono.setCellValueFactory(new PropertyValueFactory<>("telefono"));
        cargar();
    }

    @FXML
    private void cargar() {
        try {
            tblPacientes.setItems(FXCollections.observableArrayList(pacienteDAO.listar()));
            lblEstado.setText("Conectado - " + tblPacientes.getItems().size() + " pacientes");
        } catch (RuntimeException e) {
            lblEstado.setText("Error: " + e.getMessage());
        }
    }
}
