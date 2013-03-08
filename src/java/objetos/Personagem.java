/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package objetos;

import dao.PersonagemPadraoDAO;
import dao.UsuarioDAO;
import java.io.Serializable;
import java.text.DateFormat;
import java.util.*;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Guilherme
 */
@Entity
@Table(name = "personagem", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Personagem.findAll", query = "SELECT p FROM Personagem p"),
    @NamedQuery(name = "Personagem.findByPersonagemId", query = "SELECT p FROM Personagem p WHERE p.personagemId = :personagemId"),
    @NamedQuery(name = "Personagem.findByNome", query = "SELECT p FROM Personagem p WHERE p.nome = :nome"),
    @NamedQuery(name = "Personagem.findByEspecie", query = "SELECT p FROM Personagem p WHERE p.especie = :especie"),
    @NamedQuery(name = "Personagem.findByClasse", query = "SELECT p FROM Personagem p WHERE p.classe = :classe"),
    @NamedQuery(name = "Personagem.findByImagem", query = "SELECT p FROM Personagem p WHERE p.imagem = :imagem"),
    @NamedQuery(name = "Personagem.findByNivel", query = "SELECT p FROM Personagem p WHERE p.nivel = :nivel"),
    @NamedQuery(name = "Personagem.findByExperiencia", query = "SELECT p FROM Personagem p WHERE p.experiencia = :experiencia"),
    @NamedQuery(name = "Personagem.findByInteligencia", query = "SELECT p FROM Personagem p WHERE p.inteligencia = :inteligencia"),
    @NamedQuery(name = "Personagem.findByForca", query = "SELECT p FROM Personagem p WHERE p.forca = :forca"),
    @NamedQuery(name = "Personagem.findByResistencia", query = "SELECT p FROM Personagem p WHERE p.resistencia = :resistencia"),
    @NamedQuery(name = "Personagem.findByAgilidade", query = "SELECT p FROM Personagem p WHERE p.agilidade = :agilidade"),
    @NamedQuery(name = "Personagem.findByDestreza", query = "SELECT p FROM Personagem p WHERE p.destreza = :destreza"),
    @NamedQuery(name = "Personagem.findByConstituicao", query = "SELECT p FROM Personagem p WHERE p.constituicao = :constituicao"),
    @NamedQuery(name = "Personagem.findByArma", query = "SELECT p FROM Personagem p WHERE p.arma = :arma"),
    @NamedQuery(name = "Personagem.findByEquipamento", query = "SELECT p FROM Personagem p WHERE p.equipamento = :equipamento"),
    @NamedQuery(name = "Personagem.findByMoedas", query = "SELECT p FROM Personagem p WHERE p.moedas = :moedas")})
