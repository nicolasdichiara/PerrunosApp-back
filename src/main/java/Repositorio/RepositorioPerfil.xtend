package Repositorio

import Clases.Perfil
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.CriteriaBuilder

class RepositorioPerfil extends RepositorioAbstract<Perfil> {
	
	override getEntityType() {
		return Perfil
	}
	
	override fetch(Root<Perfil> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Perfil> query, Root<Perfil> camposRaza,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposRaza.get("idPerfil"), id))
		}
	}
	
}