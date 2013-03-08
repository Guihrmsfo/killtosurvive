/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.io.Serializable;
import java.util.List;
import javax.persistence.*;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import objetos.Personagem;
import objetos.Usuario;

/**
 *
 * @author Guilherme
 */
public class UsuarioDAO implements Serializable {

    public UsuarioDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }

    public UsuarioDAO() {
        this.emf = Persistence.createEntityManagerFactory("killtosurvive");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Usuario save(Usuario usuario) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();

            if (usuario.getId() == null) {
                em.persist(usuario);
            } else {
                usuario = em.merge(usuario);
            }
            // Finaliza a transação.
            em.getTransaction().commit();
        } finally {
            em.close();
        }
        return usuario;

    }

    public void delete(Integer id) throws Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            // Consulta a pessoa na base de dados através do seu ID.
            Usuario usuario = em.find(Usuario.class, id);
            System.out.println("Excluindo os dados de: " + usuario.getUsuario());
            // Remove a pessoa da base de dados.
            em.remove(usuario);
            // Finaliza a transação.
            em.getTransaction().commit();
        } finally {
            em.close();
        }
    }

    public List<Usuario> findUsuarioEntities() {
        return findUsuarioEntities(true, -1, -1);
    }

    public List<Usuario> findUsuarioEntities(int maxResults, int firstResult) {
        return findUsuarioEntities(false, maxResults, firstResult);
    }

    private List<Usuario> findUsuarioEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Usuario.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Usuario findUsuario(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Usuario.class, id);
        } finally {
            em.close();
        }
    }

    public int getUsuarioCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Usuario> rt = cq.from(Usuario.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }

    public Usuario consultarPorNome(String nome) {
        EntityManager em = getEntityManager();
        try {
            return (Usuario) em.createNamedQuery("Usuario.findByUsuario").setParameter("usuario", nome).getSingleResult();
        } catch (NoResultException ex) {
            return null;
        }
    }

    public Usuario consultarPorEmail(String email) {
        EntityManager em = getEntityManager();
        try {
            return (Usuario) em.createNamedQuery("Usuario.findByEmail").setParameter("email", email).getSingleResult();
        } catch (NoResultException ex) {
            return null;
        }
    }

    public Usuario consultarPorPersonagem(Personagem personagem) {
        EntityManager em = getEntityManager();
        try {
            return (Usuario) em.createNamedQuery("Usuario.findByPersonagem").setParameter("personagem", personagem).getSingleResult();
        } catch (NoResultException ex) {
            return null;
        }
    }
}
