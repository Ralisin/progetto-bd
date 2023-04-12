package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Esercizio;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;

public class InserisciEsercizioProcedureDAO implements GenericProcedureDAO<Esercizio> {
    @Override
    public Esercizio execute(Object... params) throws DAOException {
        String nomeEsercizio = (String) params[0];
        String nomeMacchinario = (String) params[1];

        try {
            Connection conn = ConnectionFactory.getConnection();

            // nomeEsercizio, nomeMacchinario
            CallableStatement cs = conn.prepareCall("{call inserisciEsercizio(?, ?)}");
            cs.setString(1, nomeEsercizio);
            if(nomeMacchinario.equals(""))
                cs.setNull(2, Types.VARCHAR);
            else
                cs.setString(2, nomeMacchinario);
            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("inserisciEsercizio error: " + e.getMessage());
        }

        return null;
    }
}
