package Repositorio

import Clases.Aviso
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepositorioAvisos extends RepositorioAbstract<Aviso> {

	override getEntityType() {
		return Aviso
	}

	override fetch(Root<Aviso> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Aviso> query, Root<Aviso> camposRaza, Long id) {
		if (id !== null) {
			query.where(newArrayList => [
				add(criteria.equal(camposRaza.get("idAviso"), id))
				add(criteria.equal(camposRaza.get("activo"), 1))
			])
		}
	}
	
	def avisosActivos() {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			query.where(criteria.equal(from.get("activo"), 1))
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}
	
}
