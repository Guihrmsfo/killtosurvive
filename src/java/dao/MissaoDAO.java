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
import objetos.Missao;

/**
 *
 * @author Thaís
 */
public class MissaoDAO implements Serializable {

    public MissaoDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public MissaoDAO() {
        this.emf = Persistence.createEntityManagerFactory("killtosurvive");
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Missao save(Missao missao) throws Exception {
        EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
            
        if(missao.getMissaoId() == null) {
        em.persist(missao);
      } else {
        missao = em.merge(missao);
      }
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    return missao;   
    }


     public void delete(Integer id) throws Exception {
       EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
      // Consulta a pessoa na base de dados através do seu ID.
      Missao missao = em.find(Missao.class, id);
      System.out.println("Excluindo os dados de: " + missao.getNome());
      // Remove a pessoa da base de dados.
      em.remove(missao);
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    }

    public List<Missao> findMissaoEntities() {
        return findMissaoEntities(true, -1, -1);
    }

    public List<Missao> findMissaoEntities(int maxResults, int firstResult) {
        return findMissaoEntities(false, maxResults, firstResult);
    }

    private List<Missao> findMissaoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Missao.class));
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

    public Missao findMissao(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Missao.class, id);
        } finally {
            em.close();
        }
    }

    public int getMissaoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Missao> rt = cq.from(Missao.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public Missao consultarPorNome(String nome){
        EntityManager em = getEntityManager();
        try{
        return (Missao) em.createNamedQuery("Missao.findByNome").setParameter("nome", nome).getSingleResult();
        }catch(NoResultException ex){
            return null;
        }
    }
    
}
