package model.domain;

public class Credentials {
    private final String nome;
    private final String cognome;
    private final String password;
    private final Role role;

    private final int id;

    public Credentials(String nome, String cognome, String password, Role role, int id) {
        this.nome = nome;
        this.cognome = cognome;
        this.password = password;
        this.role = role;
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public String getCognome() {
        return cognome;
    }

    public String getPassword() {
        return password;
    }

    public Role getRole() {
        return role;
    }

    public int getId() {
        return id;
    }
}
