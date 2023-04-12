package model.domain;

import java.sql.Date;
import java.sql.Time;

public class SessioneDiAllenamento {
    float percentualeCompletamento;
    Time durata;
    Date dataSessione;
    Date dataSchedaDiAllenamento;

    public SessioneDiAllenamento(Date dataSchedaDiAllenamento, float percentualeCompletamento, Time durata, Date dataSessione) {
        this.dataSchedaDiAllenamento = dataSchedaDiAllenamento;
        this.percentualeCompletamento = percentualeCompletamento;
        this.durata = durata;
        this.dataSessione = dataSessione;
    }

    public Date getDataSchedaDiAllenamento() {
        return dataSchedaDiAllenamento;
    }

    public float getPercentualeCompletamento() {
        return percentualeCompletamento;
    }

    public Time getDurata() {
        return durata;
    }

    public Date getDataSessione() {
        return dataSessione;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Scheda di allenamento: ").append(dataSchedaDiAllenamento).append("\nData sessione: ").append(dataSessione).append("\nPercentuale di completamento: ").append(percentualeCompletamento).append("\nDurata: ").append(durata);

        return sb.toString();
    }
}
