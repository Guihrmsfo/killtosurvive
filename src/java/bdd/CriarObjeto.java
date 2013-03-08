/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bdd;

import dao.*;
import email.EmailSessionBean;
import java.text.DateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import objetos.*;

/**
 *
 * @author Guilherme
 */
public class CriarObjeto {

    public static boolean criarPersonagem(String nome, String u, int c, int sexo, String imagem) {
        UsuarioDAO udao = new UsuarioDAO();
        PersonagemPadraoDAO pdao = new PersonagemPadraoDAO();
        Usuario usuario = udao.consultarPorNome(u);
        PersonagemPadrao classe = pdao.findPersonagemPadrao(c);

        System.out.println(nome + " " + usuario.getUsuario() + " " + classe.getClasse() + "-" + classe.getEspecie());
        Personagem personagem = PersonagemPadrao.createCharacter(classe, nome, sexo, imagem);

        try {
            usuario.setPersonagem(personagem);
            System.out.println("usuario-personagem");
            udao.save(usuario);
            System.out.println("salvo usuario");
        } catch (Exception ex) {
            System.out.println(ex);
            return false;
        }
        return true;
    }

    public static int criarUsuario(String nome, String senha, String senha2, String email, String email2, String idioma, String aceitaRegras) {
        Usuario novo = new Usuario();
        novo.setUsuario(nome);
        novo.setSenha(senha);
        novo.setEmail(email);
        novo.setIdioma(idioma);
        novo.setValido(false);
        novo.setPersonagem(null);
        novo.setDataPremium(null);
        novo.setPremium(false);

        if (nome != null && senha != null && senha2 != null
                && email != null && email2 != null
                && (!"".equals(nome)) && senha != null
                && (!"".equals(senha2)) && (!"".equals(email))
                && (!"".equals(email2))) {


            if ("ON".equals(aceitaRegras)) {
                if (novo.getEmail().equals(email2)) {
                    if (novo.getSenha().equals(senha2)) {
                        if (CriarObjeto.contemCaracteresEspeciais(nome)) {
                            UsuarioDAO dao = new UsuarioDAO();
                            if (dao.consultarPorNome(novo.getUsuario()) == null) {
                                if (dao.consultarPorEmail(novo.getEmail()) == null) {

                                    try {
                                        dao.save(novo);
                                    } catch (Exception ex) {
                                        return -3; //erro do banco de dados
                                    }
                                    EmailSessionBean emailSession = new EmailSessionBean();
                                    if (emailSession.enviarEmail(novo.getEmail(),
                                            "Validar Conta Kill To Survive", null,
                                            EmailSessionBean.EMAILVALIDAR, novo)) {

                                        return -1;
                                        //Tudo correto, senão
                                    } else {
                                        //avisa que email nao foi enviado
                                        return -2;
                                    }

                                } else {
                                    return 5;
                                }


                            } else {
                                return 4;
                            }
                        } else {
                            return 6;
                        }

                    } else {
                        return 3;
                    }

                } else {
                    return 2;
                }


            } else {
                return 0;
            }

        } else {
            return 1;
        }
    }

    public static boolean contemCaracteresEspeciais(String texto) {
        for (int c = 0; c < texto.length(); c++) {
            char ch = texto.charAt(c);
            System.out.println(c + " = " + ch);
            if (!((ch <= 91 && ch >= 65) || (ch <= 122 && ch >= 97))) {
                System.out.println("false");
                return false;
            }
        }
        return true;
    }

    public static Missao criarMissao(String tipoMissao, int duracao, String nome, int dificuldade, int ganhoMoedas, int ganhoExperiencia, String descricao) {
        Missao missao = new Missao();
        GregorianCalendar data = new GregorianCalendar();
        DateFormat formata = DateFormat.getDateTimeInstance();

        data.setTime(new Date(System.currentTimeMillis()));
        System.out.println("Data atual: " + formata.format(data.getTime()));

        missao.setNome(nome);
        missao.setDescricao(descricao);
        missao.setTipo(tipoMissao);

        //data.add(Calendar.HOUR_OF_DAY, duracao);
        data.add(Calendar.MINUTE, duracao);

        System.out.println("Data término da missão: " + formata.format(data.getTime()));

        missao.setDataTermino(data);

        if (tipoMissao.equals(Missao.TREINAMENTO)) {
            missao.setGanhoMoedas(0);
            missao.setDificuldade(0);
            missao.setGanhoExperiencia(0);
        } else {
            missao.setGanhoMoedas(ganhoMoedas);
            missao.setDificuldade(dificuldade);
            missao.setGanhoExperiencia(ganhoExperiencia);
        }

        return missao;
    }

    public static Mensagem criarMensagem(String titulo, String texto, Personagem destinatario, Personagem remetente) {
        Mensagem msg = new Mensagem();
        msg.setTitulo(titulo);
        msg.setTexto(texto);
        msg.setLida(false);
        msg.setPersonagemDestinatario(destinatario);
        msg.setPersonagemRemetente(remetente.getNome());
        return msg;
    }
    
    
    public static Mensagem criarMensagem(String titulo, String texto, Personagem destinatario, String remetente) {
        Mensagem msg = new Mensagem();
        msg.setTitulo(titulo);
        msg.setTexto(texto);
        msg.setLida(false);
        msg.setPersonagemDestinatario(destinatario);
        msg.setPersonagemRemetente(remetente);
        return msg;
    }
    
}
