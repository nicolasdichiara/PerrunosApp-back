package Repositorio

import Clases.Aviso
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import Clases.Usuario

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
}
