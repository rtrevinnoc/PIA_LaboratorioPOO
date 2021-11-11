package logic;

import java.sql.*;

public class Persona {

    private String nombre = "", apellidoP = "", apellidoM = "", correo = "", Fecha = "";
    private long telefono=0;
    private int ID = 0;

    public String getNombre() {
        return nombre;
    }

    public String getApellidoP() {
        return apellidoP;
    }

    public String getApellidoM() {
        return apellidoM;
    }

    public String getCorreo() {
        return correo;
    }

    public long getTelefono() {
        return telefono;
    }

    public String getFecha() {
        return Fecha;
    }

    public int getID() {
        return ID;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public void setApellidoP(String apellidoP) {
        this.apellidoP = apellidoP;
    }

    public void setApellidoM(String apellidoM) {
        this.apellidoM = apellidoM;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public void setTelefono(long telefono) {
        this.telefono = telefono;
    }

    public void setFecha(String Fecha) {
        this.Fecha = Fecha;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

}