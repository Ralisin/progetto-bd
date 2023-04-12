package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Esercizio;
import model.domain.ListEsercizi;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VediListaEserciziDisponibiliProcedureDAO implements GenericProcedureDAO<ListEsercizi> {
    @Override
    public ListEsercizi execute(Object... params) throws DAOException {
        ListEsercizi listEsercizi = new ListEsercizi();

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call vediListaEserciziDisponibili()}");
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while(rs.next()) {
                    Esercizio esercizio = new Esercizio(0, rs.getString(1), 0, 0);
                    listEsercizi.addEsercizio(esercizio);
                }
            }
        } catch (SQLException e) {
            throw new DAOException("vediListaEserciziDisponibili error: " + e.getMessage());
        }

        return listEsercizi;
    }
}
