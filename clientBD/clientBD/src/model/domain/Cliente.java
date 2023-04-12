package model.domain;

public class Cliente extends Credentials {
    public Cliente(int id, String nome, String cognome) {
        super(nome, cognome, null, null, id);
    }

    @Override
    public String getNome() {
        return super.getNome();
    }

    @Override
    public String getCognome() {
        return super.getCognome();
    }

    @Override
    public int getId() {
        return super.getId();
    }
}
