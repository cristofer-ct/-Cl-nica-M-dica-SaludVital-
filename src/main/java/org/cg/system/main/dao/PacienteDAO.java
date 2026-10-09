package org.cg.system.main.dao;

import java.util.List;
import java.util.Optional;
import org.cg.system.main.model.Paciente;

public interface PacienteDAO {
    int insertar(Paciente paciente);
    void actualizar(Paciente paciente);
    void eliminar(int idPaciente);
    Optional<Paciente> buscarPorId(int idPaciente);
    List<Paciente> listar();
}
