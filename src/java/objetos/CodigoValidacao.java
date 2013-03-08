/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package objetos;

import dao.UsuarioDAO;
import java.util.Random;

/**
 *
 * @author Guilherme
 */
public class CodigoValidacao {

    private String codigo;
    private String usuario;

    public CodigoValidacao(String codigo, String usuario) {
        this.codigo = codigo;
        this.usuario = usuario;
    }

    public CodigoValidacao() {
        this.codigo = "";
        this.usuario = "";
    }

    public String getCodigo() {
        return codigo;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public Usuario getUsuarioFromDAO() {
        UsuarioDAO dao = new UsuarioDAO();
        return dao.consultarPorNome(this.usuario);
    }

    public String gerarCodigoValidacao() {
        String cod = "", usuarioCod;

        usuarioCod = this.getUsuario().toLowerCase();
        Random v = new Random();
        String alphabet = "1234567890abcdefghijklmnopqrstuvxywz";

        for (int x = 0; x < 20; x++) {
            if (x % 5 == 0) {
                cod = cod + usuarioCod.charAt(v.nextInt(usuarioCod.length() - 1));
            } else {
                if (v.nextBoolean()) {
                    String letra = "" + alphabet.charAt(v.nextInt(alphabet.length() - 1));
                    cod = cod + letra.toUpperCase();
                } else {
                    cod = cod + alphabet.charAt(v.nextInt(alphabet.length() - 1));
                }
            }
        }

        return cod;
    }

    public boolean verificarCodigoValidacao() {
        String user = this.getUsuario().toLowerCase();

        if (codigo.length() < 20) {
            return false;
        }

        for (int x = 0; x < 20; x = x + 5) {
            for (int y = 0; y < user.length(); y++) {
                if (codigo.charAt(x) == user.charAt(y)) {
                    break;
                } else {
                    if (y == user.length() - 1) {
                        return false;
                    }
                }
            }
        }
        return true;
    }

    public void corrigirUrlParaUsuario() {
        String u = this.getUsuario();
        u = u.replace('_', ' ');
        this.setUsuario(u);
    }
}
