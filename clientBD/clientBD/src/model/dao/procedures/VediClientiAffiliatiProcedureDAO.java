package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.Credentials;
import model.domain.ListClienti;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

public class VediClientiAffiliatiProcedureDAO implements GenericProcedureDAO<ListClienti> {
    @Override
    public ListClienti execute(Object... params) throws DAOException {
        ListClienti listClienti = new ListClienti();
        Credentials credentials = (Credentials) params[0];

        try {
            Connection conn = ConnectionFactory.getConnection();
            CallableStatement cs = conn.prepareCall("{call vediClientiAffiliati(?)}");
            cs.setInt(1, credentials.getId());
            boolean status = cs.execute();

            if(status) {
                ResultSet rs = cs.getResultSet();
                while(rs.next()) {
                    listClienti.addCliente(rs.getInt(1), rs.getString(2), rs.getString(3));
                }
            }
        } catch (SQLException e) {
            throw new DAOException("vediClientiAffiliati error: " + e.getMessage());
        }

        return listClienti;
    }
}
