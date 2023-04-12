package model.dao.procedures;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.GenericProcedureDAO;
import model.domain.*;

import java.sql.*;

public class VediReportProcedureDAO implements GenericProcedureDAO<ListReportCliente> {
    @Override
    public ListReportCliente execute(Object... params) throws DAOException, SQLException {
        Credentials credentials = (Credentials) params[0];
        Date dataInizio = (Date) params[1];
        Date dataFine = (Date) params[2];
        ListReportCliente listReportCliente = new ListReportCliente();

        try {
            Connection conn = ConnectionFactory.getConnection();
            // personalTrainerID, dataInizio, dataFine
            CallableStatement cs = conn.prepareCall("{call vediReport(?, ?, ?)}");
            cs.setInt(1, credentials.getId());
            cs.setDate(2, dataInizio);
            cs.setDate(3, dataFine);
            boolean status = cs.execute();

            ResultSet rs;

            do {
                if(status) {
                    rs = cs.getResultSet();
                    ReportCliente reportCliente = new ReportCliente();

                    while(rs.next()) {
                        Cliente cliente = new Cliente(rs.getInt(3), rs.getString(1), rs.getString(2));
                        reportCliente.setCliente(cliente);
                        reportCliente.setNumeroAllenamentiSostenuti(rs.getInt(4));
                    }

                    status = cs.getMoreResults();

                    if(status) {
                        rs = cs.getResultSet();
                        while(rs.next()) {
                            SessioneDiAllenamento sessioneDiAllenamento = new SessioneDiAllenamento(rs.getDate(4), rs.getFloat(7), rs.getTime(6), rs.getDate(5));
                            reportCliente.addSessioneDiAllenamento(sessioneDiAllenamento);
                        }
                        listReportCliente.addReportCliente(reportCliente);
                    }
                }

                status = cs.getMoreResults();
            } while(status || cs.getUpdateCount() != -1);
        } catch (SQLException e) {
            throw new DAOException("vediReport error: " + e.getMessage());
        }

        return listReportCliente;
    }
}
