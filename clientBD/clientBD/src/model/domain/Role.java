package model.domain;

public enum Role {
    AMMINISTRATORE(1),
    CLIENTE(2),
    PERSONALTRAINER(3);

    private final int id;
    Role(int i) {this.id = i;}

    public static Role fromInt(int id) {
        for (Role type : values()) {
            if (type.getId() == id) {
                return type;
            }
        }
        return null;
    }

    public int getId() {
        return id;
    }

}
