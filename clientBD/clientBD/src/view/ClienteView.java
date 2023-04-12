package view;

import model.domain.Esercizio;
import model.domain.ListSchedaDiAllenamento;
import model.domain.SchedaDiAllenamento;

import java.io.IOException;
import java.util.Scanner;

public class ClienteView {
    public static int showMenu() throws IOException {
        System.out.println("**************************");
        System.out.println("*      Menu Cliente      *");
        System.out.println("**************************");
        System.out.println("**    Cosa vuoi fare?   **");
        System.out.println("1) Visualizza la scheda di allenamento");
        System.out.println("2) Inizia una sessione di allenamento");
        System.out.println("3) Visualizza tutte le schede di allenamento");
        System.out.println("4) Esci");

        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Inserisci il numero dell'operazione scelta: ");
            choice = input.nextInt();
            if (0 < choice && choice < 5) {
                break;
            }
            System.out.println("Numero scelto non valido, riprova");
        }

        return choice;
    }

    public static void showSchedaDiAllenamento(SchedaDiAllenamento schedaDiAllenamento) {
        System.out.println(schedaDiAllenamento);
    }

    public static void showTutteSchedeDiAllenamento(ListSchedaDiAllenamento listSchedaDiAllenamento) {
        System.out.println(listSchedaDiAllenamento);
    }

    public static void iniziaSessione(SchedaDiAllenamento schedaDiAllenamento) {
        int eserciziSvolti = 0;

        System.out.println("**************************");
        System.out.println("*       " + schedaDiAllenamento.getDataAssegnazione() + "       *");
        System.out.println("**************************");
    }

    public static int mostraEsercizio(Esercizio esercizio) {
        System.out.println("* Esercizio: " + esercizio.getNomeEsercizio() + "  *");
        System.out.println("* Serie: " + esercizio.getSerie() + ", Ripetizioni " + esercizio.getRipetizioni() + " *");
        System.out.println("1) Salta esercizio\n2) Esercizio svolto");

        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Input: ");
            choice = input.nextInt();
            if (choice == 1 || choice == 2) {
                System.out.println("");
                break;
            }
            System.out.println("Numero scelto non valido, riprova");
        }

        return choice-1;
    }

    public static void confermaInserimentoSessione() {
        System.out.println("* Sessione inserita correttamente *\n");
    }
}
