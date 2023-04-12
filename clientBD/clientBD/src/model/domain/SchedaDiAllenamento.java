package model.domain;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class SchedaDiAllenamento {
    Date dataAssegnazione;
    List<Esercizio> eserciziList = new ArrayList<>();

    public void addEsercizio(Esercizio esercizio) {
        this.eserciziList.add(esercizio);
    }

    public List<Esercizio> getEserciziList() {
        return eserciziList;
    }

    public Date getDataAssegnazione() {
        return dataAssegnazione;
    }
    public void setDataAssegnazione(Date dataAssegnazione) {
        this.dataAssegnazione = dataAssegnazione;
    }

    public int getNumeroEsercizi() {
        int numEx = 0;

        for(Esercizio esercizio : eserciziList) numEx++;

        return numEx;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Data assegnazione: ").append(dataAssegnazione).append("\n");
        for(Esercizio esercizio : eserciziList) {
            sb.append(esercizio).append("\n--------------------------------------------------\n");
        }

        return sb.toString();
    }
}
