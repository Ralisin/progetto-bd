package model.domain;

import java.util.ArrayList;
import java.util.List;

public class ListClienti {
    List<Cliente> clienteList = new ArrayList<Cliente>();

    public void addCliente(int id, String nome, String cognome) {
        Cliente cliente = new Cliente(id, nome, cognome);
        clienteList.add(cliente);
    }

    public List<Cliente> getListCliente() {
        return clienteList;
    }
}
