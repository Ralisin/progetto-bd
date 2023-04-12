package controller;

import exception.DAOException;
import model.dao.ConnectionFactory;
import model.dao.procedures.InserisciEsercizioProcedureDAO;
import model.dao.procedures.InserisciMacchinarioProcedureDAO;
import model.dao.procedures.RimuoviEsercizioProcedureDAO;
import model.dao.procedures.RimuoviMacchinarioProcedureDAO;
import model.domain.Credentials;
import model.domain.Role;
import view.AmministratoreView;

import java.io.IOException;
import java.sql.SQLException;

public class AmministratoreController implements Controller {
    @Override
    public void start(Credentials credentials) {
        try {
            ConnectionFactory.changeRole(Role.AMMINISTRATORE);
        } catch(SQLException e) {
            throw new RuntimeException(e);
        }

        while(true) {
            int choice;
            try {
                choice = AmministratoreView.showMenu();
            } catch(IOException e) {
                throw new RuntimeException(e);
            }

            switch(choice) {
                case 1 -> inserisciEsercizio();
                case 2 -> inserisciMacchinario();
                case 3 -> cancellaEsercizio();
                case 4 -> cancellaMacchinario();
                case 5 -> System.exit(0);
                default -> throw new RuntimeException("Invalid choice");
            }
        }
    }

    private void inserisciEsercizio() {
        String nomeEsercizio;
        String nomeMacchinario;

        nomeEsercizio = AmministratoreView.getNomeEsercizio();
        nomeMacchinario = AmministratoreView.getNomeMacchinario();

        System.out.println("Nome macchinario: " + nomeMacchinario + "|");

        try {
            new InserisciEsercizioProcedureDAO().execute(nomeEsercizio, nomeMacchinario);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void inserisciMacchinario() {
        String nomeMacchinario;

        nomeMacchinario = AmministratoreView.getNomeMacchinario();

        try {
            new InserisciMacchinarioProcedureDAO().execute(nomeMacchinario);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void cancellaEsercizio() {
        String nomeEsericizio;

        nomeEsericizio = AmministratoreView.getNomeEsercizio();

        try {
            new RimuoviMacchinarioProcedureDAO().execute(nomeEsericizio);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    private void cancellaMacchinario() {
        String nomeMacchinario;

        nomeMacchinario = AmministratoreView.getNomeEsercizio();

        try {
            new RimuoviEsercizioProcedureDAO().execute(nomeMacchinario);
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }
}
