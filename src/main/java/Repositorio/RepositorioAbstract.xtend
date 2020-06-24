package Repositorio

import EntityManager.EntityManager
import java.util.List
import javax.persistence.PersistenceException
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors


@Accessors
abstract class RepositorioAbstract<T> {
	

	abstract def Class<T> getEntityType()

	public static EntityManager singletonDeEntityManager = EntityManager.instance

	def List<T> allInstances() {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			entityManager.createQuery(query).resultList

		} finally {
			entityManager?.close
		}
	}

	def void fetch(Root<T> from)

	def create(T t) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager => [
				transaction.begin
				persist(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			
		}
	}

	def update(T t) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager => [
				transaction.begin
				merge(t)
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			
		}
	}

	def delete(T t) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager => [
				transaction.begin
				if (contains(t)) {
					remove(t)
				} else {
					remove(merge(t))
				}
				transaction.commit
			]
		} catch (PersistenceException e) {
			e.printStackTrace
			entityManager.transaction.rollback
			throw new RuntimeException("Ocurrió un error, la operación no puede completarse", e)
		} finally {
			
		}
	}

	def searchByID(Long id) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(getEntityType)
			val from = query.from(getEntityType)
			generateWhereId(criteria, query, from, id)
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

	def void generateWhereId(CriteriaBuilder builder, CriteriaQuery<T> query, Root<T> root, Long long1)

}
	
