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
public class LimitaAtaques extends TimerTask {

    private PersonagemDAO personagemDAO;
    private List<Personagem> lista;
    private int limiteAtaques;

    public LimitaAtaques(int limiteAtaques, PersonagemDAO personagemDAO) {
        try {
            this.limiteAtaques = limiteAtaques;
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

                        if (lista.get(x).getDerrotasNoDia() == limiteAtaques) {

                            GregorianCalendar dataAtual = new GregorianCalendar();
                            dataAtual.setTime(new Date(System.currentTimeMillis()));
                            Calendar dataUltimaDerrota = lista.get(x).getDataUltimaDerrota();
                            GregorianCalendar umDiaAposUltimaDerrota = new GregorianCalendar();
                            umDiaAposUltimaDerrota.setTime(dataUltimaDerrota.getTime());
                            umDiaAposUltimaDerrota.add(Calendar.DAY_OF_MONTH, 1);

                            if (dataAtual.compareTo(umDiaAposUltimaDerrota) == 0 || dataAtual.compareTo(umDiaAposUltimaDerrota) == 1) {
                                Personagem p = personagemDAO.findPersonagem(lista.get(x).getPersonagemId());
                                p.setDerrotasNoDia(0);
                                personagemDAO.save(p);
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
