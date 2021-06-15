package Repositorio

import Clases.Reporte
import javax.persistence.criteria.CriteriaBuilder
import javax.persistence.criteria.CriteriaQuery
import javax.persistence.criteria.Root
import org.eclipse.xtend.lib.annotations.Accessors

class RepositorioReporte extends RepositorioAbstract<Reporte> {

	override getEntityType() {
		return Reporte
	}

	override fetch(Root<Reporte> from) {
		throw new UnsupportedOperationException("TODO: auto-generated method stub")
	}

	override generateWhereId(CriteriaBuilder criteria, CriteriaQuery<Reporte> query, Root<Reporte> camposRaza,
		Long id) {
		if (id !== null) {
			query.where(criteria.equal(camposRaza.get("idReporte"), id))
		}
	}

	def searchByIDConUsuarioReportado(Long id) {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager.createQuery(
				"SELECT NEW Repositorio.ReporteConUsuarioReportado(
					r.idReporte, r.detalle, u.nombre, u.apellido, u.email)
				 FROM Reporte r 
				 JOIN r.usuarioReportado u 
				 WHERE r.idReporte = :id", ReporteConUsuarioReportado)
				 .setParameter("id", id)
				 .singleResult
		} finally {
			entityManager?.close
		}
	}
	
	def todosLosReportesConUsuarioReportado() {
		val entityManager = singletonDeEntityManager.getEntityManager
		try {
			entityManager.createQuery(
				"SELECT NEW Repositorio.ReporteConUsuarioReportado(
					r.idReporte, r.detalle, u.nombre, u.apellido, u.email)
				 FROM Reporte r 
				 JOIN r.usuarioReportado u", ReporteConUsuarioReportado)
				 .resultList
		} finally {
			entityManager?.close
		}
	}

}

@Accessors
class ReporteConUsuarioReportado{
	Long idReporte
	String detalle
	String nombre
	String apellido
	String email
	
	new(Long _idReporte, String _detalle, String _nombre, String _apellido, String _email){
		idReporte = _idReporte
		detalle = _detalle
		nombre = _nombre
		apellido = _apellido
		email = _email
	}
}
