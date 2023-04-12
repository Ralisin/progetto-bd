package view;

import java.io.IOException;
import java.util.Scanner;

public class AmministratoreView {
    public static int showMenu() throws IOException {
        System.out.println("**************************");
        System.out.println("*  Menu Amministratore   *");
        System.out.println("**************************");
        System.out.println("**    Cosa vuoi fare?   **");
        System.out.println("1) Inserire un esercizio");
        System.out.println("2) Inserire un macchinario");
        System.out.println("3) Cancellare un esercizio");
        System.out.println("4) Cancellare un macchinario");
        System.out.println("5) Esci");

        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Inserisci il numero dell'operazione scelta: ");
            choice = input.nextInt();
            if (0 < choice && choice < 6) {
                break;
            }
            System.out.println("Numero scelto non valido, riprova");
        }

        return choice;
    }

    public static String getNomeEsercizio() {
        Scanner input = new Scanner(System.in);
        System.out.print("Nome esercizio: ");
        return input.nextLine();
    }

    public static String getNomeMacchinario() {
        Scanner input = new Scanner(System.in);
        System.out.print("Nome macchinario: ");
        return input.nextLine();
    }
}
