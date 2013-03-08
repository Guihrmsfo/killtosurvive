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
@Table(name = "arma", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Arma.findAll", query = "SELECT a FROM Arma a"),
    @NamedQuery(name = "Arma.findByArmaId", query = "SELECT a FROM Arma a WHERE a.armaId = :armaId"),
    @NamedQuery(name = "Arma.findByNome", query = "SELECT a FROM Arma a WHERE a.nome = :nome"),
    @NamedQuery(name = "Arma.findByDescricao", query = "SELECT a FROM Arma a WHERE a.descricao = :descricao"),
    @NamedQuery(name = "Arma.findByAtaque", query = "SELECT a FROM Arma a WHERE a.ataque = :ataque")})
public class Arma implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "arma_id")
    private Integer armaId;
    @Size(max = 50)
    @Column(name = "nome")
    private String nome;
    @Size(max = 50)
    @Column(name = "descricao")
    private String descricao;
    @Column(name = "ataque")
    private Integer ataque;
    @Size(max = 200)
    @Column(name = "imagem")
    private String imagem;
    @Column(name = "preco")
    private int preco;
    @Column(name = "premium")
    private boolean premium;

    public Arma() {
    }

    public Arma(boolean zerado) {
        if (zerado) {
            this.setAtaque(0);
        }
    }

    public Arma(Integer armaId) {
        this.armaId = armaId;
    }

    public Integer getArmaId() {
        return armaId;
    }

    public void setArmaId(Integer armaId) {
        this.armaId = armaId;
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

    public Integer getAtaque() {
        return ataque;
    }

    public void setAtaque(Integer ataque) {
        this.ataque = ataque;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (armaId != null ? armaId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Arma)) {
            return false;
        }
        Arma other = (Arma) object;
        if ((this.armaId == null && other.armaId != null) || (this.armaId != null && !this.armaId.equals(other.armaId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "objetos.Arma[ armaId=" + armaId + " ]";
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

    public boolean getPremium() {
        return premium;
    }

    public void setPremium(boolean premium) {
        this.premium = premium;
    }
}
