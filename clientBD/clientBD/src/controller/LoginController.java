package controller;

import exception.DAOException;
import model.dao.procedures.LoginProcedureDAO;
import model.domain.Credentials;
import view.LoginView;

import java.io.IOException;

public class LoginController implements Controller {
    private Credentials credentials = null;

    @Override
    public void start(Credentials cred) {
        try {
            credentials = LoginView.authenticate();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        try {
            credentials = new LoginProcedureDAO().execute(credentials.getNome(), credentials.getCognome(), credentials.getPassword());
        } catch (DAOException e) {
            throw new RuntimeException(e);
        }
    }

    public Credentials getCredentials() {
        return credentials;
    }
}
