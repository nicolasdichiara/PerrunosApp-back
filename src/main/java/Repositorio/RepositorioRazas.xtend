package Repositorio

import Clases.Raza
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepositorioRazas extends RepositorioAbstract<Raza> {
	
	override getEntityType() {
		return Raza
	}
	
	override fetch(Root<Raza> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Raza> query, Root<Raza> camposRaza,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposRaza.get("idRaza"), id))
		}
	}

}