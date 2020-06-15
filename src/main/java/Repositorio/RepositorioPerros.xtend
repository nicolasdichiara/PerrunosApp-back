package Repositorio

import Clases.Perro
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepositorioPerros extends RepositorioAbstract<Perro> {
	
	override getEntityType() {
		return Perro
	}
	
	override fetch(Root<Perro> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Perro> query, Root<Perro> camposRaza,
		Long id) {
		if (id !== null) {			
			query.where(newArrayList => [
				add(criteria.equal(camposRaza.get("idPerro"), id))
				add(criteria.equal(camposRaza.get("activo"), 1))
			])
		}
	}
	
	def validarIdPerro(String unIdPerro) {
		if(unIdPerro.isNullOrEmpty){
			null
		} else {
			Long.parseLong(unIdPerro)
		}
	}
	
}