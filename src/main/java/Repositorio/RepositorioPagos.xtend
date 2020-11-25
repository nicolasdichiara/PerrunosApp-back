package Repositorio

import Clases.PagoServicio
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepositorioPagos extends RepositorioAbstract<PagoServicio>{
	
	override getEntityType() {
		return PagoServicio
	}
	
	override fetch(Root<PagoServicio> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<PagoServicio> query, Root<PagoServicio> camposPagoServicio,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposPagoServicio.get("idPago"), id))
		}
	}
	
}