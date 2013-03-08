
/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package objetos;

import java.io.Serializable;
import java.util.Calendar;
import javax.persistence.*;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Thaís
 */
@Entity
@Table(name = "missao", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Arma.findAll", query = "SELECT a FROM Arma a")})
public class Missao implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "missao_id")
    private Integer missaoId;
    @Size(max = 200)
    @Column(name = "nome")
    private String nome;
    @Column(name = "dificuldade")
    private int dificuldade;
    @Column(name = "ganhoMoedas")
    private int ganhoMoedas;
    @Column(name = "ganhoExperiencia")
    private int ganhoExperiencia;
    @Size(max = 500)
    @Column(name = "descricao")
    private String descricao;
    @Size(max = 100)
    @Column(name = "tipo")
    private String tipo;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "dataTermino")
    private Calendar dataTermino;
    public static final String TREINAMENTO = "Treinamento";
    public static final String CACA = "Caça";
    public static final String MISSAO = "Missão";

    public Missao() {
    }

    public Calendar getDataTermino() {
        return dataTermino;
    }

    public void setDataTermino(Calendar dataTermino) {
        this.dataTermino = dataTermino;
    }

    public String getDescricao() {
        return descricao;
    }

    public int getDificuldade() {
        return dificuldade;
    }

    public int getGanhoExperiencia() {
        return ganhoExperiencia;
    }

    public int getGanhoMoedas() {
        return ganhoMoedas;
    }

    public Integer getMissaoId() {
        return missaoId;
    }

    public String getNome() {
        return nome;
    }

    public void setDescricao(String descricao) {
        this.descricao = descricao;
    }

    public void setDificuldade(int dificuldade) {
        this.dificuldade = dificuldade;
    }

    public void setGanhoExperiencia(int ganhoExperiencia) {
        this.ganhoExperiencia = ganhoExperiencia;
    }

    public void setGanhoMoedas(int ganhoMoedas) {
        this.ganhoMoedas = ganhoMoedas;
    }

    public void setMissaoId(Integer missaoId) {
        this.missaoId = missaoId;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public boolean missaoDeuCerto() {
        int porcentagem = (int) (Math.random() * 101);
        int d = this.getDificuldade();

        int porcentagemDarErrado = d * 5 + (d * 5) / 2;

        if (porcentagem <= porcentagemDarErrado) {
            return false;
        } else {
            return true;
        }
    }
}
