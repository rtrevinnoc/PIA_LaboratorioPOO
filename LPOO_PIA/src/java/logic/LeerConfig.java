
package logic;
import java.io.*;

import java.util.*;

public class LeerConfig {
     String url;
     String user;
     String password;
    public String leer(String tipo){
        try {
            String Path = Controlador.application.getRealPath("/");
            Properties pro = new Properties();
            FileInputStream in = new FileInputStream(Path+"..\\..\\Configuracion.txt");
            pro.load(in);
            url = pro.getProperty("url");
            user = pro.getProperty("user");
            password = pro.getProperty("password");

        } catch (IOException e) {
            System.out.println("Error is:" + e.getMessage());
            e.printStackTrace();
        }
        finally{
            if (tipo.equals("url")){
                return url;
            }
            if (tipo.equals("user")){
                return user;
            }
            if (tipo.equals("password")){
                return password;
            }
            else{
                return null;
            }
        }
    }
}
