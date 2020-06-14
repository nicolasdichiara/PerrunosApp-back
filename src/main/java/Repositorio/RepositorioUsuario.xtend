package Repositorio

import Clases.Usuario
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery

class RepositorioUsuario extends RepositorioAbstract<Usuario> {

	def verificarLogin(String usuarioLogin, String passwordLogin) {
		allInstances.findFirst(usuario|usuario.verificarUsuario(usuarioLogin, passwordLogin))
	}

	override getEntityType() {
		return Usuario
	}

	override fetch(Root<Usuario> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Usuario> query, Root<Usuario> camposUsuario,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposUsuario.get("idUsuario"), id))
		}
	}

}
