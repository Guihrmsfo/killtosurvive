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
import objetos.Equipamento;

/**
 *
 * @author Guilherme
 */
public class EquipamentoDAO implements Serializable {

    public EquipamentoDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public EquipamentoDAO() {
        this.emf = Persistence.createEntityManagerFactory("killtosurvive");
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Equipamento save(Equipamento equipamento) throws Exception {
        EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
            
        if(equipamento.getEquipamentoId() == null) {
        em.persist(equipamento);
      } else {
        equipamento = em.merge(equipamento);
      }
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    return equipamento;   
    }


     public void delete(Integer id) throws Exception {
       EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
      // Consulta a pessoa na base de dados através do seu ID.
      Equipamento equipamento = em.find(Equipamento.class, id);
      System.out.println("Excluindo os dados de: " + equipamento.getNome());
      // Remove a pessoa da base de dados.
      em.remove(equipamento);
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    }

    public List<Equipamento> findEquipamentoEntities() {
        return findEquipamentoEntities(true, -1, -1);
    }

    public List<Equipamento> findEquipamentoEntities(int maxResults, int firstResult) {
        return findEquipamentoEntities(false, maxResults, firstResult);
    }

    private List<Equipamento> findEquipamentoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Equipamento.class));
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

    public Equipamento findEquipamento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Equipamento.class, id);
        } finally {
            em.close();
        }
    }

    public int getEquipamentoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Equipamento> rt = cq.from(Equipamento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public Equipamento consultarPorNome(String nome){
        EntityManager em = getEntityManager();
        try{
        return (Equipamento) em.createNamedQuery("Equipamento.findByNome").setParameter("nome", nome).getSingleResult();
        }catch(NoResultException ex){
            return null;
        }
    }
    
}