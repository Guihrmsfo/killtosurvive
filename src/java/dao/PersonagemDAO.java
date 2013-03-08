/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import objetos.Mensagem;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.*;
import javax.transaction.UserTransaction;
import objetos.Personagem;

/**
 *
 * @author Guilherme
 */
public class PersonagemDAO implements Serializable {

    public PersonagemDAO(EntityManagerFactory emf) {
        this.emf = emf;
    }
    
    public PersonagemDAO() {
        this.emf = Persistence.createEntityManagerFactory("killtosurvive");
    }

    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public Personagem save(Personagem personagem) throws Exception {
        EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
            
        if(personagem.getPersonagemId() == null) {
        em.persist(personagem);
      } else {
        personagem = em.merge(personagem);
      }
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    return personagem;   
    }


     public void delete(Integer id) throws Exception {
       EntityManager em = null;
           try {
            em = getEntityManager();
            em.getTransaction().begin();
      // Consulta a pessoa na base de dados através do seu ID.
      Personagem personagem = em.find(Personagem.class, id);
      System.out.println("Excluindo os dados de: " + personagem.getNome());
      // Remove a pessoa da base de dados.
      em.remove(personagem);
      // Finaliza a transação.
      em.getTransaction().commit();
    } finally {
      em.close();
    }
    }

    public List<Personagem> findPersonagemEntities() {
        return findPersonagemEntities(true, -1, -1);
    }

    public List<Personagem> findPersonagemEntities(int maxResults, int firstResult) {
        return findPersonagemEntities(false, maxResults, firstResult);
    }

    private List<Personagem> findPersonagemEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Personagem.class));
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

    public Personagem findPersonagem(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Personagem.class, id);
        } finally {
            em.close();
        }
    }

    public int getPersonagemCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Personagem> rt = cq.from(Personagem.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public Personagem consultarPorNome(String nome){
        EntityManager em = getEntityManager();
        try{
        return (Personagem) em.createNamedQuery("Personagem.findByNome").setParameter("nome", nome).getSingleResult();
        }catch(NoResultException ex){
            return null;
        }
    }
    
}
