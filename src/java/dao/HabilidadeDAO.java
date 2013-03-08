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
import objetos.Habilidade;

/**
 *
 * @author Guilherme
 */
public class HabilidadeDAO implements Serializable {

    public HabilidadeDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public HabilidadeDAO() {
        this.emf = Persistence.createEntityManagerFactory("killtosurvive");
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Habilidade save(Habilidade habilidade) throws Exception {
        EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
            
        if(habilidade.getHabilidadeId() == null) {
        em.persist(habilidade);
      } else {
        habilidade = em.merge(habilidade);
      }
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    return habilidade;   
    }


     public void delete(Integer id) throws Exception {
       EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
      // Consulta a pessoa na base de dados através do seu ID.
      Habilidade habilidade = em.find(Habilidade.class, id);
      System.out.println("Excluindo os dados de: " + habilidade.getNome());
      // Remove a pessoa da base de dados.
      em.remove(habilidade);
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    }

    public List<Habilidade> findHabilidadeEntities() {
        return findHabilidadeEntities(true, -1, -1);
    }

    public List<Habilidade> findHabilidadeEntities(int maxResults, int firstResult) {
        return findHabilidadeEntities(false, maxResults, firstResult);
    }

    private List<Habilidade> findHabilidadeEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Habilidade.class));
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

    public Habilidade findHabilidade(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Habilidade.class, id);
        } finally {
            em.close();
        }
    }

    public int getHabilidadeCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Habilidade> rt = cq.from(Habilidade.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public Habilidade consultarPorNome(String nome){
        EntityManager em = getEntityManager();
        try{
        return (Habilidade) em.createNamedQuery("Habilidade.findByNome").setParameter("nome", nome).getSingleResult();
        }catch(NoResultException ex){
            return null;
        }
    }
    
}
