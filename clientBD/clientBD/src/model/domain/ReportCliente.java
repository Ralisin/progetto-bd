package model.domain;

import java.util.ArrayList;
import java.util.List;

public class ReportCliente {
    Cliente cliente = null;
    int numeroAllenamentiSostenuti = 0;
    List<SessioneDiAllenamento> listSessioneDiAllenamento = new ArrayList<>();

    public void setCliente(Cliente cliente) {
        this.cliente = cliente;
    }

    public void setNumeroAllenamentiSostenuti(int numeroAllenamentiSostenuti) {
        this.numeroAllenamentiSostenuti = numeroAllenamentiSostenuti;
    }

    public void addSessioneDiAllenamento(SessioneDiAllenamento sessioneDiAllenamento) {
        listSessioneDiAllenamento.add(sessioneDiAllenamento);
    }

    public Cliente getCliente() {
        return cliente;
    }

    public int getNumeroAllenamentiSostenuti() {
        return numeroAllenamentiSostenuti;
    }

    public List<SessioneDiAllenamento> getListSessioneDiAllenamento() {
        return listSessioneDiAllenamento;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append(String.format("Id: %-3d | Nome: %-20s | Cognome: %-20s | Numero allenamenti sostenuti: %-3d\n", cliente.getId(), cliente.getNome(), cliente.getCognome(), numeroAllenamentiSostenuti));
        for(SessioneDiAllenamento sessioneDiAllenamento : listSessioneDiAllenamento)
            sb.append("Data sessione: ").append(sessioneDiAllenamento.getDataSessione()).append(" | Durata: ").append(sessioneDiAllenamento.getDurata()).append(" | Percentuale di completamento: ").append(sessioneDiAllenamento.getPercentualeCompletamento()).append("\n");

        return sb.toString();
    }
}
