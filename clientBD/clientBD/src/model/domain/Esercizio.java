package model.domain;

public class Esercizio {
    int ordine;
    String nomeEsercizio;
    int serie;
    int ripetizioni;

    public Esercizio(int ordine, String nomeEsercizio, int serie, int ripetizioni) {
        this.ordine = ordine;
        this.nomeEsercizio = nomeEsercizio;
        this.serie = serie;
        this.ripetizioni = ripetizioni;
    }

    public int getOrdine() {
        return ordine;
    }

    public String getNomeEsercizio() {
        return nomeEsercizio;
    }

    public int getSerie() {
        return serie;
    }

    public int getRipetizioni() {
        return ripetizioni;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format("%d:%-20s Serie: %-3d Ripetizioni: %d", ordine, nomeEsercizio, serie, ripetizioni));

        return sb.toString();
    }
}
