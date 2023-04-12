package controller;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.procedures.InserisciSessioneProcedureDAO;
import model.dao.procedures.VediSchedaDiAllenamentoProcedureDAO;
import model.dao.procedures.VediTutteSchedeDiAllenamentoProcedureDAO;
import model.domain.*;
import view.ClienteView;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;

public class ClienteController implements Controller {
    private Credentials credentials;
    @Override
    public void start(Credentials credentials) {
        this.credentials = credentials;

        try {
            ConnectionFactory.changeRole(Role.CLIENTE);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        while(true) {
            int choice;
            try {
                choice = ClienteView.showMenu();
            } catch(IOException e) {
                throw new RuntimeException(e);
            }

            switch(choice) {
                case 1 -> vediSchedaDiAllenamento();
                case 2 -> sessioneDiAllenamento();
                case 3 -> vediTutteLeSchede();
                case 4 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    public void sessioneDiAllenamento() {
        SchedaDiAllenamento schedaDiAllenamento;
        Chrono timer = new Chrono();
        int numExSvolti = 0;

        try {
            schedaDiAllenamento = new VediSchedaDiAllenamentoProcedureDAO().execute(credentials);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }

        ClienteView.iniziaSessione(schedaDiAllenamento);

        timer.start();
        for(Esercizio esercizio : schedaDiAllenamento.getEserciziList()) {
            numExSvolti += ClienteView.mostraEsercizio(esercizio);
        }
        timer.stop();

        SessioneDiAllenamento sessioneDiAllenamento = new SessioneDiAllenamento(schedaDiAllenamento.getDataAssegnazione(), (float) (((numExSvolti*1.0)/schedaDiAllenamento.getNumeroEsercizi())*100), timer.getTime(), new Date(System.currentTimeMillis()));

        try {
            new InserisciSessioneProcedureDAO().execute(sessioneDiAllenamento, credentials);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }

        ClienteView.confermaInserimentoSessione();
    }
    private void vediSchedaDiAllenamento() {
        SchedaDiAllenamento schedaDiAllenamento;

        try {
            schedaDiAllenamento = new VediSchedaDiAllenamentoProcedureDAO().execute(credentials);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }

        ClienteView.showSchedaDiAllenamento(schedaDiAllenamento);
    }
    private void vediTutteLeSchede() {
        ListSchedaDiAllenamento listSchedaDiAllenamento;

        try {
            listSchedaDiAllenamento = new VediTutteSchedeDiAllenamentoProcedureDAO().execute(credentials);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }

        ClienteView.showTutteSchedeDiAllenamento(listSchedaDiAllenamento);
    }
}
