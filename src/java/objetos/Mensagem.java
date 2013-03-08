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
@Table(name = "mensagem", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Mensagem.findAll", query = "SELECT m FROM Mensagem m"),
    @NamedQuery(name = "Mensagem.findByMensagemId", query = "SELECT m FROM Mensagem m WHERE m.mensagemId = :mensagemId"),
    @NamedQuery(name = "Mensagem.findByTitulo", query = "SELECT m FROM Mensagem m WHERE m.titulo = :titulo"),
    @NamedQuery(name = "Mensagem.findByPersonagemRemetente", query = "SELECT m FROM Mensagem m WHERE m.personagemRemetente = :personagemRemetente")})
public class Mensagem implements Serializable {
    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    @Basic(optional = false)
    @NotNull
    @Column(name = "mensagem_id")
    private Integer mensagemId;
    @Size(max = 50)
    @Column(name = "titulo")
    private String titulo;
    @Lob
    @Size(max = 2000)
    @Column(name = "texto")
    private String texto;
    @Column(name = "lida")
    private boolean lida;
    @Size(max = 50)
    @Column(name = "personagem_remetente")
    private String personagemRemetente;
    @ManyToOne(optional = false)
    @JoinColumn(name="personagem_id")
    private Personagem personagemDestinatario;

    public Mensagem() {
    }

    public Mensagem(Integer mensagemId) {
        this.mensagemId = mensagemId;
    }

    public Integer getMensagemId() {
        return mensagemId;
    }

    public void setMensagemId(Integer mensagemId) {
        this.mensagemId = mensagemId;
    }

    public String getTitulo() {
        return titulo;
    }

    public void setTitulo(String titulo) {
        this.titulo = titulo;
    }

    public String getTexto() {
        return texto;
    }

    public void setTexto(String texto) {
        this.texto = texto;
    }

    public String getPersonagemRemetente() {
        return personagemRemetente;
    }

    public void setPersonagemRemetente(String personagemRemetente) {
        this.personagemRemetente = personagemRemetente;
    }

    public Personagem getIPersonagemDestinatario() {
        return personagemDestinatario;
    }

    public void setPersonagemDestinatario(Personagem idPersonagemDestinatario) {
        this.personagemDestinatario = idPersonagemDestinatario;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (mensagemId != null ? mensagemId.hashCode() : 0);
        return hash;
    }

    public boolean getLida() {
        return lida;
    }

    public void setLida(boolean lida) {
        this.lida = lida;
    }
    
    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Mensagem)) {
            return false;
        }
        Mensagem other = (Mensagem) object;
        if ((this.mensagemId == null && other.mensagemId != null) || (this.mensagemId != null && !this.mensagemId.equals(other.mensagemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "objetos.Mensagem[ mensagemId=" + mensagemId + " ]";
    }
    
}
