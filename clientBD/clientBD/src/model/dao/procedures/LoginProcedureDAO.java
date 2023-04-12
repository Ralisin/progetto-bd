package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Credentials;
import model.domain.Role;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class LoginProcedureDAO implements GenericProcedureDAO<Credentials> {
    public Credentials execute(Object... params) throws DAOException {
        String nome = (String) params[0];
        String cognome = (String) params[1];
        String password = (String) params[2];
        int role;
        int id;

        try {
            Connection conn = ConnectionFactory.getConnection();

            CallableStatement cs = conn.prepareCall("{call login(?,?,?,?,?)}");
            cs.setString(1, nome);
            cs.setString(2, cognome);
            cs.setString(3, password);
            cs.registerOutParameter(4, Types.NUMERIC);
            cs.registerOutParameter(5, Types.NUMERIC);
            cs.executeQuery();

            role = cs.getInt(4);
            id = cs.getInt(5);
        } catch (SQLException e) {
            throw new DAOException("Login error: " + e.getMessage());
        }

        return new Credentials(nome, cognome, password, Role.fromInt(role), id);
    }
}
