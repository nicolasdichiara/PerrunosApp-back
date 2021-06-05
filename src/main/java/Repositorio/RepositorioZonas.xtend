package Repositorio

import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import Clases.Zona

class RepositorioZonas extends RepositorioAbstract<Zona>{
	
	override getEntityType() {
		return Zona
	}
	
	override fetch(Root<Zona> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Zona> query, Root<Zona> camposRaza,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposRaza.get("idZona"), id))
		}
	}
	
}