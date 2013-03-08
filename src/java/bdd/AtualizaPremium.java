/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bdd;

import dao.UsuarioDAO;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import objetos.Usuario;

/**
 *
 * @author Guilherme
 */
public class AtualizaPremium extends TimerTask {

    private UsuarioDAO usuarioDAO;
    private List<Usuario> lista;

    public AtualizaPremium(UsuarioDAO usuarioDAO) {
        try {
            this.usuarioDAO = usuarioDAO;
            this.lista = this.usuarioDAO.findUsuarioEntities();
        } catch (Exception ex) {
            Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public void run() {

        new Thread() {

            @Override
            public void run() {

                try {
                    lista = usuarioDAO.findUsuarioEntities();

                    for (int x = 0; x < lista.size(); x++) {

                        if (lista.get(x).getDataPremium() == null) {
                            if (lista.get(x).getPremium() == true) {
                                Usuario u = usuarioDAO.findUsuario(lista.get(x).getId());
                                u.setPremium(false);
                                usuarioDAO.save(u);
                            }
                        } else {

                            GregorianCalendar dataAtual = new GregorianCalendar();
                            dataAtual.setTime(new Date(System.currentTimeMillis()));
                            Calendar dataTerminoPremium = lista.get(x).getDataPremium();

                            if (dataAtual.compareTo(dataTerminoPremium) == 0 || dataAtual.compareTo(dataTerminoPremium) == 1) {
                                if (lista.get(x).getPremium() == true) {
                                    Usuario u = usuarioDAO.findUsuario(lista.get(x).getId());
                                    u.setPremium(false);
                                    usuarioDAO.save(u);
                                }
                            } else {
                                if (lista.get(x).getPremium() == false) {
                                    Usuario u = usuarioDAO.findUsuario(lista.get(x).getId());
                                    u.setPremium(true);
                                    usuarioDAO.save(u);
                                }
                            }


                        }
                    }


                } catch (Exception ex) {
                    Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }.start();

    }
}
