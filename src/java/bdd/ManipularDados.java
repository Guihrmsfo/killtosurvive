/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bdd;

import dao.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import objetos.*;

/**
 *
 * @author Guilherme
 */
public class ManipularDados {

    private static UsuarioDAO usuarioDAO = new UsuarioDAO();
    private static PersonagemDAO personagemDAO = new PersonagemDAO();
    private static ArmaDAO armaDAO = new ArmaDAO();
    private static EquipamentoDAO equipamentoDAO = new EquipamentoDAO();
    private static PersonagemPadraoDAO classeDAO = new PersonagemPadraoDAO();
    private static ResourceBundle i18n;

    public static Usuario atualizarUsuario(Object usuario) {
        return usuarioDAO.findUsuario(((Usuario) usuario).getId());
    }

    public static void alterarComportamento(Object usuario, String tipo, String comportamento) {

        try {
            Usuario usuarioAtualizado = usuarioDAO.findUsuario(((Usuario) usuario).getId());
            if (tipo.equals("inferior")) {
                usuarioAtualizado.getPersonagem().setComportamento_Inferior(comportamento);
            } else {
                if (tipo.equals("igual")) {
                    usuarioAtualizado.getPersonagem().setComportamento_Igual(comportamento);
                } else {
                    usuarioAtualizado.getPersonagem().setComportamento_Superior(comportamento);
                }
            }
            usuarioDAO.save(usuarioAtualizado);
        } catch (Exception ex) {
            Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    public static void alterarArmaDeUso(Object usuario, String arma) {
        try {
            Usuario usuarioAtualizado = usuarioDAO.findUsuario(((Usuario) usuario).getId());
            List<Arma> listaDeArmas = usuarioAtualizado.getPersonagem().getArmas();

            if (arma.equals("null")) {
                usuarioAtualizado.getPersonagem().setArma(-1);
            } else {
                for (int x = 0; x < listaDeArmas.size(); x++) {

                    if (listaDeArmas.get(x).getNome().equals(arma)) {
                        usuarioAtualizado.getPersonagem().setArma(x);
                    }
                }
            }

            usuarioDAO.save(usuarioAtualizado);
        } catch (Exception ex) {
            Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static void alterarEquipamentoDeUso(Object usuario, String equipamento) {
        try {
            Usuario usuarioAtualizado = usuarioDAO.findUsuario(((Usuario) usuario).getId());
            List<Equipamento> listaDeEquipamentos = usuarioAtualizado.getPersonagem().getEquipamentos();

            if (equipamento.equals("null")) {
                usuarioAtualizado.getPersonagem().setEquipamento(-1);
            } else {
                for (int x = 0; x < listaDeEquipamentos.size(); x++) {

                    if (listaDeEquipamentos.get(x).getNome().equals(equipamento)) {
                        usuarioAtualizado.getPersonagem().setEquipamento(x);
                    }
                }
            }

            usuarioDAO.save(usuarioAtualizado);
        } catch (Exception ex) {
            Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
        }

    }

    public static boolean salvarImagem(Usuario usuario, String url) {
        if (url.endsWith(".gif") || url.endsWith(".jpg") || url.endsWith(".jpeg")
                || url.endsWith(".png")) {
            try {
                usuario = usuarioDAO.findUsuario(usuario.getId());
                usuario.getPersonagem().setImagem(url);
                usuarioDAO.save(usuario);
            } catch (Exception ex) {
                Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
            }
            return true;
        } else {
            return false;
        }
    }

    public static boolean enviarMensagem(String titulo, String texto, Object destinatario, Object remetente) {
        Personagem personagem = personagemDAO.findPersonagem(((Personagem) destinatario).getPersonagemId());
        personagem.getMensagens().add(CriarObjeto.criarMensagem(titulo, texto, personagem, ((Personagem) remetente)));
        try {
            personagemDAO.save(personagem);
            return true;
        } catch (Exception ex) {
            Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static boolean enviarMensagem(String titulo, String texto, Object destinatario, Object remetente, boolean lida) {
        Personagem personagem = personagemDAO.findPersonagem(((Personagem) destinatario).getPersonagemId());
        Mensagem msg = CriarObjeto.criarMensagem(titulo, texto, personagem, ((Personagem) remetente));
        msg.setLida(lida);
        personagem.getMensagens().add(msg);
        try {
            personagemDAO.save(personagem);
            return true;
        } catch (Exception ex) {
            Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }

    public static Personagem getPersonagem(String nome) {
        return personagemDAO.consultarPorNome(nome);
    }

    public static void setMensagemLida(Object usuario, int id) {
        Usuario user = usuarioDAO.findUsuario(((Usuario) usuario).getId());
        List<Mensagem> mensagens = user.getPersonagem().getMensagens();
        for (int x = 0; x <= mensagens.size(); x++) {
            if (mensagens.get(x).getMensagemId() == id) {
                user.getPersonagem().getMensagens().get(x).setLida(true);
                try {
                    usuarioDAO.save(user);
                    return;
                } catch (Exception ex) {
                    Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public static void excluirMensagem(Object usuario, int id) {
        Usuario user = usuarioDAO.findUsuario(((Usuario) usuario).getId());
        List<Mensagem> mensagens = user.getPersonagem().getMensagens();
        for (int x = 0; x <= mensagens.size(); x++) {
            if (mensagens.get(x).getMensagemId() == id) {
                user.getPersonagem().getMensagens().remove(x);
                try {
                    usuarioDAO.save(user);
                    return;
                } catch (Exception ex) {
                    Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
                }
            }
        }
    }

    public static String darEquipamento(Personagem de, Personagem para, int equipamentoId) {

        de = personagemDAO.findPersonagem(de.getPersonagemId());
        para = personagemDAO.findPersonagem(para.getPersonagemId());

        Locale localDe = new Locale(de.getUsuario().getIdioma());
        ResourceBundle i18nDe = ResourceBundle.getBundle("i18n.text", localDe);

        if (de.procurarEquipamento(equipamentoId)) {
            Equipamento equipamento = de.removerEquipamento(equipamentoId);
            para.getEquipamentos().add(equipamento);

            Locale local = new Locale(para.getUsuario().getIdioma());
            i18n = ResourceBundle.getBundle("i18n.text", local);

            if (equipamento.getPremium() == true && para.getUsuario().getPremium() == false) {
                return i18nDe.getString("result.daritem.nopremium");
            }

            if (para.procurarEquipamento(equipamentoId)) {
                return i18nDe.getString("result.daritem.alreadyhave");
            }

            Mensagem msg = new Mensagem();
            msg.setTitulo(i18n.getString("message.text.newitem1"));
            msg.setPersonagemRemetente("System.item");
            msg.setLida(false);
            msg.setTexto("<a href=\"../character/character.jsp?character=" + de.getNome()
                    + "\">" + de.getNome() + "</a> " + i18n.getString("message.text.newitem2")
                    + " <a href=\"../character/equipments.jsp\">"
                    + i18n.getString(equipamento.getNome()) + "</a>.");
            msg.setPersonagemDestinatario(para);
            para.getMensagens().add(msg);
            try {
                personagemDAO.save(de);
                personagemDAO.save(para);
                return i18nDe.getString("result.daritem");
            } catch (Exception ex) {
                return i18nDe.getString("generic.error");
            }
        } else {
            return i18nDe.getString("result.daritem.youdonthave");
        }

    }

    public static String darArma(Personagem de, Personagem para, int armaId) {

        de = personagemDAO.findPersonagem(de.getPersonagemId());
        para = personagemDAO.findPersonagem(para.getPersonagemId());

        Locale localDe = new Locale(de.getUsuario().getIdioma());
        ResourceBundle i18nDe = ResourceBundle.getBundle("i18n.text", localDe);

        if (de.procurarArma(armaId)) {
            Arma arma = de.removerArma(armaId);
            para.getArmas().add(arma);

            if (arma.getPremium() == true && para.getUsuario().getPremium() == false) {
                return i18nDe.getString("result.daritem.nopremium");
            }

            if (para.procurarEquipamento(armaId)) {
                return i18nDe.getString("result.daritem.alreadyhave");
            }

            Locale local = new Locale(para.getUsuario().getIdioma());
            i18n = ResourceBundle.getBundle("i18n.text", local);

            Mensagem msg = new Mensagem();
            msg.setTitulo(i18n.getString("message.text.newitem1"));
            msg.setPersonagemRemetente("System.item");
            msg.setLida(false);
            msg.setTexto("<a href=\"../character/character.jsp?character="
                    + de.getNome() + "\">" + de.getNome() + "</a> "
                    + i18n.getString("message.text.newitem2")
                    + " <a href=\"../character/weapons.jsp\">"
                    + i18n.getString(arma.getNome()) + "</a>.");
            msg.setPersonagemDestinatario(para);
            para.getMensagens().add(msg);
            try {
                personagemDAO.save(de);
                personagemDAO.save(para);
                return i18nDe.getString("result.daritem");
            } catch (Exception ex) {
                return i18nDe.getString("generic.error");
            }
        } else {
            return i18nDe.getString("result.daritem.youdonthave");
        }

    }

    public static String atacarPersonagem(String personagem1, String personagem2) {
        Personagem p1, p2;
        p1 = personagemDAO.consultarPorNome(personagem1);
        p2 = personagemDAO.consultarPorNome(personagem2);

        Locale localP1 = new Locale(p1.getUsuario().getIdioma());
        ResourceBundle i18nP1 = ResourceBundle.getBundle("i18n.text", localP1);

        Locale localP2 = new Locale(p1.getUsuario().getIdioma());
        ResourceBundle i18nP2 = ResourceBundle.getBundle("i18n.text", localP2);

        //personagem atingiu limite de derrotas do dia
        // ou personagem está em uma missão
        if (p2.getDerrotasNoDia() == Personagem.LIMITE_ATAQUES || p2.getMissao() != null) {
            return i18nP1.getString("batalha.text.naoencontrado");
        }

        //Strings para formar código html

        String batalha = "<div style=\"font-size: 13px; font-family:Segoe UI,Arial;\">",
                whiteDiv = "<div style=\"color: white;\">",
                blackDiv = "<div style=\"color: black;\">",
                p1Div = "<div style=\"color: "
                + p1.getCorHtmlDoPersonagem() + ";\">",
                p2Div = "<div style=\"color: "
                + p2.getCorHtmlDoPersonagem() + ";\">",
                sufDiv = "</div>",
                batalhaAdversario = "<div style=\"font-size: 13px; font-family:Segoe UI,Arial;\">"
                + blackDiv + i18nP2.getString("batalha.text.atacadopor")
                + " <a href=\"../character/character.jsp?character="
                + p1.getNome() + "\">" + p1.getNome() + "</a>" + ".<br>";

        //variáveis que serão usadas para as fórmulas
        double defesaP1, defesaP2,
                resultanteP1, resultanteP2,
                vidaP1, vidaP2,
                resultadoVidaP1, resultadoVidaP2;
        //x = n do turno, TURNOS = turnos maximo 
        int x = 0;
        final int TURNOS = 20;

        //Calcula a vida inicial.
        //Salva na String batalha (relatório da batalha)
        vidaP1 = p1.getVidaNaBatalha();
        resultadoVidaP1 = vidaP1;
        batalha = batalha + p1Div + i18nP1.getString("batalha.text.vidainicial")
                + " " + p1.getNome() + ": " + (int) vidaP1 + ".<br>" + sufDiv;

        vidaP2 = p2.getVidaNaBatalha();
        resultadoVidaP2 = vidaP2;
        batalha = batalha + p2Div + i18nP1.getString("batalha.text.vidainicial")
                + " " + p2.getNome() + ": " + (int) vidaP2 + ".<br><br>" + sufDiv;

        //Fazer enquanto ninguem morrer ou número de turnos não exceder
        while (resultadoVidaP1 != 0 && resultadoVidaP2 != 0 && x <= TURNOS) {
            //começa a contagem de turnos, de 1  a TURNOS.
            x++;
            //é passado para o log
            System.out.println("\nTurno: " + x);

            //calcula a defesa dos personagens
            defesaP1 = p1.getDefesaNaBatalha(p2.getNivel()) / 2;
            defesaP2 = p2.getDefesaNaBatalha(p1.getNivel()) / 2;

            //é passado para o log
            System.out.println("Defesa de " + p1.getNome() + ": " + defesaP1);
            System.out.println("Defesa de " + p2.getNome() + ": " + defesaP2);

            /**
             * calcula a resultante do personagem nesse método já e cálculado o
             * ataque do mesmo.
             *
             */
            resultanteP2 = p2.getHitDoPersonagem(p1.getNivel(), defesaP1);

            /**
             * Se a resultante for negativa, ou seja, o ataque for menor que a
             * defesa. A resultante é passada para zero, pois não é possível um
             * ataque que aumente a vida do adversário;
             */
            if (resultanteP2 < 0) {
                resultanteP2 = 0;
            }

            //adiciona ao relatório
            batalha = batalha + p1Div + p1.getNome() + " "
                    + i18nP1.getString("batalha.text.sofreudano") + " "
                    + (int) resultanteP2 + " "
                    + i18nP1.getString("batalha.text.pontos") + "<br>" + sufDiv;

            //calcula a resultante do personagem
            //nesse método já e cálculado o ataque do mesmo.
            resultanteP1 = p1.getHitDoPersonagem(p2.getNivel(), defesaP2);

            /**
             * Se a resultante for negativa, ou seja, o ataque for menor que a
             * defesa. A resultante é passada para zero, pois não é possível um
             * ataque que aumente a vida do adversário;
             */
            if (resultanteP1 < 0) {
                resultanteP1 = 0;
            }

            //adiciona ao relatório
            batalha = batalha + p2Div + p2.getNome() + " "
                    + i18nP1.getString("batalha.text.sofreudano") + " "
                    + (int) resultanteP1 + " "
                    + i18nP1.getString("batalha.text.pontos") + "<br>" + sufDiv;

            //é passado para o log
            System.out.println("\nHit de " + p1.getNome() + ": " + resultanteP1);
            System.out.println("Hit de " + p2.getNome() + ": " + resultanteP2);

            resultadoVidaP1 = resultadoVidaP1 - resultanteP2;

            /**
             * Se a vida for menor que zero, ela é passada para zero, pois não
             * existe vida negativa.
             */
            if (resultadoVidaP1 < 0) {
                resultadoVidaP1 = 0;
            }


            resultadoVidaP2 = resultadoVidaP2 - resultanteP1;

            /**
             * Se a vida for menor que zero, ela é passada para zero, pois não
             * existe vida negativa.
             */
            if (resultadoVidaP2 < 0) {
                resultadoVidaP2 = 0;
            }

            //é passado para o log
            System.out.println("\nVida de " + p1.getNome() + ": " + resultadoVidaP1);
            System.out.println("Vida de " + p2.getNome() + ": " + resultadoVidaP2);
        }

        //variáveis do resultado da batalha
        int moedas, experiencia, nivelP1, nivelP2;

        //quem ganhou
        if (resultadoVidaP1 < resultadoVidaP2) {

            //calcula quantidade de moedas ganhas/perdidas
            moedas = Personagem.calcularMudancaMoedas(p1, p2, false);

            //calcula quantidade de experiencia ganha/perdida
            experiencia = Personagem.calcularMudancaExperiencia(p1, p2, false);

            //atualiza moedas, experiencia e nível.
            p1.setMoedas(p1.getMoedas() - moedas);
            p1.setExperiencia(p1.getExperiencia() - experiencia);
            nivelP1 = -1 * p1.atualizarNivel();

            //atualiza moedas, experiencia e nível.
            p2.setMoedas(p2.getMoedas() + moedas);
            p2.setExperiencia(p2.getExperiencia() + experiencia);
            nivelP2 = p2.atualizarNivel();

            //atualiza relatório
            batalha = batalha + p1Div + "<br>" + p1.getNome()
                    + i18nP1.getString("batalha.text.morreu")
                    + "<br><br>" + sufDiv;

            //perdeu moeda?
            if (moedas != 0) {
                //atualiza relatório
                batalha = batalha + whiteDiv
                        + i18nP1.getString("batalha.text.voceperdeu")
                        + " " + moedas
                        + " " + i18nP1.getString("batalha.text.moedas")
                        + "<br>";
            }

            //perdeu experiencia?
            if (experiencia != 0) {
                //atualiza relatório
                batalha = batalha + i18nP1.getString("batalha.text.voceperdeu")
                        + " " + experiencia
                        + " " + i18nP1.getString("batalha.text.exp") + "<br>";
            }

            //caiu de nivel?
            if (nivelP1 != 0) {
                batalha = batalha + i18nP1.getString("batalha.text.vocecaiu")
                        + " " + nivelP1 + " "
                        + i18nP1.getString("batalha.text.nivel")
                        + "<br>" + sufDiv + sufDiv;
            }

            //fecha relatório
            batalha = batalha + sufDiv + sufDiv;
            batalha = "<div style=\"font-size: 22px;color: red; font-family:Segoe UI,Arial;\">"
                    + i18nP1.getString("batalha.text.perdeubatalha")
                    + "</div><br>" + batalha;

            /**
             * Aqui começa o código para criar a mensagem para o outro
             * personagem.
             */
            //ganhou moeda?
            if (moedas != 0) {
                batalhaAdversario = batalhaAdversario
                        + i18nP2.getString("batalha.text.voceganhou")
                        + " " + moedas + " "
                        + i18nP2.getString("batalha.text.moedas") + "<br>";
            }

            //ganhou experiência?
            if (experiencia != 0) {
                batalhaAdversario = batalhaAdversario
                        + i18nP2.getString("batalha.text.voceganhou")
                        + " " + experiencia + " "
                        + i18nP2.getString("batalha.text.exp") + "<br>";
            }

            //subiu de nível?
            if (nivelP2 != 0) {
                batalhaAdversario = batalhaAdversario
                        + i18nP2.getString("batalha.text.vocesubiu") + nivelP2
                        + i18nP2.getString("batalha.text.nivel") + ".<br>";
            }

            //fecha mensagem
            batalhaAdversario = batalhaAdversario + sufDiv + sufDiv;
            batalhaAdversario = "<div style=\"font-size: 22px;color: red; font-family:Segoe UI,Arial;\">"
                    + i18nP2.getString("batalha.text.ganhoubatalha")
                    + "</div><br>" + batalhaAdversario;

        } else {

            //calcula ganho/perda de moedas
            moedas = Personagem.calcularMudancaMoedas(p1, p2, true);

            //calcula ganho/perda de experiência
            experiencia = Personagem.calcularMudancaExperiencia(p1, p2, true);

            //atualiza personagem 1 com novos valores
            p1.setMoedas(p1.getMoedas() + moedas);
            p1.setExperiencia(p1.getExperiencia() + experiencia);
            nivelP1 = p1.atualizarNivel();

            //atualiza personagem 2 com novos valores
            p2.setMoedas(p2.getMoedas() - moedas);
            p2.setExperiencia(p2.getExperiencia() - experiencia);
            nivelP2 = -1 * p2.atualizarNivel();
            
            //limita derrotas
            p2.setDerrotasNoDia(p2.getDerrotasNoDia()+1);
            GregorianCalendar calendar = new GregorianCalendar();
            calendar.setTime(new Date(System.currentTimeMillis()));
            p2.setDataUltimaDerrota(calendar);

            //atualiza relatorio
            batalha = batalha + p2Div + "<br>" + p2.getNome() + " "
                    + i18nP1.getString("batalha.text.morreu")
                    + "<br><br>" + sufDiv;

            //ganhou moedas?
            if (moedas != 0) {
                batalha = batalha + whiteDiv
                        + i18nP1.getString("batalha.text.voceganhou")
                        + " " + moedas + " "
                        + i18nP1.getString("batalha.text.moedas") + "<br>";
            }

            //ganhou experiência?
            if (experiencia != 0) {
                batalha = batalha + i18nP1.getString("batalha.text.voceganhou")
                        + " " + experiencia + " "
                        + i18nP1.getString("batalha.text.exp") + "<br>";
            }

            //subiu de nível?
            if (nivelP1 != 0) {
                batalha = batalha + i18nP1.getString("batalha.text.vocesubiu")
                        + " " + nivelP1 + " "
                        + i18nP1.getString("batalha.text.nivel") + "<br>";
            }

            //fecha relatório
            batalha = batalha + sufDiv + sufDiv;
            batalha = "<div style=\"font-size: 22px;color: white; font-family:Segoe UI,Arial;\">"
                    + i18nP1.getString("batalha.text.ganhoubatalha")
                    + "!</div><br>" + batalha;

            //Mensagem do Adversário

            //perdeu moedas?
            if (moedas != 0) {
                batalhaAdversario = batalhaAdversario
                        + i18nP2.getString("batalha.text.voceperdeu")
                        + " " + moedas
                        + " " + i18nP2.getString("batalha.text.moedas") + "<br>";
            }

            //perdeu experiência?
            if (experiencia != 0) {
                batalhaAdversario = batalhaAdversario
                        + i18nP2.getString("batalha.text.voceperdeu")
                        + " " + experiencia
                        + " " + i18nP2.getString("batalha.text.exp") + "<br>";
            }

            //caiu de nível?
            if (nivelP2 != 0) {
                batalhaAdversario = batalhaAdversario
                        + i18nP2.getString("batalha.text.vocecaiu")
                        + " " + nivelP2
                        + " " + i18nP2.getString("batalha.text.nivel") + "<br>";
            }

            //fecha mensagem
            batalhaAdversario = batalhaAdversario + sufDiv + sufDiv;
            batalhaAdversario = "<div style=\"font-size: 22px;color: black; font-family:Segoe UI,Arial;\">"
                    + i18nP2.getString("batalha.text.perdeubatalha")
                    + "</div><br>" + batalhaAdversario;
        }

        //Configura a mensagem
        Mensagem msg = new Mensagem();
        msg.setLida(false);
        msg.setPersonagemRemetente("System.attack");
        msg.setPersonagemDestinatario(p2);
        msg.setTitulo(i18nP2.getString("batalha.text.mensagem"));
        msg.setTexto(batalhaAdversario);

        //Adiciona mensagem ao personagem.
        p2.getMensagens().add(msg);

        //Atualiza saúde dos personagens.
        p1.setVidaFinal(resultadoVidaP1);
        p2.setVidaFinal(resultadoVidaP2);

        try {
            //Tenta salvar personagens.
            personagemDAO.save(p1);
            personagemDAO.save(p2);

        } catch (Exception ex) {
            Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
        }

        //retorna o relatório
        return batalha;
    }

    public static String curarPersonagem(Object usuario, int cura, int moedas) {
        Personagem personagem = personagemDAO.findPersonagem(
                ((Usuario) usuario).getPersonagem().getPersonagemId());

        Locale local = new Locale(personagem.getUsuario().getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", local);

        if (personagem.getMoedas() >= moedas) {

            if (personagem.getSaude() < 100) {

                personagem.setMoedas(personagem.getMoedas() - moedas);
                personagem.setSaude(personagem.getSaude() + cura);
                if (personagem.getSaude() > 100) {
                    personagem.setSaude(100);
                }

                try {
                    personagemDAO.save(personagem);
                    return i18n.getString("hospital.result.healed");
                } catch (Exception ex) {
                    return i18n.getString("hospital.result.error");
                }
            } else {
                return i18n.getString("hospital.result.fullhealth");
            }

        } else {
            return i18n.getString("result.nomoney");
        }


    }

    public static List<Equipamento> getListaEquipamentos() {
        return equipamentoDAO.findEquipamentoEntities();
    }

    public static Equipamento getEquipamentoDaListaDeEquipamentos(int x) {
        return ManipularDados.getListaEquipamentos().get(x);
    }

    public static List<Arma> getListaArmas() {
        return armaDAO.findArmaEntities();
    }

    public static Arma getArmaDaListaDeArmas(int x) {
        return ManipularDados.getListaArmas().get(x);
    }

    public static String comprarArma(Usuario usuario, String armaNome) {
        Personagem personagem = personagemDAO.findPersonagem(usuario.getPersonagem().getPersonagemId());
        Arma arma = armaDAO.consultarPorNome(armaNome);

        Locale local = new Locale(personagem.getUsuario().getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", local);

        if (arma.getPremium() == true && personagem.getUsuario().getPremium() == false) {
            return i18n.getString("result.weapon.nopremium");
        }

        if (personagem.procurarArma(arma.getArmaId())) {
            return i18n.getString("armament.result.alreadyhaveweapon");
        }

        if (personagem.getMoedas() < arma.getPreco()) {
            return i18n.getString("result.nomoney");
        }

        if (personagem.getClasse().equals("classe_ork") || personagem.getClasse().equals("classe_ciclope")) {
            return i18n.getString("result.weapon.classnotsupported");
        }

        personagem.getArmas().add(arma);
        personagem.setMoedas(personagem.getMoedas() - arma.getPreco());
        try {
            personagemDAO.save(personagem);
            return i18n.getString("armament.result.weaponbought");
        } catch (Exception ex) {
            return i18n.getString("armament.result.error");
        }

    }

    public static String comprarEquipamento(Usuario usuario, String equipamentoNome) {
        Personagem personagem = personagemDAO.findPersonagem(usuario.getPersonagem().getPersonagemId());
        Equipamento equipamento = equipamentoDAO.consultarPorNome(equipamentoNome);

        Locale local = new Locale(personagem.getUsuario().getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", local);

        if (equipamento.getPremium() == true && personagem.getUsuario().getPremium() == false) {
            return i18n.getString("result.equipament.nopremium");
        }

        if (personagem.procurarArma(equipamento.getEquipamentoId())) {
            return i18n.getString("armament.result.alreadyhaveequipment");
        }

        if (personagem.getMoedas() < equipamento.getPreco()) {
            return i18n.getString("result.nomoney");
        }

        personagem.getEquipamentos().add(equipamento);
        personagem.setMoedas(personagem.getMoedas() - equipamento.getPreco());
        try {
            personagemDAO.save(personagem);
            return i18n.getString("armament.result.equipmentbought");
        } catch (Exception ex) {
            return i18n.getString("armament.result.error");
        }

    }

    public static String deletarPersonagem(Usuario usuario) {
        Usuario u = usuarioDAO.findUsuario(usuario.getId());

        Locale local = new Locale(u.getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", local);

        int id = u.getPersonagem().getPersonagemId();

        try {
            u.setPersonagem(null);
            usuarioDAO.save(u);
            return i18n.getString("preferences.text.characterdeleted");
        } catch (Exception ex) {
            return i18n.getString("preferences.error.deletechar");
        }

    }

    public static String mudarSenha(Usuario usuario, String senhaAntiga, String senhaNova1, String senhaNova2) {
        Usuario u = usuarioDAO.findUsuario(usuario.getId());

        Locale local = new Locale(u.getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", local);

        if (!senhaNova1.equals(senhaNova2)) {
            return i18n.getString("preferences.error.newpasswrong");
        }

        if (!u.getSenha().equals(senhaAntiga)) {
            return i18n.getString("preferences.error.passwrong");
        }

        u.setSenha(senhaNova1);
        try {
            usuarioDAO.save(u);
            return i18n.getString("preferences.result.changepassword");
        } catch (Exception ex) {
            return i18n.getString("preferences.error.changepassword");
        }
    }

    public static String trocarIdioma(Usuario usuario, String idioma) {
        Usuario u = usuarioDAO.findUsuario(usuario.getId());
        Locale local = new Locale(u.getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", local);
        u.setIdioma(idioma);

        try {
            usuarioDAO.save(u);
            local = new Locale(u.getIdioma());
            i18n = ResourceBundle.getBundle("i18n.text", local);
            return i18n.getString("preferences.text.changelanguage");
        } catch (Exception ex) {
            return i18n.getString("preferences.error.changelanguage");
        }


    }

    public static List<Personagem> getRanking() {
        List<Personagem> lista = personagemDAO.findPersonagemEntities();

        int i, j, min, n = lista.size();
        Personagem x = new Personagem();
        for (i = 0; i < n - 1; i++) {
            min = i;
            for (j = i + 1; j < n; j++) {
                if (lista.get(j).getExperiencia() > lista.get(min).getExperiencia()) {
                    min = j;
                }
            }
            if (min != i) {
                x = lista.get(min);
                lista.set(min, lista.get(i));
                lista.set(i, x);
            }
        }
        return lista;
    }

    public static List<PersonagemPadrao> getListaDeClassesDoJogo() {
        return classeDAO.findPersonagemPadraoEntities();
    }

    public static String treinarPersonagem(Usuario usuario, int duracao, String atributo) {
        Usuario u = usuarioDAO.findUsuario(usuario.getId());
        Locale locale = new Locale(u.getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", locale);

        if (u.getPersonagem().getMissao() != null) {
            if (u.getPersonagem().getMissao().equals(Missao.TREINAMENTO)) {
                return i18n.getString("missao.error.ocupado.treino");
            } else {
                return i18n.getString("missao.error.ocupado.missao");
            }
        }

        String nome = atributo + ".treino.nome",
                descricao = atributo + ".treino.descricao";

        Missao missao = CriarObjeto.criarMissao(Missao.TREINAMENTO,
                duracao, nome, 0, 0,
                0, descricao);

        u.getPersonagem().setMissao(missao);

        try {
            usuarioDAO.save(u);
            return i18n.getString("missao.treino.iniciado");
        } catch (Exception ex) {
            return i18n.getString("missao.error.treino");
        }

    }

    public static void executarMissao(Personagem personagem) {
        personagem = personagemDAO.findPersonagem(personagem.getPersonagemId());
        Locale locale = new Locale(personagem.getUsuario().getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", locale);

        if (personagem.getMissao().getTipo().equals(Missao.TREINAMENTO)) {
            personagem.aumentarAtributoPersonagem(personagem.getMissao().getNome());

            Mensagem msg = CriarObjeto.criarMensagem(i18n.getString("treino.terminado.title"),
                    i18n.getString("treino.terminado.text") + " " + i18n.getString(personagem.getMissao().getNome()),
                    personagem, "System.train");
            personagem.getMensagens().add(msg);
            personagem.setMissao(null);
            try {
                personagemDAO.save(personagem);
            } catch (Exception ex) {
                Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else {
            //Voce terminou a missao x.
            String texto = i18n.getString("missao.terminado.text")
                    + " " + i18n.getString(personagem.getMissao().getNome());

            //Verifica se a missão deu certo
            if (personagem.getMissao().missaoDeuCerto()) {
                personagem.setExperiencia(personagem.getExperiencia() + personagem.getMissao().getGanhoExperiencia());
                personagem.setMoedas(personagem.getMoedas() + personagem.getMissao().getGanhoMoedas());


                //você ganhou x moedas
                texto = texto + "<br>" + i18n.getString("ganhou") + " "
                        + personagem.getMissao().getGanhoMoedas() + " "
                        + i18n.getString("moedas");

                //você ganhou x pontos de experiencia
                texto = texto + "<br>" + i18n.getString("ganhou") + " "
                        + personagem.getMissao().getGanhoExperiencia() + " "
                        + i18n.getString("pts_exp");

            } else {
                //Você falhou na missão.
                texto = texto + "<br>" + i18n.getString("missao.terminado.falho");

            }

            Mensagem msg = CriarObjeto.criarMensagem(i18n.getString("missao.terminado.title"),
                    texto,
                    personagem, "System.mission");
            personagem.getMensagens().add(msg);
            personagem.setMissao(null);
            try {
                personagemDAO.save(personagem);
            } catch (Exception ex) {
                Logger.getLogger(ManipularDados.class.getName()).log(Level.SEVERE, null, ex);
            }



        }

    }

    public static String excluirMissao(Usuario usuario) {
        usuario = usuarioDAO.findUsuario(usuario.getId());
        Locale locale = new Locale(usuario.getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", locale);

        usuario.getPersonagem().setMissao(null);

        try {
            usuarioDAO.save(usuario);
            return i18n.getString("missionpage.text.cancelado");
        } catch (Exception ex) {
            return i18n.getString("missionpage.error.error");
        }

    }

    public static String iniciarMissao(Usuario usuario, String nome) {
        Personagem personagem = personagemDAO.findPersonagem(usuario.getPersonagem().getPersonagemId());
        Locale locale = new Locale(personagem.getUsuario().getIdioma());
        i18n = ResourceBundle.getBundle("i18n.text", locale);

        nome = "missao." + nome;
        int duracao, ganhoMoedas, ganhoExperiencia, dificuldade;

        duracao = Integer.parseInt(i18n.getString(nome + ".duracao"));
        ganhoMoedas = Integer.parseInt(i18n.getString(nome + ".moedas"));
        ganhoExperiencia = Integer.parseInt(i18n.getString(nome + ".xp"));
        dificuldade = Integer.parseInt(i18n.getString(nome + ".dificuldade"));

        if (personagem.getMissao() != null) {
            if (personagem.getMissao().equals(Missao.TREINAMENTO)) {
                return i18n.getString("missao.error.ocupado.treino");
            } else {
                return i18n.getString("missao.error.ocupado.missao");
            }
        }


        Missao missao = CriarObjeto.criarMissao(Missao.MISSAO, duracao, nome + ".nome", dificuldade, ganhoMoedas, ganhoExperiencia, nome + ".descricao");

        personagem.setMissao(missao);

        try {
            personagemDAO.save(personagem);
            return i18n.getString("missao.missao.iniciado");
        } catch (Exception ex) {
            return i18n.getString("missao.error.missao");
        }


    }
}
