package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Credentials;
import model.domain.Esercizio;
import model.domain.SchedaDiAllenamento;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VediSchedaDiAllenamentoProcedureDAO implements GenericProcedureDAO<SchedaDiAllenamento> {
    @Override
    public SchedaDiAllenamento execute(Object... params) throws DAOException {
        SchedaDiAllenamento schedaDiAllenamento = new SchedaDiAllenamento();

        Credentials credentials = (Credentials) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call vediSchedaDiAllenamento(?)}");
            cs.setInt(1, credentials.getId());
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while(rs.next()) {
                    schedaDiAllenamento.setDataAssegnazione(rs.getDate(1));

                    Esercizio esercizio = new Esercizio(rs.getInt(2), rs.getString(3), rs.getInt(4), rs.getInt(5));
                    schedaDiAllenamento.addEsercizio(esercizio);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("vediSchedaDiAllenamento error: " + e.getMessage());
        }

        return schedaDiAllenamento;
    }
}
