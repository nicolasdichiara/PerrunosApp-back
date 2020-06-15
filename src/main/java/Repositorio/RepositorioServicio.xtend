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
	
	override generateWhereId(CriteriaBuilder builder, CriteriaQuery<Servicio> query, Root<Servicio> root, Long long1) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	


	
}