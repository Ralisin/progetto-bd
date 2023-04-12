package model.domain;

import java.util.ArrayList;
import java.util.List;

public class ListSchedaDiAllenamento {
    List<SchedaDiAllenamento> listaSchedeDiAllenamento = new ArrayList<>();

    public void addSchedaDiAllenamento(SchedaDiAllenamento schedaDiAllenamento) {
        this.listaSchedeDiAllenamento.add(schedaDiAllenamento);
    }

    public List<SchedaDiAllenamento> getListaSchedeDiAllenamento() {
        return listaSchedeDiAllenamento;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for(SchedaDiAllenamento schedaDiAllenamento : listaSchedeDiAllenamento) {
            sb.append(schedaDiAllenamento).append("\n");
        }

        return sb.toString();
    }
}
