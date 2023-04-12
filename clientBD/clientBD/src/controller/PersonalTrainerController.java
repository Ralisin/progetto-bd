package controller;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.procedures.CreaSchedaDiAllenamentoProcedureDAO;
import model.dao.procedures.VediClientiAffiliatiProcedureDAO;
import model.dao.procedures.VediListaEserciziDisponibiliProcedureDAO;
import model.dao.procedures.VediReportProcedureDAO;
import model.domain.*;
import view.PersonalTrainerView;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.text.ParseException;

public class PersonalTrainerController implements Controller {
    Credentials credentials;
    @Override
    public void start(Credentials credentials) {
        this.credentials = credentials;

        try {
            ConnectionFactory.changeRole(Role.PERSONALTRAINER);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        while(true) {
            int choice;
            try {
                choice = PersonalTrainerView.showMenu();
            } catch(IOException e) {
                throw new RuntimeException(e);
            }

            switch(choice) {
                case 1 -> creaSchedaDiAllenamento();
                case 2 -> eseguiReport();
                case 3 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    private void creaSchedaDiAllenamento() {
        ListClienti listClienti;
        int idCliente;
        ListEsercizi listEsercizi;
        SchedaDiAllenamento schedaDiAllenamento;
        try {
            listClienti = new VediClientiAffiliatiProcedureDAO().execute(credentials);
            idCliente = PersonalTrainerView.showListaClienti(listClienti);

            listEsercizi = new VediListaEserciziDisponibiliProcedureDAO().execute();
            schedaDiAllenamento = PersonalTrainerView.composeSchedaDiAllenamento(listEsercizi);

            new CreaSchedaDiAllenamentoProcedureDAO().execute(credentials, idCliente, schedaDiAllenamento);
        } catch (IOException e) {
            throw new RuntimeException(e);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }

        PersonalTrainerView.showSchedaDiAllenamentoCreata(schedaDiAllenamento);
    }

    private void eseguiReport() {
        ListReportCliente listReportCliente;
        Date dataInizio;
        Date dataFine;

        try {
            dataInizio = PersonalTrainerView.pickDataInizioReport();
            dataFine = PersonalTrainerView.pickDataFineReport();
        } catch (ParseException e) {
            throw new RuntimeException(e);
        }

        try {
            listReportCliente = new VediReportProcedureDAO().execute(credentials, dataInizio, dataFine);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        PersonalTrainerView.showReport(listReportCliente);
    }
}
