package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import java.time.LocalDate
import javax.persistence.ManyToOne
import java.time.LocalTime
import javax.persistence.FetchType

@Entity
@Accessors
class Servicio {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idServicio
	@Column
	String idPrestador
	@Column
	String idDuenio
	@Column
	Long idPerro
	@Column
	Boolean activo
	@Column
	LocalDate fechaRealizacion
	@Column
	LocalTime horario
	@Column
	Boolean pago
	@Column
	Double calificacionDuenio
	@Column
	Double calificacionPrestador
	@ManyToOne(fetch=FetchType.EAGER) //TODO:Perdoname Dodino
	TipoServicio tipoServicio 
	@Column(length=150)
	String latitudDuenio
	@Column(length=150)
	String longitudDuenio
	@Column(length=150)
	String latitudPrestador
	@Column(length=150)
	String longitudPrestador
	@Column
	Long Precio
	
	def finalizarServicio(){
		activo = false
	}
	
	def seEncuentraPago(){
		pago = true
	}
	
}