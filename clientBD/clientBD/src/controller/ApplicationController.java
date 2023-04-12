package controller;

import model.domain.Credentials;

public class ApplicationController implements Controller {
    Credentials credentials;
    @Override
    public void start(Credentials cred) {
        LoginController loginController = new LoginController();
        loginController.start(null);
        credentials = loginController.getCredentials();

        if(credentials.getRole() == null) {
            throw new RuntimeException("Invalid credentials");
        }

        switch(credentials.getRole()) {
            case AMMINISTRATORE -> new AmministratoreController().start(credentials);
            case CLIENTE -> new ClienteController().start(credentials);
            case PERSONALTRAINER -> new PersonalTrainerController().start(credentials);
            default -> throw new RuntimeException("Invalid credentials");
        }
    }
}
