package view;

import model.domain.Credentials;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class LoginView {
    public static Credentials authenticate() throws IOException {
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));

        System.out.println("****  Login Palestra R  ****");
        System.out.print("Nome: ");
        String nome = reader.readLine();
        System.out.print("Cognome: ");
        String cognome = reader.readLine();
        System.out.print("Password: ");
        String password = reader.readLine();

        return new Credentials(nome, cognome, password, null, 0);
    }
}
