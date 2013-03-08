/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package objetos;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Random;
import javax.persistence.*;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author Guilherme
 */
@Entity
@Table(name = "usuario", catalog = "killtosurvive", schema = "")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Usuario.findAll", query = "SELECT u FROM Usuario u"),
    @NamedQuery(name = "Usuario.findById", query = "SELECT u FROM Usuario u WHERE u.id = :id"),
    @NamedQuery(name = "Usuario.findByEmail", query = "SELECT u FROM Usuario u WHERE u.email = :email"),
    @NamedQuery(name = "Usuario.findByIdioma", query = "SELECT u FROM Usuario u WHERE u.idioma = :idioma"),
    @NamedQuery(name = "Usuario.findBySenha", query = "SELECT u FROM Usuario u WHERE u.senha = :senha"),
    @NamedQuery(name = "Usuario.findByUsuario", query = "SELECT u FROM Usuario u WHERE u.usuario = :usuario"),
    @NamedQuery(name = "Usuario.findByPersonagem", query = "SELECT u FROM Usuario u WHERE u.personagem = :personagem")})
public class Usuario implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Column(name = "ID")
    @GeneratedValue(strategy = GenerationType.AUTO)
    private Integer id;
    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="E-mail inválido")//if the field contains email address consider using this annotation to enforce field validation
    @Size(max = 255)
    @Column(name = "EMAIL", length = 255)
    private String email;
    @Size(max = 255)
    @Column(name = "SENHA", length = 255)
    private String senha;
    @Size(max = 255)
    @Column(name = "USUARIO", length = 255)
    private String usuario;
    @OneToOne(cascade = CascadeType.ALL, optional = true, fetch = FetchType.LAZY, orphanRemoval = true)
    @JoinColumn(name="personagem", nullable=true)
    private Personagem personagem;
    @Column(name = "IDIOMA")
    private String idioma;
    @Column(name = "VALIDO")
    private boolean valido;
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "dataPremium", nullable=true)
    private Calendar dataPremium;
    @Column(name = "premium")
    private boolean premium;

    public Usuario() {
        this.email = "";
        this.idioma = "";
        this.senha = "";
        this.usuario = "";
        this.personagem = null;
    }

    public Usuario(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdioma() {
        return idioma;
    }

    public void setIdioma(String idioma) {
        this.idioma = idioma;
    }

    public String getSenha() {
        return senha;
    }

    public void setSenha(String senha) {
        this.senha = senha;
    }

    public String getUsuario() {
        return usuario;
    }

    public void setUsuario(String usuario) {
        this.usuario = usuario;
    }

    public Personagem getPersonagem() {
        return personagem;
    }

    public void setPersonagem(Personagem personagem) {
        this.personagem = personagem;
    }

    public Calendar getDataPremium() {
        return dataPremium;
    }

    public void setDataPremium(Calendar dataPremium) {
        this.dataPremium = dataPremium;
    }

    public boolean getPremium() {
        return premium;
    }

    public void setPremium(boolean premium) {
        this.premium = premium;
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
        if (!(object instanceof Usuario)) {
            return false;
        }
        Usuario other = (Usuario) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "objetos.Usuario[ id=" + id + " ]";
    }

    public boolean isValido() {
        return valido;
    }

    public void setValido(boolean valido) {
        this.valido = valido;
    }

    public void validarUsuario() {
        this.setValido(true);
    }

    public void invalidarUsuario() {
        this.setValido(false);
    }
    
}
