package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Esercizio;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class RimuoviEsercizioProcedureDAO implements GenericProcedureDAO<Esercizio> {
    @Override
    public Esercizio execute(Object... params) throws DAOException {
        String nomeEsercizio = (String) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();

            // nomeEsercizio, nomeMacchinario
            CallableStatement cs = conn.prepareCall("{call rimuoviEsercizio(?)}");
            cs.setString(1, nomeEsercizio);
            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("rimuoviEsercizio error: " + e.getMessage());
        }


        return null;
    }
}
