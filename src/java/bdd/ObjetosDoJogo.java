/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package bdd;

import dao.ArmaDAO;
import dao.EquipamentoDAO;
import dao.HabilidadeDAO;
import dao.PersonagemPadraoDAO;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import objetos.Arma;
import objetos.Equipamento;
import objetos.Habilidade;
import objetos.PersonagemPadrao;

/**
 *
 * @author Guilherme
 */
public class ObjetosDoJogo {

    public static void criarDados() {
        ObjetosDoJogo.criarArmas();
        ObjetosDoJogo.criarEquipamentos();
        ObjetosDoJogo.criarHabilidades();
        ObjetosDoJogo.criarClasses();
    }

    public static void criarClasses() {
        PersonagemPadraoDAO pdao = new PersonagemPadraoDAO();
        EquipamentoDAO equipamentoDAO = new EquipamentoDAO();
        ArmaDAO armadao = new ArmaDAO();
        List<PersonagemPadrao> entities = pdao.findPersonagemPadraoEntities();
        if (entities.size() < 9) {
            for (int x = 0; x < entities.size(); x++) {
                try {
                    pdao.delete(entities.get(x).getId());
                } catch (Exception ex) {
                    Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            PersonagemPadrao ppHCientista = new PersonagemPadrao();
            ppHCientista.setAtributos(10, 3, 3, 5, 7, 5);
            ppHCientista.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppHCientista.setEspecie("especie_humana");
            ppHCientista.setClasse("classe_cientista");
            ppHCientista.setArma(armadao.consultarPorNome("gun.9mm.name"));

            PersonagemPadrao ppHCivil = new PersonagemPadrao();
            ppHCivil.setAtributos(7, 5, 3, 7, 10, 5);
            ppHCivil.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppHCivil.setEspecie("especie_humana");
            ppHCivil.setClasse("classe_civil");
            ppHCivil.setArma(armadao.consultarPorNome("gun.9mm.name"));

            PersonagemPadrao ppHSoldado = new PersonagemPadrao();
            ppHSoldado.setAtributos(5, 7, 3, 7, 10, 5);
            ppHSoldado.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppHSoldado.setEspecie("especie_humana");
            ppHSoldado.setClasse("classe_soldado");
            ppHSoldado.setArma(armadao.consultarPorNome("gun.9mm.name"));

            PersonagemPadrao ppACiclope = new PersonagemPadrao();
            ppACiclope.setAtributos(3, 10, 7, 3, 5, 7);
            ppACiclope.setArma(null);
            ppACiclope.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppACiclope.setEspecie("especie_ashen");
            ppACiclope.setClasse("classe_ciclope");

            PersonagemPadrao ppACivil = new PersonagemPadrao();
            ppACivil.setAtributos(5, 7, 5, 3, 10, 7);
            ppACivil.setArma(armadao.consultarPorNome("gun.9mm.name"));
            ppACivil.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppACivil.setEspecie("especie_ashen");
            ppACivil.setClasse("classe_civil");

            PersonagemPadrao ppASoldado = new PersonagemPadrao();
            ppASoldado.setAtributos(3, 7, 5, 5, 10, 7);
            ppASoldado.setArma(armadao.consultarPorNome("gun.9mm.name"));
            ppASoldado.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppASoldado.setEspecie("especie_ashen");
            ppASoldado.setClasse("classe_soldado");

            PersonagemPadrao ppVOrk = new PersonagemPadrao();
            ppVOrk.setAtributos(3, 10, 7, 5, 5, 7);
            ppVOrk.setArma(null);
            ppVOrk.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppVOrk.setEspecie("especie_vendetta");
            ppVOrk.setClasse("classe_ork");

            PersonagemPadrao ppVMecanico = new PersonagemPadrao();
            ppVMecanico.setAtributos(10, 3, 5, 3, 7, 7);
            ppVMecanico.setArma(armadao.consultarPorNome("gun.9mm.name"));
            ppVMecanico.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppVMecanico.setEspecie("especie_vendetta");
            ppVMecanico.setClasse("classe_mecanico");

            PersonagemPadrao ppVSoldado = new PersonagemPadrao();
            ppVSoldado.setAtributos(3, 7, 5, 3, 10, 7);
            ppVSoldado.setArma(armadao.consultarPorNome("gun.9mm.name"));
            ppVSoldado.setEquipamento(equipamentoDAO.consultarPorNome("equipment.armorleather.name"));
            ppVSoldado.setEspecie("especie_vendetta");
            ppVSoldado.setClasse("classe_soldado");

            try {
                pdao.save(ppHCientista);
                pdao.save(ppHCivil);
                pdao.save(ppHSoldado);
                pdao.save(ppACiclope);
                pdao.save(ppACivil);
                pdao.save(ppASoldado);
                pdao.save(ppVOrk);
                pdao.save(ppVMecanico);
                pdao.save(ppVSoldado);
            } catch (Exception ex) {
                Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void criarArmas() {
        ArmaDAO adao = new ArmaDAO();
        List<Arma> entities = adao.findArmaEntities();
        if (entities.size() < 10) {
            for (int x = 0; x < entities.size(); x++) {
                try {
                    adao.delete(entities.get(x).getArmaId());
                } catch (Exception ex) {
                    Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            Arma arma1 = new Arma();
            arma1.setNome("gun.9mm.name");
            arma1.setDescricao("gun.9mm.description");
            arma1.setAtaque(5);
            arma1.setImagem("imagens/armas/arma1.png");
            arma1.setPreco(100);
            arma1.setPremium(false);

            Arma arma2 = new Arma();
            arma2.setNome("gun.38mm.name");
            arma2.setDescricao("gun.38mm.description");
            arma2.setAtaque(10);
            arma2.setImagem("imagens/armas/arma2.png");
            arma2.setPreco(1000);
            arma2.setPremium(false);

            Arma arma3 = new Arma();
            arma3.setNome("gun.deserteagle.name");
            arma3.setDescricao("gun.deserteagle.description");
            arma3.setAtaque(15);
            arma3.setImagem("imagens/armas/arma3.png");
            arma3.setPreco(2000);
            arma3.setPremium(false);

            Arma arma4 = new Arma();
            arma4.setNome("gun.mp5.name");
            arma4.setDescricao("gun.mp5.description");
            arma4.setAtaque(20);
            arma4.setImagem("imagens/armas/arma4.png");
            arma4.setPreco(3000);
            arma4.setPremium(false);

            Arma arma5 = new Arma();
            arma5.setNome("gun.kiparis.name");
            arma5.setDescricao("gun.kiparis.description");
            arma5.setAtaque(25);
            arma5.setImagem("imagens/armas/arma5.png");
            arma5.setPreco(5000);
            arma5.setPremium(false);

            Arma arma6 = new Arma();
            arma6.setNome("gun.aug.name");
            arma6.setDescricao("gun.aug.description");
            arma6.setAtaque(30);
            arma6.setImagem("imagens/armas/arma6.png");
            arma6.setPreco(10000);
            arma6.setPremium(false);

            Arma arma7 = new Arma();
            arma7.setNome("gun.famas.name");
            arma7.setDescricao("gun.famas.description");
            arma7.setAtaque(35);
            arma7.setImagem("imagens/armas/arma7.png");
            arma7.setPreco(15000);
            arma7.setPremium(false);

            Arma arma8 = new Arma();
            arma8.setNome("gun.ak47.name");
            arma8.setDescricao("gun.ak47.description");
            arma8.setAtaque(40);
            arma8.setImagem("imagens/armas/arma8.png");
            arma8.setPreco(25000);
            arma8.setPremium(false);

            Arma arma9 = new Arma();
            arma9.setNome("gun.commando.name");
            arma9.setDescricao("gun.commando.description");
            arma9.setAtaque(45);
            arma9.setImagem("imagens/armas/arma9.png");
            arma9.setPreco(40000);
            arma9.setPremium(false);

            Arma arma10 = new Arma();
            arma10.setNome("gun.m16.name");
            arma10.setDescricao("gun.m16.description");
            arma10.setAtaque(50);
            arma10.setImagem("imagens/armas/arma10.png");
            arma10.setPreco(75000);
            arma10.setPremium(true);

            try {
                adao.save(arma1);
                adao.save(arma2);
                adao.save(arma3);
                adao.save(arma4);
                adao.save(arma5);
                adao.save(arma6);
                adao.save(arma7);
                adao.save(arma8);
                adao.save(arma9);
                adao.save(arma10);
            } catch (Exception ex) {
                Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }

    public static void criarHabilidades() {
        HabilidadeDAO hdao = new HabilidadeDAO();

        List<Habilidade> entities = hdao.findHabilidadeEntities();
        if (entities.size() < 2) {
            for (int x = 0; x < entities.size(); x++) {
                try {
                    hdao.delete(entities.get(x).getHabilidadeId());
                } catch (Exception ex) {
                    Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            Habilidade h1 = new Habilidade();
            h1.setNome("skill.balaoca.name");
            h1.setDescricao("skill.balaoca.description");
            h1.setEfeito("skill.balaoca.effect");
            h1.setSemRequisitos();
            h1.setClasse1("classe_soldado");
            h1.setClasse2("");
            h1.setAtaque(3);
            h1.setDefesa(0);

            Habilidade h2 = new Habilidade();
            h2.setNome("skill.golpeduplo.name");
            h2.setDescricao("skill.golpeduplo.description");
            h2.setEfeito("skill.golpeduplo.effect");
            h2.setSemRequisitos();
            h2.setClasse1("");
            h2.setClasse2("");
            h2.setAtaque(2);
            h2.setDefesa(0);

            try {
                hdao.save(h1);
                hdao.save(h2);
            } catch (Exception ex) {
                Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
            }

        }
    }

    public static void criarEquipamentos() {
        EquipamentoDAO edao = new EquipamentoDAO();

        List<Equipamento> entities = edao.findEquipamentoEntities();
        if (entities.size() < 10) {
            for (int x = 0; x < entities.size(); x++) {
                try {
                    edao.delete(entities.get(x).getEquipamentoId());
                } catch (Exception ex) {
                    Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            Equipamento e1 = new Equipamento();
            e1.setNome("equipment.armorleather.name");
            e1.setDefesa(5);
            e1.setDescricao("equipment.armorleather.description");
            e1.setImagem("imagens/equipamentos/equipamento1.png");
            e1.setPreco(100);
            e1.setPremium(false);

            Equipamento e2 = new Equipamento();
            e2.setNome("equipment.armorplastic.name");
            e2.setDefesa(10);
            e2.setDescricao("equipment.armorplastic.description");
            e2.setImagem("imagens/equipamentos/equipamento2.png");
            e2.setPreco(1000);
            e2.setPremium(false);

            Equipamento e3 = new Equipamento();
            e3.setNome("equipment.armorwood.name");
            e3.setDefesa(15);
            e3.setDescricao("equipment.armorwood.description");
            e3.setImagem("imagens/equipamentos/equipamento3.png");
            e3.setPreco(2000);
            e3.setPremium(false);

            Equipamento e4 = new Equipamento();
            e4.setNome("equipment.armoriron.name");
            e4.setDefesa(20);
            e4.setDescricao("equipment.armoriron.description");
            e4.setImagem("imagens/equipamentos/equipamento4.png");
            e4.setPreco(3000);
            e4.setPremium(false);

            Equipamento e5 = new Equipamento();
            e5.setNome("equipment.armorbronze.name");
            e5.setDefesa(25);
            e5.setDescricao("equipment.armorbronze.description");
            e5.setImagem("imagens/equipamentos/equipamento5.png");
            e5.setPreco(5000);
            e5.setPremium(false);

            Equipamento e6 = new Equipamento();
            e6.setNome("equipment.armorsilver.name");
            e6.setDefesa(30);
            e6.setDescricao("equipment.armorsilver.description");
            e6.setImagem("imagens/equipamentos/equipamento6.png");
            e6.setPreco(7500);
            e6.setPremium(false);

            Equipamento e7 = new Equipamento();
            e7.setNome("equipment.armorgold.name");
            e7.setDefesa(35);
            e7.setDescricao("equipment.armorgold.description");
            e7.setImagem("imagens/equipamentos/equipamento7.png");
            e7.setPreco(10000);
            e7.setPremium(false);

            Equipamento e8 = new Equipamento();
            e8.setNome("equipment.armorflak.name");
            e8.setDefesa(40);
            e8.setDescricao("equipment.armorflak.description");
            e8.setImagem("imagens/equipamentos/equipamento8.png");
            e8.setPreco(20000);
            e8.setPremium(false);

            Equipamento e9 = new Equipamento();
            e9.setNome("equipment.armorspectra.name");
            e9.setDefesa(45);
            e9.setDescricao("equipment.armorspectra.description");
            e9.setImagem("imagens/equipamentos/equipamento9.png");
            e9.setPreco(30000);
            e9.setPremium(false);

            Equipamento e10 = new Equipamento();
            e10.setNome("equipment.armordiamond.name");
            e10.setDefesa(50);
            e10.setDescricao("equipment.armordiamond.description");
            e10.setImagem("imagens/equipamentos/equipamento10.png");
            e10.setPreco(50000);
            e10.setPremium(true);

            try {
                edao.save(e1);
                edao.save(e2);
                edao.save(e3);
                edao.save(e4);
                edao.save(e5);
                edao.save(e6);
                edao.save(e7);
                edao.save(e8);
                edao.save(e9);
                edao.save(e10);
            } catch (Exception ex) {
                Logger.getLogger(ObjetosDoJogo.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
}
