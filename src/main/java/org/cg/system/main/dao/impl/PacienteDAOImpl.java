package org.cg.system.main.dao.impl;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import org.cg.system.main.dao.PacienteDAO;
import org.cg.system.main.exceptions.DataAccessException;
import org.cg.system.main.model.Paciente;
import org.cg.system.main.util.DBConnection;

/** DAO de Paciente: escrituras via Stored Procedures, lecturas via vista. */
public class PacienteDAOImpl implements PacienteDAO {

    @Override
    public int insertar(Paciente p) {
        String sql = "{CALL sp_insertar_paciente(?,?,?,?,?,?,?,?)}";
        try (Connection cn = DBConnection.getConnection();
             CallableStatement cs = cn.prepareCall(sql)) {
            cs.setString(1, p.getDpi());
            cs.setString(2, p.getNombres());
            cs.setString(3, p.getApellidos());
            cs.setDate(4, Date.valueOf(p.getFechaNacimiento()));
            cs.setString(5, p.getTelefono());
            cs.setString(6, p.getEmail());
            cs.setString(7, p.getDireccion());
            cs.registerOutParameter(8, Types.INTEGER);
            cs.execute();
            int id = cs.getInt(8);
            p.setIdPaciente(id);
            return id;
        } catch (SQLException e) {
            throw new DataAccessException("Error al insertar paciente", e);
        }
    }

    @Override
    public void actualizar(Paciente p) {
        String sql = "{CALL sp_actualizar_paciente(?,?,?,?,?,?,?,?)}";
        try (Connection cn = DBConnection.getConnection();
             CallableStatement cs = cn.prepareCall(sql)) {
            cs.setInt(1, p.getIdPaciente());
            cs.setString(2, p.getDpi());
            cs.setString(3, p.getNombres());
            cs.setString(4, p.getApellidos());
            cs.setDate(5, Date.valueOf(p.getFechaNacimiento()));
            cs.setString(6, p.getTelefono());
            cs.setString(7, p.getEmail());
            cs.setString(8, p.getDireccion());
            cs.execute();
        } catch (SQLException e) {
            throw new DataAccessException("Error al actualizar paciente", e);
        }
    }

    @Override
    public void eliminar(int idPaciente) {
        try (Connection cn = DBConnection.getConnection();
             CallableStatement cs = cn.prepareCall("{CALL sp_eliminar_paciente(?)}")) {
            cs.setInt(1, idPaciente);
            cs.execute();
        } catch (SQLException e) {
            throw new DataAccessException("Error al eliminar paciente", e);
        }
    }

    @Override
    public Optional<Paciente> buscarPorId(int idPaciente) {
        String sql = "SELECT * FROM vw_pacientes WHERE id_paciente = ?";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql)) {
            ps.setInt(1, idPaciente);
            try (ResultSet rs = ps.executeQuery()) {
                return rs.next() ? Optional.of(map(rs)) : Optional.empty();
            }
        } catch (SQLException e) {
            throw new DataAccessException("Error al buscar paciente", e);
        }
    }

    @Override
    public List<Paciente> listar() {
        List<Paciente> lista = new ArrayList<>();
        String sql = "SELECT * FROM vw_pacientes ORDER BY apellidos, nombres";
        try (Connection cn = DBConnection.getConnection();
             PreparedStatement ps = cn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                lista.add(map(rs));
            }
            return lista;
        } catch (SQLException e) {
            throw new DataAccessException("Error al listar pacientes", e);
        }
    }

    private Paciente map(ResultSet rs) throws SQLException {
        return new Paciente(
                rs.getInt("id_paciente"),
                rs.getString("dpi"),
                rs.getString("nombres"),
                rs.getString("apellidos"),
                rs.getDate("fecha_nacimiento").toLocalDate(),
                rs.getString("telefono"),
                rs.getString("email"),
                rs.getString("direccion"));
    }
}
