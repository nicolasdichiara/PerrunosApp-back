package Repositorio

import Clases.Promocion
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepositorioPromociones extends RepositorioAbstract<Promocion> {

	override getEntityType() {
		return Promocion
	}

	override fetch(Root<Promocion> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Promocion> query, Root<Promocion> camposPromocion,
		Long id) {
		if (id !== null) {
			query.where(newArrayList => [
				add(criteria.equal(camposPromocion.get("idPromocion"), id))
			])
		}
	}

}
