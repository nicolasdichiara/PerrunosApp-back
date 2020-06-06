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
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override fetch(Root<Usuario> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
	override generateWhereId(CriteriaBuilder builder, CriteriaQuery<Usuario> query, Root<Usuario> root, Long long1) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}
	
}