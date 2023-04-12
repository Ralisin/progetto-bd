package model.domain;

import java.util.ArrayList;
import java.util.List;

public class ListEsercizi {
    List<Esercizio> listaEsercizi = new ArrayList<Esercizio>();

    public void addEsercizio(Esercizio esercizio) {
        listaEsercizi.add(esercizio);
    }

    public List<Esercizio> getListaEsercizi() {
        return listaEsercizi;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for(Esercizio esercizio : listaEsercizi) {
            sb.append(esercizio).append("\n");
        }

        return sb.toString();
    }
}
