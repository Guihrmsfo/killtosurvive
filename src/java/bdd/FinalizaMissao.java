
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bdd;

import dao.PersonagemDAO;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import objetos.Personagem;

/**
 *
 * @author Guilherme
 */
public class FinalizaMissao extends TimerTask {

    private PersonagemDAO personagemDAO;
    private List<Personagem> lista;

    public FinalizaMissao(PersonagemDAO personagemDAO) {
        try {
            this.personagemDAO = personagemDAO;
            this.lista = this.personagemDAO.findPersonagemEntities();
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
                    lista = personagemDAO.findPersonagemEntities();

                    for (int x = 0; x < lista.size(); x++) {
                        if (lista.get(x).getMissao() != null) {
                            GregorianCalendar dataAtual = new GregorianCalendar();
                            dataAtual.setTime(new Date(System.currentTimeMillis()));
                            Calendar dataTerminoMissao = lista.get(x).getMissao().getDataTermino();

                            if (dataAtual.compareTo(dataTerminoMissao) == 0 || dataAtual.compareTo(dataTerminoMissao) == 1) {
                                ManipularDados.executarMissao(lista.get(x));
                                System.out.println("Personagem com missão finalizada");
                            }

                        }
                    }
                
                }catch(IllegalArgumentException ex){
                    Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
                }catch(Exception ex){
                    Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
                }
                
            }
        }.start();

    }
}