public class Personagem implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "personagem_id")
    private Integer personagemId;
    @Size(max = 50)
    @Column(name = "especie")
    private String especie;
    @Size(max = 50)
    @Column(name = "classe")
    private String classe;
    @OneToMany(mappedBy = "personagemDestinatario", targetEntity = Mensagem.class, cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Mensagem> mensagens;
    @Size(max = 50)
    @Column(name = "nome")
    private String nome;
    @Column(name = "sexo")
    private int sexo;
    @Size(max = 500)
    @Column(name = "imagem")
    private String imagem;
    @Column(name = "nivel")
    private Integer nivel;
    @Column(name = "experiencia")
    private Integer experiencia;
    @Column(name = "inteligencia")
    private Integer inteligencia;
    @Column(name = "forca")
    private Integer forca;
    @Column(name = "resistencia")
    private Integer resistencia;
    @Column(name = "agilidade")
    private Integer agilidade;
    @Column(name = "destreza")
    private Integer destreza;
    @Column(name = "constituicao")
    private Integer constituicao;
    @Column(name = "arma")
    private Integer arma;
    @Column(name = "equipamento")
    private Integer equipamento;
    @Column(name = "moedas")
    private Integer moedas;
    @Column(name = "saude")
    private Integer saude;
    @Size(max = 20)
    @Column(name = "comportamentosuperior")
    private String comportamento_Superior;
    @Size(max = 20)
    @Column(name = "comportamentoigual")
    private String comportamento_Igual;
    @Size(max = 20)
    @Column(name = "comportamentoinferior")
    private String comportamento_Inferior;
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "personagem_arma",
    joinColumns = {
        @JoinColumn(name = "personagem_id")
    },
    inverseJoinColumns = {
        @JoinColumn(name = "arma_id")
    })
    private List<Arma> armas;
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "personagem_equipamento",
    joinColumns = {
        @JoinColumn(name = "personagem_id")
    },
    inverseJoinColumns = {
        @JoinColumn(name = "equipamento_id")
    })
    private List<Equipamento> equipamentos;
    @ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "personagem_habilidade",
    joinColumns = {
        @JoinColumn(name = "personagem_id")
    },
    inverseJoinColumns = {
        @JoinColumn(name = "habilidade_id")
    })
    private List<Habilidade> habilidades;
    @OneToOne(cascade = CascadeType.ALL, optional = true, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name = "missao", nullable = true)
    private Missao missao;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "dataUltimaCuraGratis", nullable = true)
    private Calendar dataUltimaCuraGratis;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "dataUltimaDerrota", nullable = true)
    private Calendar dataUltimaDerrota;
    @Column(name = "derrotasNoDia")
    private int derrotasNoDia;
    public static final int MALE = 0;
    public static final int FEMALE = 1;
    public static final int LIMITE_ATAQUES = 3;

    public Personagem() {
    }

    public Personagem(Integer personagemId) {
        this.personagemId = personagemId;
    }

    public Integer getPersonagemId() {
        return personagemId;
    }

    public void setPersonagemId(Integer personagemId) {
        this.personagemId = personagemId;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getImagem() {
        return imagem;
    }

    public String getImagemurl() {
        //para paginas que nao estão na raíz
        if (this.getImagem().startsWith("http")) {
            return imagem;
        } else {
            return "../" + imagem;
        }
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

    public Integer getNivel() {
        return nivel;
    }

    public void setNivel(Integer nivel) {
        this.nivel = nivel;
    }

    public Integer getExperiencia() {
        return experiencia;
    }

    public void setExperiencia(Integer experiencia) {
        if (experiencia < 0) {
            experiencia = 0;
        }
        this.experiencia = experiencia;
    }

    public Integer getInteligencia() {
        return inteligencia;
    }

    public void setInteligencia(Integer inteligencia) {
        this.inteligencia = inteligencia;
    }

    public Integer getForca() {
        return forca;
    }

    public void setForca(Integer forca) {
        this.forca = forca;
    }

    public Integer getResistencia() {
        return resistencia;
    }

    public void setResistencia(Integer resistencia) {
        this.resistencia = resistencia;
    }

    public Integer getAgilidade() {
        return agilidade;
    }

    public void setAgilidade(Integer agilidade) {
        this.agilidade = agilidade;
    }

    public Integer getDestreza() {
        return destreza;
    }

    public void setDestreza(Integer destreza) {
        this.destreza = destreza;
    }

    public Integer getConstituicao() {
        return constituicao;
    }

    public void setConstituicao(Integer constituicao) {
        this.constituicao = constituicao;
    }

    public Integer getArma() {
        return arma;
    }

    public void setArma(Integer arma) {
        this.arma = arma;
    }

    public Integer getEquipamento() {
        return equipamento;
    }

    public void setEquipamento(Integer equipamento) {
        this.equipamento = equipamento;
    }

    public Integer getMoedas() {
        return moedas;
    }

    public void setMoedas(Integer moedas) {
        this.moedas = moedas;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (personagemId != null ? personagemId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Personagem)) {
            return false;
        }
        Personagem other = (Personagem) object;
        if ((this.personagemId == null && other.personagemId != null) || (this.personagemId != null && !this.personagemId.equals(other.personagemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "objetos.Personagem[ personagemId=" + personagemId + " ]";
    }

    public String getEspecie() {
        return especie;
    }

    public void setEspecie(String especie) {
        this.especie = especie;
    }

    public String getClasse() {
        return classe;
    }

    public void setClasse(String classe) {
        this.classe = classe;
    }

    @XmlTransient
    public List<Mensagem> getMensagens() {
        return mensagens;
    }

    public void setMensagens(List<Mensagem> mensagens) {
        this.mensagens = mensagens;
    }

    public List<Arma> getArmas() {
        return armas;
    }

    public List<Equipamento> getEquipamentos() {
        return equipamentos;
    }

    public List<Habilidade> getHabilidades() {
        return habilidades;
    }

    public void setArmas(List<Arma> armas) {
        this.armas = armas;
    }

    public void setEquipamentos(List<Equipamento> equipamentos) {
        this.equipamentos = equipamentos;
    }

    public void setHabilidades(List<Habilidade> habilidadess) {
        this.habilidades = habilidadess;
    }

    public void setSaude(Integer saude) {
        this.saude = saude;
    }

    public Integer getSaude() {
        return saude;
    }

    public String getImagemSaude() {
        String pref = "imagens/barra_saude/", suf = ".png";

        for (int x = 100; x >= 10; x = x - 10) {
            if (this.getSaude() >= x) {
                return pref + String.valueOf(x) + suf;
            }
        }

        if (this.getSaude() >= 5) {
            return pref + "5" + suf;
        } else {
            return pref + "0" + suf;
        }
    }

    public int getSexo() {
        return sexo;
    }

    public void setSexo(int sexo) {
        this.sexo = sexo;
    }

    public String getComportamento_Igual() {
        return comportamento_Igual;
    }

    public String getComportamento_Inferior() {
        return comportamento_Inferior;
    }

    public String getComportamento_Superior() {
        return comportamento_Superior;
    }

    public void setComportamento_Igual(String comportamento_Igual) {
        this.comportamento_Igual = comportamento_Igual;
    }

    public void setComportamento_Inferior(String comportamento_Inferior) {
        this.comportamento_Inferior = comportamento_Inferior;
    }

    public void setComportamento_Superior(String comportamento_Superior) {
        this.comportamento_Superior = comportamento_Superior;
    }

    public String getStatusMensagemNova() {
        List<Mensagem> msg = this.getMensagens();
        String result = "";

        for (int x = 0; x < msg.size(); x++) {

            if (!msg.get(x).getLida()) {
                if (msg.get(x).getPersonagemRemetente().startsWith("System")) {
                    return msg.get(x).getPersonagemRemetente();
                } else {
                    result = "Message";
                }
            }
        }
        return result;
    }

    public Mensagem getMensagem(int id) {

        for (int x = 0; x < mensagens.size(); x++) {
            if (mensagens.get(x).getMensagemId() == id) {
                return mensagens.get(x);
            }
        }
        return null;
    }

    public Arma getArmaAtual() {
        if (this.getArma() < 0) {
            return null;
        } else {
            return this.getArmas().get(this.getArma());
        }
    }

    public Equipamento getEquipamentoAtual() {
        if (this.getEquipamento() < 0) {
            return null;
        } else {
            return this.getEquipamentos().get(this.getEquipamento());
        }
    }

    public boolean procurarEquipamento(int id) {
        for (int x = 0; x < equipamentos.size(); x++) {
            if (equipamentos.get(x).getEquipamentoId() == id) {
                return true;
            }
        }
        return false;
    }

    public Equipamento removerEquipamento(int id) {
        for (int x = 0; x < equipamentos.size(); x++) {
            if (equipamentos.get(x).getEquipamentoId() == id) {
                Equipamento e = equipamentos.get(x);
                equipamentos.remove(x);
                if (equipamento >= x) {
                    equipamento = equipamento - 1;
                }
                return e;
            }
        }
        return null;
    }

    public Arma removerArma(int id) {
        for (int x = 0; x < armas.size(); x++) {
            if (armas.get(x).getArmaId() == id) {
                Arma a = armas.get(x);
                armas.remove(x);
                if (arma >= x) {
                    arma = arma - 1;
                }
                return a;
            }
        }
        return null;
    }

    public Usuario getUsuario() {
        UsuarioDAO udao = new UsuarioDAO();
        return udao.consultarPorPersonagem(this);
    }

    public boolean procurarArma(int id) {
        for (int x = 0; x < armas.size(); x++) {
            if (armas.get(x).getArmaId() == id) {
                return true;
            }
        }
        return false;
    }

    public void setAtributos(Integer inteligencia, Integer forca, Integer resistencia, Integer agilidade, Integer destreza, Integer constituicao) {
        this.inteligencia = inteligencia;
        this.forca = forca;
        this.resistencia = resistencia;
        this.agilidade = agilidade;
        this.destreza = destreza;
        this.constituicao = constituicao;
    }

    public Missao getMissao() {
        return missao;
    }

    public void setMissao(Missao missao) {
        this.missao = missao;
    }

    public boolean temHabilidade(String habilidade) {
        for (int x = 0; x < habilidades.size(); x++) {
            if (habilidades.get(x).getNome().equals(habilidade)) {
                return true;
            }
        }
        return false;
    }

    public Calendar getDataUltimaCuraGratis() {
        return dataUltimaCuraGratis;
    }

    public Calendar getDataUltimaDerrota() {
        return dataUltimaDerrota;
    }

    public int getDerrotasNoDia() {
        return derrotasNoDia;
    }

    public void setDataUltimaCuraGratis(Calendar dataUltimaCuraGratis) {
        this.dataUltimaCuraGratis = dataUltimaCuraGratis;
    }

    public void setDataUltimaDerrota(Calendar dataUltimaDerrota) {
        this.dataUltimaDerrota = dataUltimaDerrota;
    }

    public void setDerrotasNoDia(int derrotasNoDia) {
        this.derrotasNoDia = derrotasNoDia;
    }

    public Habilidade getHabilidade(String habilidade) {
        for (int x = 0; x < habilidades.size(); x++) {
            if (habilidades.get(x).getNome().equals(habilidade)) {
                return habilidades.get(x);
            }
        }
        return null;
    }

    public int atualizarNivel() {
        int nivelVerificar = experiencia / 1000, quant;
        if (nivelVerificar != nivel) {
            quant = nivelVerificar - nivel;
            this.setNivel(nivelVerificar);
            return quant;
        }
        return 0;
    }

    public double getAtaqueNaBatalha(int nivelPersonagem2) {
        double ataque = 0;
        Arma armaAtual = this.getArmaAtual();
        if (armaAtual == null) {
            armaAtual = new Arma(true);
        }
        String comportamento;
        if (nivelPersonagem2 > nivel) {
            comportamento = comportamento_Superior;
        } else {
            if (nivelPersonagem2 == nivel) {
                comportamento = comportamento_Igual;
            } else {
                comportamento = comportamento_Inferior;
            }
        }


        if (classe.equals("classe_ork") || classe.equals("classe_ciclope")) {
            ataque = forca * 4.5;
            ataque = ataque + agilidade * 4;
            ataque = ataque + inteligencia * 2;
            ataque = ataque + destreza * (armaAtual.getAtaque() / 20);

            if (this.temHabilidade("skill.golpeduplo.name")) {
                ataque = ataque
                        + (ataque
                        * (this.getHabilidade("skill.golpeduplo.name").getAtaque() / 10));
            }

            ataque = ataque + (ataque * (nivel / 100));

        } else {

            if (classe.equals("classe_mecanico") || classe.equals("classe_cientista")) {

                ataque = inteligencia * 4 * (armaAtual.getAtaque() / 10 + 1);
                ataque = ataque + forca + agilidade;
                ataque = ataque + (destreza * (armaAtual.getAtaque() / 5));

                if (this.temHabilidade("skill.balaoca.name")) {
                    ataque = ataque
                            + (ataque
                            * (this.getHabilidade("skill.balaoca.name").getAtaque() / 20));
                }

                ataque = ataque + (ataque * (nivel / 100));
            } else {

                ataque = destreza * 2 * (armaAtual.getAtaque() / 5) + 30;
                ataque = ataque + forca + inteligencia + agilidade;

                if (this.temHabilidade("skill.balaoca.name")) {
                    ataque = ataque
                            + (ataque
                            * (this.getHabilidade("skill.balaoca.name").getAtaque() / 10));
                }

                ataque = ataque + (ataque * (nivel / 100));
            }
        }

        if (comportamento.equals("ofen")) {
            ataque = ataque * 1.5;
        } else {
            if (comportamento.equals("def")) {
                ataque = ataque * 0.75;
            }
        }


        return ataque / 2;
    }

    public double getDefesaNaBatalha(int nivelPersonagem2) {
        double defesa = 0;
        Equipamento equipamentoAtual = this.getEquipamentoAtual();
        if (equipamentoAtual == null) {
            equipamentoAtual = new Equipamento(true);
        }

        String comportamento;
        if (nivelPersonagem2 > nivel) {
            comportamento = comportamento_Superior;
        } else {
            if (nivelPersonagem2 == nivel) {
                comportamento = comportamento_Igual;
            } else {
                comportamento = comportamento_Inferior;
            }
        }

        defesa = agilidade * 3 * (equipamentoAtual.getDefesa() / 5);
        defesa = defesa + resistencia * 4 + inteligencia * 2 + forca;
        defesa = defesa + (defesa * (nivel / 100));

        if (comportamento.equals("ofen")) {
            defesa = defesa * 0.75;
        } else {
            if (comportamento.equals("def")) {
                defesa = defesa * 1.5;
            }
        }
        return defesa;
    }

    public static int calcularMudancaExperiencia(Personagem p1, Personagem p2, boolean primeiroGanhou) {
        int xp;

        if (primeiroGanhou) {

            if (p1.getNivel() > p2.getNivel()) {
                xp = 10;
            } else {
                if (p1.getNivel() == p2.getNivel()) {
                    xp = 50;
                } else {
                    xp = 50 + 20 * (p2.getNivel() - p1.getNivel());
                }
            }

        } else {

            if (p1.getNivel() > p2.getNivel()) {
                xp = 50 + 20 * (p2.getNivel() - p1.getNivel());
            } else {
                if (p1.getNivel() == p2.getNivel()) {
                    xp = 50;
                } else {
                    xp = 10;
                }
            }
        }

        return xp;
    }

    public static int calcularMudancaMoedas(Personagem p1, Personagem p2, boolean primeiroGanhou) {
        int moedas = 0, nivelPrimeiro, nivelSegundo;

        if (primeiroGanhou) {
            if (p2.getNivel() == 0) {
                nivelSegundo = 1;
            } else {
                nivelSegundo = p2.getNivel();
            }

            if (p1.getNivel() == 0) {
                nivelPrimeiro = 1;
            } else {
                nivelPrimeiro = p1.getNivel();
            }


            moedas = (p2.getMoedas() / (nivelPrimeiro / nivelSegundo)) / 10;
            if (moedas > p2.getMoedas()) {
                moedas = p2.getMoedas();
            } else {
                if (moedas < 0) {
                    moedas = 0;
                }
            }

        } else {
            if (p1.getNivel() == 0) {
                nivelSegundo = 1;
            } else {
                nivelSegundo = p1.getNivel();
            }

            if (p2.getNivel() == 0) {
                nivelPrimeiro = 1;
            } else {
                nivelPrimeiro = p2.getNivel();
            }

            moedas = (p1.getMoedas() / (nivelPrimeiro / nivelSegundo)) / 10;
            if (moedas > p1.getMoedas()) {
                moedas = p1.getMoedas();
            } else {
                if (moedas < 0) {
                    moedas = 0;
                }
            }

        }
        return moedas;
    }

    public String getLinkImagemDePersonagemAleatorio() {
        String link = "imagens/classes/";

        PersonagemPadraoDAO ppdao = new PersonagemPadraoDAO();
        List<PersonagemPadrao> pp = ppdao.findPersonagemPadraoEntities();
        ArrayList personagens = new ArrayList();
        for (int x = 0; x < pp.size(); x++) {
            if (pp.get(x).getEspecie().equals(this.getEspecie())) {
                personagens.add(pp.get(x).getClasse());
            }
        }
        link = link + this.getEspecie() + "/";
        link = link + String.valueOf((int) (Math.random() * 2)) + "/";
        link = link + personagens.get((int) (Math.random() * (personagens.size()))) + ".png";

        return link;
    }

    public String getCorHtmlDoPersonagem() {
        if (this.getEspecie().equals("especie_humana")) {
            return "#7B68EE";
        } else {
            if (this.getEspecie().equals("especie_ashen")) {
                return "#228B22";
            } else {
                return "#CD0000";
            }
        }
    }

    public static int calcularDuracao(int atributo) {
        return ((int) (atributo / 5)) + 1;
    }

    public static String getDuracaoString(int atributo, String idioma) {
        int d = Personagem.calcularDuracao(atributo);
        Locale local = new Locale(idioma);
        ResourceBundle i18n = ResourceBundle.getBundle("i18n.text", local);

        if (d == 1) {
            return d + " " + i18n.getString("floresta.text.hora");
        }

        return d + " " + i18n.getString("floresta.text.horas");
    }

    public String getDuracaoAgilidadeString() {
        return Personagem.getDuracaoString(this.getAgilidade(),
                this.getUsuario().getIdioma());
    }

    public String getDuracaoConstituicaoString() {
        return Personagem.getDuracaoString(this.getConstituicao(),
                this.getUsuario().getIdioma());
    }

    public String getDuracaoDestrezaString() {
        return Personagem.getDuracaoString(this.getDestreza(),
                this.getUsuario().getIdioma());
    }

    public String getDuracaoInteligenciaString() {
        return Personagem.getDuracaoString(this.getInteligencia(),
                this.getUsuario().getIdioma());
    }

    public String getDuracaoForcaString() {
        return Personagem.getDuracaoString(this.getForca(),
                this.getUsuario().getIdioma());
    }

    public String getDuracaoResistenciaString() {
        return Personagem.getDuracaoString(this.getResistencia(),
                this.getUsuario().getIdioma());
    }

    public int getDuracaoAtributo(String atributo) {

        if (atributo.equals("agilidade")) {
            return Personagem.calcularDuracao(this.getAgilidade());
        }

        if (atributo.equals("constituicao")) {
            return Personagem.calcularDuracao(this.getConstituicao());
        }

        if (atributo.equals("destreza")) {
            return Personagem.calcularDuracao(this.getDestreza());
        }

        if (atributo.equals("inteligencia")) {
            return Personagem.calcularDuracao(this.getInteligencia());
        }

        if (atributo.equals("forca")) {
            return Personagem.calcularDuracao(this.getForca());
        }

        if (atributo.equals("resistencia")) {
            return Personagem.calcularDuracao(this.getResistencia());
        }

        return 0;
    }

    public void aumentarAtributoPersonagem(String treino) {

        if (treino.equals("agilidade.treino.nome")) {
            agilidade = agilidade + 1;
        }

        if (treino.equals("constituicao.treino.nome")) {
            constituicao = constituicao + 1;
        }

        if (treino.equals("destreza.treino.nome")) {
            destreza = destreza + 1;
        }

        if (treino.equals("inteligencia.treino.nome")) {
            inteligencia = inteligencia + 1;
        }

        if (treino.equals("forca.treino.nome")) {
            forca = forca + 1;
        }

        if (treino.equals("resistencia.treino.nome")) {
            resistencia = resistencia + 1;
        }
    }

    public String getTempoRestanteMissaoString() {
        Locale locale = new Locale(this.getUsuario().getIdioma());
        ResourceBundle i18n = ResourceBundle.getBundle("i18n.text", locale);

        if (this.getMissao() != null) {

            long milisecondDataAtual = System.currentTimeMillis();
            long milisecondDataTermino = this.getMissao().getDataTermino().getTimeInMillis();
            long milisecondResult = milisecondDataTermino - milisecondDataAtual;

            return milisecondResult / 1000 / 60 + " " + i18n.getString("minutos");

        }

        return i18n.getString("missionpage.text.nomission");
    }

    public double getVidaNaBatalha() {
        // Vida do Personagem = (Constituição * 10) * (Saude/100)
        double saude = this.getSaude();
        double vida = this.getConstituicao();
        return (vida * 10) * (saude / 100);
    }

    public double getHitDoPersonagem(int nivelAdversario, double defesaAdversario) {
        final int PORCENTAGEM = 30;

        //calcula o ataque
        double ataqueDele = this.getAtaqueNaBatalha(nivelAdversario);

        //O ataque inicial pode aumentar de 0 a PORCENTAGEM %
        double acrescimoDoAtaque = ataqueDele
                * (Math.random() * PORCENTAGEM + 1) / 100;

        // O Hit do personagem é calculado pela fórmula:
        return (ataqueDele + acrescimoDoAtaque) - defesaAdversario;
    }

    public void setVidaFinal(double vida) {
        //calcula vida total do personagem com 100%.
        double vidaNatural = this.getConstituicao() * 10;
        double vidaFinal = (100 / vidaNatural) * (vida);
        this.setSaude((int) vidaFinal);
    }
}
