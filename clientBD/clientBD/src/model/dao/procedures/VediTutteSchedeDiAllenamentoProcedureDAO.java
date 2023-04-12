package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Credentials;
import model.domain.Esercizio;
import model.domain.ListSchedaDiAllenamento;
import model.domain.SchedaDiAllenamento;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VediTutteSchedeDiAllenamentoProcedureDAO implements GenericProcedureDAO<ListSchedaDiAllenamento> {
    @Override
    public ListSchedaDiAllenamento execute(Object... params) throws DAOException {
        ListSchedaDiAllenamento listSchedaDiAllenamento = new ListSchedaDiAllenamento();

        Credentials credentials = (Credentials) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs =conn.prepareCall("{call vediTutteLeSchedeDiAllenamento(?)}");
            cs.setInt(1, credentials.getId());
            boolean status = cs.execute();

            ResultSet rs;

            do {
                if(status) {
                    rs = cs.getResultSet();
                    SchedaDiAllenamento schedaDiAllenamento = new SchedaDiAllenamento();

                    while(rs.next()) {
                        schedaDiAllenamento.setDataAssegnazione(rs.getDate(1));

                        Esercizio esercizio = new Esercizio(rs.getInt(2), rs.getString(3), rs.getInt(4), rs.getInt(5));
                        schedaDiAllenamento.addEsercizio(esercizio);
                    }

                    listSchedaDiAllenamento.addSchedaDiAllenamento(schedaDiAllenamento);
                }
                status = cs.getMoreResults();
            } while(status || cs.getUpdateCount() != -1);
        } catch (SQLException e) {
            throw new DAOException("vediTutteLeSchedeDiAllenamento error: " + e.getMessage());
        }

        return listSchedaDiAllenamento;
    }
}
