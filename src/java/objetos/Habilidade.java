/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package objetos;

import java.io.Serializable;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Guilherme
 */
@Entity
@Table(name = "habilidade", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Habilidade.findAll", query = "SELECT h FROM Habilidade h"),
    @NamedQuery(name = "Habilidade.findByHabilidadeId", query = "SELECT h FROM Habilidade h WHERE h.habilidadeId = :habilidadeId"),
    @NamedQuery(name = "Habilidade.findByNome", query = "SELECT h FROM Habilidade h WHERE h.nome = :nome"),
    @NamedQuery(name = "Habilidade.findByDescricao", query = "SELECT h FROM Habilidade h WHERE h.descricao = :descricao"),
    @NamedQuery(name = "Habilidade.findByEfeito", query = "SELECT h FROM Habilidade h WHERE h.efeito = :efeito"),
    @NamedQuery(name = "Habilidade.findByRequisitos", query = "SELECT h FROM Habilidade h WHERE h.requisitos = :requisitos"),
    @NamedQuery(name = "Habilidade.findByClasse1", query = "SELECT h FROM Habilidade h WHERE h.classe1 = :classe1"),
    @NamedQuery(name = "Habilidade.findByClasse2", query = "SELECT h FROM Habilidade h WHERE h.classe2 = :classe2"),
    @NamedQuery(name = "Habilidade.findByAtaque", query = "SELECT h FROM Habilidade h WHERE h.ataque = :ataque"),
    @NamedQuery(name = "Habilidade.findByDefesa", query = "SELECT h FROM Habilidade h WHERE h.defesa = :defesa"),
    @NamedQuery(name = "Habilidade.findByNivel", query = "SELECT h FROM Habilidade h WHERE h.nivel = :nivel"),
    @NamedQuery(name = "Habilidade.findByInteligencia", query = "SELECT h FROM Habilidade h WHERE h.inteligencia = :inteligencia"),
    @NamedQuery(name = "Habilidade.findByForca", query = "SELECT h FROM Habilidade h WHERE h.forca = :forca"),
    @NamedQuery(name = "Habilidade.findByResistencia", query = "SELECT h FROM Habilidade h WHERE h.resistencia = :resistencia"),
    @NamedQuery(name = "Habilidade.findByVelocidade", query = "SELECT h FROM Habilidade h WHERE h.velocidade = :velocidade"),
    @NamedQuery(name = "Habilidade.findByAgilidade", query = "SELECT h FROM Habilidade h WHERE h.agilidade = :agilidade"),
    @NamedQuery(name = "Habilidade.findByDestreza", query = "SELECT h FROM Habilidade h WHERE h.destreza = :destreza"),
    @NamedQuery(name = "Habilidade.findByConstituicao", query = "SELECT h FROM Habilidade h WHERE h.constituicao = :constituicao")})
public class Habilidade implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "habilidade_id")
    private Integer habilidadeId;
    @Size(max = 50)
    @Column(name = "nome")
    private String nome;
    @Size(max = 50)
    @Column(name = "descricao")
    private String descricao;
    @Size(max = 50)
    @Column(name = "efeito")
    private String efeito;
    @Size(max = 50)
    @Column(name = "requisitos")
    private String requisitos;
    @Size(max = 50)
    @Column(name = "classe1")
    private String classe1;
    @Size(max = 50)
    @Column(name = "classe2")
    private String classe2;
    @Column(name = "ataque")
    private Integer ataque;
    @Column(name = "defesa")
    private Integer defesa;
    @Column(name = "nivel")
    private Integer nivel;
    @Column(name = "inteligencia")
    private Integer inteligencia;
    @Column(name = "forca")
    private Integer forca;
    @Column(name = "resistencia")
    private Integer resistencia;
    @Column(name = "velocidade")
    private Integer velocidade;
    @Column(name = "agilidade")
    private Integer agilidade;
    @Column(name = "destreza")
    private Integer destreza;
    @Column(name = "constituicao")
    private Integer constituicao;
    @Column(name = "premium")
    private boolean premium;

    public Habilidade() {
    }

    public Habilidade(Integer habilidadeId) {
        this.habilidadeId = habilidadeId;
    }

    public Integer getHabilidadeId() {
        return habilidadeId;
    }

    public void setHabilidadeId(Integer habilidadeId) {
        this.habilidadeId = habilidadeId;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getDescricao() {
        return descricao;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public String getEfeito() {
        return efeito;
    }

    public void setEfeito(String efeito) {
        this.efeito = efeito;
    }

    public String getRequisitos() {
        return requisitos;
    }

    public void setRequisitos(String requisitos) {
        this.requisitos = requisitos;
    }

    public String getClasse1() {
        return classe1;
    }

    public void setClasse1(String classe1) {
        this.classe1 = classe1;
    }

    public String getClasse2() {
        return classe2;
    }

    public void setClasse2(String classe2) {
        this.classe2 = classe2;
    }

    public Integer getAtaque() {
        return ataque;
    }

    public void setAtaque(Integer ataque) {
        this.ataque = ataque;
    }

    public Integer getDefesa() {
        return defesa;
    }

    public void setDefesa(Integer defesa) {
        this.defesa = defesa;
    }

    public Integer getNivel() {
        return nivel;
    }

    public void setNivel(Integer nivel) {
        this.nivel = nivel;
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

    public Integer getVelocidade() {
        return velocidade;
    }

    public void setVelocidade(Integer velocidade) {
        this.velocidade = velocidade;
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

    public Integer getValor() {
        if (this.getAtaque() > 0) {
            return this.getAtaque();
        } else {
            if (this.getDefesa() > 0) {
                return this.getDefesa();
            }
        }
        return 0;
    }

    public void setSemRequisitos() {
        this.setAgilidade(0);
        this.setConstituicao(0);
        this.setDestreza(0);
        this.setForca(0);
        this.setInteligencia(0);
        this.setNivel(0);
        this.setRequisitos("norequirement");
        this.setResistencia(0);
        this.setVelocidade(0);
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (habilidadeId != null ? habilidadeId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Habilidade)) {
            return false;
        }
        Habilidade other = (Habilidade) object;
        if ((this.habilidadeId == null && other.habilidadeId != null) || (this.habilidadeId != null && !this.habilidadeId.equals(other.habilidadeId))) {
            return false;
        }
        return true;
    }

    public void setPremium(boolean premium) {
        this.premium = premium;
    }

    public boolean getPremium() {
        return premium;
    }

    @Override
    public String toString() {
        return "objetos.Habilidade[ habilidadeId=" + habilidadeId + " ]";
    }
}
