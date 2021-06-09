package Repositorio

import javax.persistence.criteria.Root
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import Clases.Servicio
import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.LocalTime
import Clases.TipoServicio
import Clases.Perfil
import Clases.Usuario

class RepositorioServicio extends RepositorioAbstract<Servicio> {

	override getEntityType() {
		return Servicio
	}

	override fetch(Root<Servicio> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Servicio> query, Root<Servicio> camposRaza,
		Long id) {
		if (id !== null) {
			query.where(newArrayList => [
				add(criteria.equal(camposRaza.get("idServicio"), id))
				add(criteria.equal(camposRaza.get("activo"), 1))
			])
		}
	}

	def searchByIDSinWhereDeActivo(Long id) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			val criteria = entityManager.criteriaBuilder
			val query = criteria.createQuery(getEntityType)
			val from = query.from(getEntityType)
			query.where(criteria.equal(from.get("idServicio"), id))
			entityManager.createQuery(query).singleResult
		} finally {
			entityManager?.close
		}
	}

	def serviciosActivosDelDuenioConUsuarios(Long idUser, String tipoUsuario) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager.createQuery(
				"SELECT NEW Repositorio.ServicioConUsuario(
					serv.idServicio, serv.activo, serv.fechaRealizacion, serv.horario, serv.calificacionDuenio, 
					serv.calificacionPrestador, serv.tipoServicio, serv.latitudDuenio, serv.longitudDuenio, serv.latitudPrestador, serv.longitudPrestador,
					serv.Precio, prest.idUsuario, prest.nombre, prest.apellido, prest.telefono, prest.imagenPerfil,
					duenio.idUsuario, duenio.nombre, duenio.apellido, duenio.telefono, duenio.imagenPerfil) " + 
				"FROM Servicio serv " + 
					"JOIN serv.prestador prest  " +
					"JOIN serv.duenio duenio  " +
				"WHERE 
					serv.activo = 1 AND 
					" + tipoUsuario + ".idUsuario = :idUser", ServicioConUsuario)
			.setParameter("idUser", idUser)
			//.setParameter("tipoUsuario", tipoUsuario)
			.resultList
		} finally {
			entityManager?.close
		}
	}
	
	def serviciosPorIdConUsuarios(Long idServicio) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager.createQuery(
				"SELECT NEW Repositorio.ServicioConUsuario(
					serv.idServicio, serv.activo, serv.fechaRealizacion, serv.horario, serv.calificacionDuenio, 
					serv.calificacionPrestador, serv.tipoServicio, serv.latitudDuenio, serv.longitudDuenio, serv.latitudPrestador, serv.longitudPrestador,
					serv.Precio, prest.idUsuario, prest.nombre, prest.apellido, prest.telefono, prest.imagenPerfil,
					duenio.idUsuario, duenio.nombre, duenio.apellido, duenio.telefono, duenio.imagenPerfil) " + 
				"FROM Servicio serv " + 
					"JOIN serv.prestador prest  " +
					"JOIN serv.duenio duenio  " +
				"WHERE 
					serv.idServicio = :idServicio", ServicioConUsuario)
			.setParameter("idServicio", idServicio)
			//.setParameter("tipoUsuario", tipoUsuario)
			.singleResult
		} finally {
			entityManager?.close
		}
	}

}

@Accessors
class ServicioConUsuario {
	Long idServicio
	Boolean activo
	LocalDate fechaRealizacion
	LocalTime horario
	Double calificacionDuenio
	Double calificacionPrestador
	TipoServicio tipoServicio
	String latitudDuenio
	String longitudDuenio
	String latitudPrestador
	String longitudPrestador
	Double Precio
	Long idPrestador
	String nombrePrestador
	String apellidoPrestador
	String telefonoPrestador
	String imagenPerfilPrestador
	Long idDuenio
	String nombreDuenio
	String apellidoDuenio
	String telefonoDuenio
	String imagenPerfilDuenio

	new(Long _idServicio, Boolean _activo, LocalDate _fechaRealizacion,
		LocalTime _horario, Double _calificacionDuenio, Double _calificacionPrestador, TipoServicio _tipoServicio,
		String _latitudDuenio, String _longitudDuenio, String _latitudPrestador, String _longitudPrestador,
		Double _Precio, Long _idPrestador, String _nombrePrestador, String _apellidoPrestador, String _telefonoPrestador,
		String _imagenPerfilPrestador, Long _idDuenio, String _nombreDuenio, String _apellidoDuenio, String _telefonoDuenio,
		String _imagenPerfilDuenio) {

		idServicio = _idServicio
		activo = _activo
		fechaRealizacion = _fechaRealizacion
		horario = _horario
		calificacionDuenio = _calificacionDuenio
		calificacionPrestador = _calificacionPrestador
		tipoServicio = _tipoServicio
		latitudDuenio = _latitudDuenio
		longitudDuenio = _longitudDuenio
		latitudPrestador = _latitudPrestador
		longitudPrestador = _longitudPrestador
		Precio = _Precio
		idPrestador = _idPrestador
		nombrePrestador = _nombrePrestador
		apellidoPrestador = _apellidoPrestador
		telefonoPrestador = _telefonoPrestador
		imagenPerfilPrestador = _imagenPerfilPrestador
		idDuenio = _idDuenio
		nombreDuenio = _nombreDuenio
		apellidoDuenio = _apellidoDuenio
		telefonoDuenio = _telefonoDuenio
		imagenPerfilDuenio = _imagenPerfilDuenio
	}
}
