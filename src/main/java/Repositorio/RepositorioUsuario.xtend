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

			query.where(newArrayList => [
				add(criteria.equal(camposUsuario.get("idUsuario"), id))
				add(criteria.equal(camposUsuario.get("activo"), 1))
			])
		}
	}

	def perrosDelUsuario(Long idUser) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(getEntityType)
			val from = query.from(getEntityType)
			from.fetch("perros")
			query.where(criteria.equal(from.get("idUsuario"), idUser))
			entityManager.createQuery(query).singleResult
		} finally {
		}
	}

	def obtenerUsuarioPorMail(String unEmail) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(getEntityType)
			val from = query.from(getEntityType)
			query.where(criteria.equal(from.get("email"), unEmail))
			entityManager.createQuery(query).singleResult
		} finally {
		}
	}

	def validarCreate(String unEmail) {
		obtenerUsuarioPorMail(unEmail) === null
	}

}
