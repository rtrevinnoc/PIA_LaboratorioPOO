
package logic;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletContext;
public class Controlador {
    LeerConfig config=new LeerConfig();

    public static ServletContext application;
    
    static String url;
    static String user;
    static String password;
    
    public void RecibirPropiedades(){
        url = config.leer("url");
        user = config.leer("user");
        password = config.leer("password");
    }
    
    public void Agregar(String nombre, String apPat, String apMat, String email, String tel, String fecha) {
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String query = "CALL AGREGAR(\'" + nombre + "\',\'" + apPat + "\',\'" + apMat + "\',\'" + email + "\'," + Long.parseLong(tel) + ",\'" + fecha + "\');";
            CallableStatement stmt = conn.prepareCall(query);
            stmt.executeQuery();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }

    public static Persona GetPerson(String Email, String Tel) {
        
        Persona loPersona = new Persona();
        Connection conn = null;
        if (Tel.isEmpty()) {
            Tel = "0";
        }
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String query = "{CALL LEER(?,?)}";
            CallableStatement stmt = conn.prepareCall(query);
            stmt.setString("EMAIL", Email);
            stmt.setLong("TELEFONO", Long.parseLong(Tel));
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                loPersona.setID(rs.getInt("Id"));
                loPersona.setNombre(rs.getString("NOMBRE"));
                loPersona.setApellidoP(rs.getString("APELLIDOP"));
                loPersona.setApellidoM(rs.getString("APELLIDOM"));
                loPersona.setCorreo(rs.getString("EMAIL"));
                loPersona.setTelefono(rs.getLong("TELEFONO"));
                loPersona.setFecha(rs.getString("FECHA"));
            }

            rs.close();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return loPersona;
    }
    public void Modificar(String id,String nombre, String apPat, String apMat, String email, String tel, String fecha){
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String query = "CALL MODIFICAR("+Integer.parseInt(id)+",\'" + nombre + "\',\'" + apPat + "\',\'" + apMat + "\',\'" + email + "\'," + Long.parseLong(tel) + ",\'" + fecha + "\');";
            CallableStatement stmt = conn.prepareCall(query);
            stmt.executeQuery();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    public void Eliminar(String id){
        Connection conn = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, user, password);
            String query = "CALL ELIMINAR("+Integer.parseInt(id)+");";
            CallableStatement stmt = conn.prepareCall(query);
            stmt.executeQuery();
            stmt.close();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
    }
    public boolean Vacio(String id,String nombre, String apPat, String email, String tel, String fecha){
        if(id.isEmpty()||nombre.isEmpty()||apPat.isEmpty()||email.isEmpty()||tel.isEmpty()||fecha.isEmpty()){
            return true;
        }
        else{
            return false;
        }
    }
}

