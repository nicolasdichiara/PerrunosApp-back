package Repositorio

import Clases.Aviso
import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import java.time.LocalDate
import Clases.TipoServicio
import Clases.Zona
import org.eclipse.xtend.lib.annotations.Accessors
import Clases.Perfil

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

	def avisosActivos() {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(entityType)
			val from = query.from(entityType)
			query.select(from)
			query.where(criteria.equal(from.get("activo"), 1))
			entityManager.createQuery(query).resultList
		} finally {
			entityManager?.close
		}
	}

	def avisosActivosConUsuario() {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager.createQuery(
				"SELECT NEW Repositorio.AvisoConUsuario(a.idAviso, a.fechaPublicacion, a.horario, a.detalle, a.activo, a.tipoServicio, a.Precio, a.zona, " +
					"a.lunes, a.martes, a.miercoles, a.jueves, a.viernes, a.sabado, a.domingo, u.idUsuario, u.nombre, u.apellido, u.telefono, u.tipoPerfil, u.calificacion, u.imagenPerfil) " +
					"FROM Aviso a " + "JOIN a.usuarioPublicante u " + "WHERE a.activo = 1", AvisoConUsuario).resultList
		} finally {
			entityManager?.close
		}
	}
	
	def avisoPorIdConUsuario(Long idAviso) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager.createQuery(
				"SELECT NEW Repositorio.AvisoConUsuario(a.idAviso, a.fechaPublicacion, a.horario, a.detalle, a.activo, a.tipoServicio, a.Precio, a.zona, " +
					"a.lunes, a.martes, a.miercoles, a.jueves, a.viernes, a.sabado, a.domingo, u.idUsuario, u.nombre, u.apellido, u.telefono, u.tipoPerfil, u.calificacion, u.imagenPerfil) " +
					"FROM Aviso a " + "JOIN a.usuarioPublicante u " + "WHERE a.idAviso = :idAviso AND a.activo = 1", AvisoConUsuario)
			.setParameter("idAviso", idAviso)
			.singleResult
		} finally {
			entityManager?.close
		}
	}
}

@Accessors
class AvisoConUsuario {
	Long idAviso
	LocalDate fechaPublicacion
	String horario
	String detalle
	Boolean activo
	TipoServicio tipoServicio
	Double Precio
	Zona zona
	Boolean lunes
	Boolean martes
	Boolean miercoles
	Boolean jueves
	Boolean viernes
	Boolean sabado
	Boolean domingo
	Long idUsuario
	String nombre
	String apellido
	String telefono
	Perfil tipoPerfil
	Double calificacion
	String imagenPerfil

	new(Long _idAviso, LocalDate _fechaPublicacion, String _horario, String _detalle, Boolean _activo,
		TipoServicio _tipoServicio, Double _Precio, Zona _zona, Boolean _lunes, Boolean _martes, Boolean _miercoles,
		Boolean _jueves, Boolean _viernes, Boolean _sabado, Boolean _domingo, Long _idUsuario, String _nombre, String _apellido,
		String _telefono, Perfil _tipoPerfil, Double _calificacion, String _imagenPerfil) {

		idAviso = _idAviso
		fechaPublicacion = _fechaPublicacion
		horario = _horario
		detalle = _detalle
		activo = _activo
		tipoServicio = _tipoServicio
		Precio = _Precio
		zona = _zona
		lunes = _lunes
		martes = _martes
		miercoles = _miercoles
		jueves = _jueves
		viernes = _viernes
		sabado = _sabado
		domingo = _domingo
		idUsuario = _idUsuario
		nombre = _nombre
		apellido = _apellido
		telefono = _telefono
		tipoPerfil = _tipoPerfil
		calificacion = _calificacion
		imagenPerfil = _imagenPerfil
	}
}
