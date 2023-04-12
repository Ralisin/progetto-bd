package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Credentials;
import model.domain.SessioneDiAllenamento;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class InserisciSessioneProcedureDAO implements GenericProcedureDAO<SessioneDiAllenamento> {
    @Override
    public SessioneDiAllenamento execute(Object... params) throws DAOException {
        SessioneDiAllenamento sessioneDiAllenamento = (SessioneDiAllenamento) params[0];
        Credentials credentials = (Credentials) params[1];

        try {
            Connection conn = ConnectionFactory.getConnection();

            // ClientID, DateSchedaDiAllenamento, PercentualeCompletamento, Durata, DataSessione
            CallableStatement cs = conn.prepareCall("{call inserisciSessione(?, ?, ?, ?, ?)}");
            cs.setInt(1, credentials.getId());
            cs.setDate(2, sessioneDiAllenamento.getDataSchedaDiAllenamento());
            cs.setFloat(3, sessioneDiAllenamento.getPercentualeCompletamento());
            cs.setTime(4, sessioneDiAllenamento.getDurata());
            cs.setDate(5, sessioneDiAllenamento.getDataSessione());
            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("inserisciSessione error: " + e.getMessage());
        }

        return null;
    }
}
