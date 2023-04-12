package model.domain;

import java.util.ArrayList;
import java.util.List;

public class ListReportCliente {
    List<ReportCliente> reportClienteList = new ArrayList<>();

    public void addReportCliente(ReportCliente reportCliente) {
        reportClienteList.add(reportCliente);
    }

    public List<ReportCliente> getReportClienteList() {
        return reportClienteList;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        for(ReportCliente reportCliente : reportClienteList) {
            sb.append(reportCliente).append("------------------------------\n");
        }

        return sb.toString();
    }
}
