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
import objetos.PersonagemPadrao;

/**
 *
 * @author Guilherme
 */
public class PersonagemPadraoDAO implements Serializable {

    public PersonagemPadraoDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }   
    public PersonagemPadraoDAO() {
         this.emf = Persistence.createEntityManagerFactory("killtosurvive");
    }   
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public PersonagemPadrao save(PersonagemPadrao pp) throws Exception {
        EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
            
        if(pp.getId() == null) {
        em.persist(pp);
      } else {
        pp = em.merge(pp);
      }
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    return pp;    
     
    }

    public void delete(Integer id) throws Exception {
       EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
      // Consulta a pessoa na base de dados através do seu ID.
      PersonagemPadrao pp = em.find(PersonagemPadrao.class, id);
      System.out.println("Excluindo os dados de: " + pp.getClasse()+" - "+pp.getEspecie());
      // Remove a pessoa da base de dados.
      em.remove(pp);
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    }

    public List<PersonagemPadrao> findPersonagemPadraoEntities() {
        return findPersonagemPadraoEntities(true, -1, -1);
    }

    public List<PersonagemPadrao> findPersonagemPadraoEntities(int maxResults, int firstResult) {
        return findPersonagemPadraoEntities(false, maxResults, firstResult);
    }

    private List<PersonagemPadrao> findPersonagemPadraoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(PersonagemPadrao.class));
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

    public PersonagemPadrao findPersonagemPadrao(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(PersonagemPadrao.class, id);
        } finally {
            em.close();
        }
    }

    public int getPersonagemPadraoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<PersonagemPadrao> rt = cq.from(PersonagemPadrao.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
