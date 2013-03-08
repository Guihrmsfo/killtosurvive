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
@Table(name = "equipamento", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Equipamento.findAll", query = "SELECT e FROM Equipamento e"),
    @NamedQuery(name = "Equipamento.findByEquipamentoId", query = "SELECT e FROM Equipamento e WHERE e.equipamentoId = :equipamentoId"),
    @NamedQuery(name = "Equipamento.findByNome", query = "SELECT e FROM Equipamento e WHERE e.nome = :nome"),
    @NamedQuery(name = "Equipamento.findByDescricao", query = "SELECT e FROM Equipamento e WHERE e.descricao = :descricao"),
    @NamedQuery(name = "Equipamento.findByDefesa", query = "SELECT e FROM Equipamento e WHERE e.defesa = :defesa")})
public class Equipamento implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "equipamento_id")
    private Integer equipamentoId;
    @Size(max = 50)
    @Column(name = "nome")
    private String nome;
    @Size(max = 50)
    @Column(name = "descricao")
    private String descricao;
    @Column(name = "defesa")
    private Integer defesa;
    @Size(max = 200)
    @Column(name = "imagem")
    private String imagem;
    @Column(name = "preco")
    private int preco;
    @Column(name = "premium")
    private boolean premium;

    public Equipamento() {
    }

    public Equipamento(boolean zerado) {
        if (zerado) {
            this.setDefesa(0);
        }
    }

    public Integer getDefesa() {
        return defesa;
    }

    public void setDefesa(Integer defesa) {
        this.defesa = defesa;
    }

    public String getImagem() {
        return imagem;
    }

    public void setImagem(String imagem) {
        this.imagem = imagem;
    }

    public int getPreco() {
        return preco;
    }

    public void setPreco(int preco) {
        this.preco = preco;
    }

    public Equipamento(Integer equipamentoId) {
        this.equipamentoId = equipamentoId;
    }

    public Integer getEquipamentoId() {
        return equipamentoId;
    }

    public void setEquipamentoId(Integer equipamentoId) {
        this.equipamentoId = equipamentoId;
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

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (equipamentoId != null ? equipamentoId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Equipamento)) {
            return false;
        }
        Equipamento other = (Equipamento) object;
        if ((this.equipamentoId == null && other.equipamentoId != null) || (this.equipamentoId != null && !this.equipamentoId.equals(other.equipamentoId))) {
            return false;
        }
        return true;
    }

    public boolean getPremium() {
        return premium;
    }

    public void setPremium(boolean premium) {
        this.premium = premium;
    }

    @Override
    public String toString() {
        return "objetos.Equipamento[ equipamentoId=" + equipamentoId + " ]";
    }
}
