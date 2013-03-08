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
import objetos.Arma;

/**
 *
 * @author Guilherme
 */
public class ArmaDAO implements Serializable {

    public ArmaDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public ArmaDAO() {
        this.emf = Persistence.createEntityManagerFactory("killtosurvive");
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Arma save(Arma arma) throws Exception {
        EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
            
        if(arma.getArmaId() == null) {
        em.persist(arma);
      } else {
        arma = em.merge(arma);
      }
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    return arma;   
    }


     public void delete(Integer id) throws Exception {
       EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
      // Consulta a pessoa na base de dados através do seu ID.
      Arma arma = em.find(Arma.class, id);
      System.out.println("Excluindo os dados de: " + arma.getNome());
      // Remove a pessoa da base de dados.
      em.remove(arma);
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    }

    public List<Arma> findArmaEntities() {
        return findArmaEntities(true, -1, -1);
    }

    public List<Arma> findArmaEntities(int maxResults, int firstResult) {
        return findArmaEntities(false, maxResults, firstResult);
    }

    private List<Arma> findArmaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Arma.class));
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

    public Arma findArma(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Arma.class, id);
        } finally {
            em.close();
        }
    }

    public int getArmaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Arma> rt = cq.from(Arma.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public Arma consultarPorNome(String nome){
        EntityManager em = getEntityManager();
        try{
        return (Arma) em.createNamedQuery("Arma.findByNome").setParameter("nome", nome).getSingleResult();
        }catch(NoResultException ex){
            return null;
        }
    }
    
}

