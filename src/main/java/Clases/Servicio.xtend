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
import javax.persistence.OneToOne

@Entity
@Accessors
class Servicio {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idServicio
	@ManyToOne
	Usuario prestador
	@ManyToOne
	Usuario duenio
//	@Column
//	Long idPerro
	@Column
	Boolean activo
	@Column
	LocalDate fechaRealizacion
	@Column
	LocalTime horario
	@Column
	Boolean pago = false
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
	Double Precio
	@OneToOne(fetch=FetchType.EAGER)
	PagoServicio pagoDelServicio
	
	def finalizarServicio(){
		activo = false
	}
	
	def pagarServicio(PagoServicio unPago){
		pago = true
		pagoDelServicio=unPago
	}
	
}