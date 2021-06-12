package Repositorio

import Clases.Reporte
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root

class RepositorioReporte extends RepositorioAbstract<Reporte> {
	
	override getEntityType() {
		return Reporte
	}
	
	override fetch(Root<Reporte> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Reporte> query, Root<Reporte> camposRaza,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposRaza.get("idReporte"), id))
		}
	}

}