package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Esercizio;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class RimuoviMacchinarioProcedureDAO implements GenericProcedureDAO<Esercizio> {
    @Override
    public Esercizio execute(Object... params) throws DAOException {
        String nomeMacchinario = (String) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();

            // nomeEsercizio, nomeMacchinario
            CallableStatement cs = conn.prepareCall("{call rimuoviMacchinario(?)}");
            cs.setString(1, nomeMacchinario);
            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("rimuoviMacchinario error: " + e.getMessage());
        }

        return null;
    }
}
