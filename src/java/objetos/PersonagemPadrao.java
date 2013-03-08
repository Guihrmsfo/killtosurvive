/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package objetos;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Guilherme
 */
@Entity
@Table(name = "personagem_padrao", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "PersonagemPadrao.findAll", query = "SELECT p FROM PersonagemPadrao p"),
    @NamedQuery(name = "PersonagemPadrao.findById", query = "SELECT p FROM PersonagemPadrao p WHERE p.id = :id"),
    @NamedQuery(name = "PersonagemPadrao.findByEspecie", query = "SELECT p FROM PersonagemPadrao p WHERE p.especie = :especie"),
    @NamedQuery(name = "PersonagemPadrao.findByClasse", query = "SELECT p FROM PersonagemPadrao p WHERE p.classe = :classe"),
    @NamedQuery(name = "PersonagemPadrao.findByInteligencia", query = "SELECT p FROM PersonagemPadrao p WHERE p.inteligencia = :inteligencia"),
    @NamedQuery(name = "PersonagemPadrao.findByForca", query = "SELECT p FROM PersonagemPadrao p WHERE p.forca = :forca"),
    @NamedQuery(name = "PersonagemPadrao.findByResistencia", query = "SELECT p FROM PersonagemPadrao p WHERE p.resistencia = :resistencia"),
    @NamedQuery(name = "PersonagemPadrao.findByAgilidade", query = "SELECT p FROM PersonagemPadrao p WHERE p.agilidade = :agilidade"),
    @NamedQuery(name = "PersonagemPadrao.findByDestreza", query = "SELECT p FROM PersonagemPadrao p WHERE p.destreza = :destreza"),
    @NamedQuery(name = "PersonagemPadrao.findByConstituicao", query = "SELECT p FROM PersonagemPadrao p WHERE p.constituicao = :constituicao"),
    @NamedQuery(name = "PersonagemPadrao.findByArma", query = "SELECT p FROM PersonagemPadrao p WHERE p.arma = :arma"),
    @NamedQuery(name = "PersonagemPadrao.findByEquipamento", query = "SELECT p FROM PersonagemPadrao p WHERE p.equipamento = :equipamento")})
public class PersonagemPadrao implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Column(name = "especie")
    private String especie;
    @Basic(optional = false)
    @NotNull
    @Column(name = "classe")
    private String classe;
    @Basic(optional = false)
    @NotNull
    @Column(name = "inteligencia")
    private Integer inteligencia;
    @Basic(optional = false)
    @NotNull
    @Column(name = "forca")
    private Integer forca;
    @Basic(optional = false)
    @NotNull
    @Column(name = "resistencia")
    private Integer resistencia;
    @Basic(optional = false)
    @NotNull
    @Column(name = "agilidade")
    private Integer agilidade;
    @Basic(optional = false)
    @NotNull
    @Column(name = "destreza")
    private Integer destreza;
    @Basic(optional = false)
    @NotNull
    @Column(name = "constituicao")
    private Integer constituicao;
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "arma", nullable = true)
    private Arma arma;
    @ManyToOne(cascade = CascadeType.MERGE)
    @JoinColumn(name = "equipamento", nullable = true)
    private Equipamento equipamento;

    public PersonagemPadrao() {
    }

    public PersonagemPadrao(Integer id) {
        this.id = id;
    }

    public PersonagemPadrao(Integer id, String especie, String classe, Integer inteligencia, Integer forca, Integer resistencia, Integer agilidade, Integer destreza, Integer constituicao, Arma arma, Equipamento equipamento) {
        this.id = id;
        this.especie = especie;
        this.classe = classe;
        this.inteligencia = inteligencia;
        this.forca = forca;
        this.resistencia = resistencia;
        this.agilidade = agilidade;
        this.destreza = destreza;
        this.constituicao = constituicao;
        this.arma = arma;
        this.equipamento = equipamento;
    }

    public PersonagemPadrao(String especie, String classe) {
        this.especie = especie;
        this.classe = classe;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
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

    public Arma getArma() {
        return arma;
    }

    public void setArma(Arma arma) {
        this.arma = arma;
    }

    public Equipamento getEquipamento() {
        return equipamento;
    }

    public void setEquipamento(Equipamento equipamento) {
        this.equipamento = equipamento;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof PersonagemPadrao)) {
            return false;
        }
        PersonagemPadrao other = (PersonagemPadrao) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "objetos.PersonagemPadrao[ id=" + id + " ]";
    }

    public void setAtributos(Integer inteligencia, Integer forca, Integer resistencia, Integer agilidade, Integer destreza, Integer constituicao) {
        this.inteligencia = inteligencia;
        this.forca = forca;
        this.resistencia = resistencia;
        this.agilidade = agilidade;
        this.destreza = destreza;
        this.constituicao = constituicao;
    }

    public static Personagem createCharacter(PersonagemPadrao pp, String nome, int sexo, String imagem) {
        Personagem p = null;
        if (pp != null) {
            p = new Personagem();
            p.setSexo(sexo);
            p.setNivel(0);
            p.setDataUltimaCuraGratis(null);
            p.setDataUltimaDerrota(null);
            p.setDerrotasNoDia(0);
            p.setMissao(null);
            p.setComportamento_Igual("bal");
            p.setComportamento_Inferior("bal");
            p.setComportamento_Superior("bal");
            p.setSaude(100);
            p.setAtributos(pp.getInteligencia(), pp.getForca(), pp.getResistencia(),
                    pp.getAgilidade(), pp.getDestreza(), pp.getConstituicao());
            p.setEspecie(pp.getEspecie());
            p.setClasse(pp.getClasse());
            p.setMoedas(200);
            p.setImagem(imagem);
            List<Arma> armas = new ArrayList<Arma>();
            p.setArmas(armas);
            List<Equipamento> equipamentos = new ArrayList<Equipamento>();
            p.setEquipamentos(equipamentos);
            p.setHabilidades(new ArrayList<Habilidade>());
            if (pp.getArma() != null) {
                armas.add(pp.getArma());
                p.setArma(0);
            } else {
                p.setArma(-1);
            }

            if (pp.getEquipamento() != null) {
                equipamentos.add(pp.getEquipamento());
                p.setEquipamento(0);
            } else {
                p.setArma(-1);
            }

            p.setMensagens(new ArrayList<Mensagem>());
            p.setExperiencia(0);
            p.setNome(nome);
        }
        return p;
    }
}
