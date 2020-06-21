package Repositorio

import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import Clases.Servicio

class RepositorioServicio extends RepositorioAbstract<Servicio> {

	override getEntityType() {
		return Servicio
	}

	override fetch(Root<Servicio> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Servicio> query, Root<Servicio> camposRaza, Long id) {
		if (id !== null) {
			query.where(newArrayList => [
				add(criteria.equal(camposRaza.get("idServicio"), id))
				add(criteria.equal(camposRaza.get("activo"), 1))
			])
		}
	}
	
}