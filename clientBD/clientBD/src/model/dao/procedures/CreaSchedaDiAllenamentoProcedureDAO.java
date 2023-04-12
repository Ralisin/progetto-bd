package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Credentials;
import model.domain.Esercizio;
import model.domain.SchedaDiAllenamento;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;

public class CreaSchedaDiAllenamentoProcedureDAO implements GenericProcedureDAO<SchedaDiAllenamento> {
    @Override
    public SchedaDiAllenamento execute(Object... params) throws DAOException {
        Credentials credentials = (Credentials) params[0];
        int clientID = (int) params[1];
        SchedaDiAllenamento schedaDiAllenamento = (SchedaDiAllenamento) params[2];

        try {
            Connection conn = ConnectionFactory.getConnection();
            // personalTrainerID, clienteID
            CallableStatement cs = conn.prepareCall("{call creaNuovaSchedaDiAllenamento(?, ?)}");
            cs.setInt(1, credentials.getId());
            cs.setInt(2, clientID);
            cs.execute();
        } catch (SQLException e) {
            throw new DAOException("creaNuovaSchedaDiAllenamento error: " + e.getMessage());
        }

        try {
            Connection conn = ConnectionFactory.getConnection();
            for(Esercizio esercizio : schedaDiAllenamento.getEserciziList()) {
                // personalTrainerID, clienteID, dataAssegnazione, nomeEsercizio, serie, ripetizioni, ordineNellaScheda
                CallableStatement cs = conn.prepareCall("{call inserisciEsercizioInScheda(?, ?, ?, ?, ?, ?, ?)}");
                cs.setInt(1, credentials.getId());
                cs.setInt(2, clientID);
                cs.setDate(3, schedaDiAllenamento.getDataAssegnazione());
                cs.setString(4, esercizio.getNomeEsercizio());
                cs.setInt(5, esercizio.getSerie());
                cs.setInt(6, esercizio.getRipetizioni());
                cs.setInt(7, esercizio.getOrdine());
                cs.execute();
            }
        } catch (SQLException e) {
            throw new DAOException("inserisciEsercizioInScheda error: " + e.getMessage());
        }

        return null;
    }
}
