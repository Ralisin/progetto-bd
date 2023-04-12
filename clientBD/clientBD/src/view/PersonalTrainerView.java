package view;

import model.domain.*;

import java.io.IOException;
import java.sql.Date;
import java.text.ParseException;
import java.util.Scanner;

public class PersonalTrainerView {
    public static int showMenu() throws IOException {
        System.out.println("**************************");
        System.out.println("* Menu Personal Trainer  *");
        System.out.println("**************************");
        System.out.println("**    Cosa vuoi fare?   **");
        System.out.println("1) Crea una scheda di allenamento");
        System.out.println("2) Esegui un report");
        System.out.println("3) Esci");

        Scanner input = new Scanner(System.in);
        int choice = 0;
        while (true) {
            System.out.print("Inserisci il numero dell'operazione scelta: ");
            choice = input.nextInt();
            if (0 < choice && choice < 4) {
                break;
            }
            System.out.println("Numero scelto non valido, riprova");
        }

        return choice;
    }

    public static SchedaDiAllenamento composeSchedaDiAllenamento(ListEsercizi eserciziList) throws IOException {
        System.out.println("*************************************");
        System.out.println("*  Creazione Scheda di allenamento  *");
        System.out.println("*************************************");

        SchedaDiAllenamento schedaDiAllenamento = new SchedaDiAllenamento();
        schedaDiAllenamento.setDataAssegnazione(new Date(System.currentTimeMillis()));

        int choice = 1;
        boolean in;
        int ordine = 1;
        String nomeEsercizio;
        int serie;
        int ripetizioni;
        Scanner input = new Scanner(System.in);
        while(true) {
            if(choice == 1) {
                System.out.println("* Lista esercizi assegnabili: ");
                for(Esercizio esercizio : eserciziList.getListaEsercizi()) {
                    System.out.println(" - " + esercizio.getNomeEsercizio());
                }

                while(true) {
                    System.out.print("Nome esercizio: ");
                    nomeEsercizio = input.nextLine();

                    in = false;
                    for (Esercizio esercizio : eserciziList.getListaEsercizi()) {
                        if (esercizio.getNomeEsercizio().equals(nomeEsercizio.toUpperCase())) {
                            in = true;
                            break;
                        }
                    }

                    if (in) break;

                    System.out.println("Nome esercizio non valido");
                }

                while(true) {
                    System.out.print("Numero serie: ");
                    serie = input.nextInt();

                    if(serie > 0) break;

                    System.out.println("Numero di serie non valido");
                }

                while(true) {
                    System.out.print("Numero ripetizioni: ");
                    ripetizioni = input.nextInt();

                    if(ripetizioni > 0) break;

                    System.out.println("Numero di ripetizioni non valido");
                }


                Esercizio esercizio = new Esercizio(ordine, nomeEsercizio.toUpperCase(), serie, ripetizioni);
                schedaDiAllenamento.addEsercizio(esercizio);

                ordine++;

                System.out.println("* Esercizio inserito correttamente");
            }
            else if (choice == 2) System.out.println(schedaDiAllenamento);
            else if (choice == 3) return schedaDiAllenamento;
            else System.out.println("Numero scelto non valido, riprova");

            System.out.println("*************************************");
            System.out.println("1) Inserisci prossimo esercizio");
            System.out.println("2) Recap scheda di allenamento creata");
            System.out.println("3) Concludi creazione scheda");
            System.out.print("Input: ");
            choice = input.nextInt();

            //Pulizia buffer di input
            input.nextLine();
        }
    }

    public static int showListaClienti(ListClienti listClienti)  throws IOException {
        System.out.println("*******************************");
        System.out.println("*   Lista Clienti Affiliati   *");
        System.out.println("*******************************");
        for(Cliente cliente : listClienti.getListCliente()) {
            System.out.println(String.format("Id: %-3d | Nome: %-20s | Cognome: %-20s", cliente.getId(), cliente.getNome(), cliente.getCognome()));
        }

        Scanner input = new Scanner(System.in);
        int choice = 0;
        boolean in = false;
        while (true) {
            System.out.print("ID Cliente a cui assegnare la scheda: ");
            choice = input.nextInt();
            for(Cliente cliente : listClienti.getListCliente()) {
                if(cliente.getId() == choice) in = true;
            }

            if(in) return choice;
            System.out.println("ID Cliente non valido, riprova");
        }
    }

    public static void showSchedaDiAllenamentoCreata(SchedaDiAllenamento schedaDiAllenamento) {
        System.out.println(schedaDiAllenamento);
    }

    public static void showReport(ListReportCliente listReportCliente) {
        System.out.println("**************************");
        System.out.println("*         Report         *");
        System.out.println("**************************");
        System.out.println(listReportCliente);
    }

    public static Date pickDataInizioReport() throws ParseException {
        System.out.print("Seleziona data inizio report: (yyyy-MM-dd) ");

        Scanner scanner = new Scanner(System.in);
        String date = scanner.nextLine();
        return Date.valueOf(date);
    }

    public static Date pickDataFineReport() throws ParseException {
        System.out.print("Seleziona data fine report: (yyyy-MM-dd) ");

        Scanner scanner = new Scanner(System.in);
        String date = scanner.nextLine();
        return Date.valueOf(date);
    }
}
