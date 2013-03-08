/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bdd;

import dao.PersonagemDAO;
import dao.UsuarioDAO;
import java.io.IOException;
import java.util.Timer;
import javax.servlet.*;
import objetos.*;

/**
 *
 * @author Guilherme
 */
public class AtualizarBancoDeDados implements Servlet {

    @Override
    public void init(ServletConfig config) throws ServletException {
        System.out.println("Servlet iniciado");

        Arma arma = new Arma();
        
        PersonagemDAO personagemDAO = new PersonagemDAO();
        UsuarioDAO usuarioDAO = new UsuarioDAO();
        
        bdd.ObjetosDoJogo.criarDados();
        AtualizarBancoDeDados.finalizarMissoes(1, 0, personagemDAO);
        AtualizarBancoDeDados.atualizaPremiums(10, 0, usuarioDAO);
        AtualizarBancoDeDados.limitaAtaques(10, 0, personagemDAO);
    }

    public static void finalizarMissoes(int minutos, int segundos, PersonagemDAO personagemDAO) {
        int tempo;
        segundos = segundos * 1000;
        minutos = minutos * 60 * 1000;
        tempo = segundos + minutos;

        FinalizaMissao finalizaMissao = new FinalizaMissao(personagemDAO);
        System.out.println("FinalizarMissao criado");


        Timer timer = new Timer();
        timer.schedule(finalizaMissao, 0, tempo);
    }

    public static void atualizaPremiums(int minutos, int segundos, UsuarioDAO usuarioDAO) {
        int tempo;
        segundos = segundos * 1000;
        minutos = minutos * 60 * 1000;
        tempo = segundos + minutos;

        AtualizaPremium atualizaPremium = new AtualizaPremium(usuarioDAO);
        System.out.println("AtualizaPremium criado");

        Timer timer = new Timer();
        timer.schedule(atualizaPremium, 0, tempo);
    }

    public static void limitaAtaques(int minutos, int segundos, PersonagemDAO personagemDAO) {
        final int LIMITE_ATAQUES = Personagem.LIMITE_ATAQUES;
        int tempo;
        segundos = segundos * 1000;
        minutos = minutos * 60 * 1000;
        tempo = segundos + minutos;

        LimitaAtaques limitaAtaques = new LimitaAtaques(LIMITE_ATAQUES, personagemDAO);

        Timer timer = new Timer();
        timer.schedule(limitaAtaques, 0, tempo);
    }

    @Override
    public ServletConfig getServletConfig() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void service(ServletRequest req, ServletResponse res) throws ServletException, IOException {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public String getServletInfo() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public void destroy() {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}
