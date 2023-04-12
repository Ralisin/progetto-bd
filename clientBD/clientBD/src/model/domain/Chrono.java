package model.domain;

import java.sql.Time;

public class Chrono {
    private boolean running;
    private long startTime;
    private long finishTime;
    public Chrono(){
        running = false;
    }
    public void start(){
        running = true;
        startTime = System.currentTimeMillis();
    }
    public void stop(){
        finishTime = System.currentTimeMillis();
        running = false;
    }
    public Time getTime(){
        return new Time(-1000*60*60 + (finishTime - startTime));
    }
}
