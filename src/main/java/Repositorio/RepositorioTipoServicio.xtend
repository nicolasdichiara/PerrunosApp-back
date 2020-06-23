package Repositorio

import Clases.TipoServicio
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import Clases.ServicioPaseo
import Clases.ServicioGuarderia

class RepositorioTipoServicio extends RepositorioAbstract<TipoServicio> {

	override getEntityType() {
		return TipoServicio
	}

	override fetch(Root<TipoServicio> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<TipoServicio> query, Root<TipoServicio> camposRaza, Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposRaza.get("idTipoServicio"), id))
		}
	}
	
	def TipoServicio tipoDeServicio(String unTipo) {
		if(unTipo == "4"){
			ServicioPaseo.instance
		} else {
			ServicioGuarderia.instance
		}
	}

}