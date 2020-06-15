package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import java.time.LocalDate

@Entity
@Accessors
class Servicio {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idServicio
	
	@Column
	Long idDunio
	
	@Column
	Long idPerro
	
	@Column
	Long idPrestadorDeServicio
	
	val tipoServicio = TipoServicio
	
	@Column
	Boolean estadoFinalizado
	
	@Column
	LocalDate fechaRealizacion
	
	@Column
	Boolean pago
	
	@Column
	Double calificacion
	
	def finalizarServicio(){
		estadoFinalizado = false
	}
	
	def seEncuentraPago(){
		pago = true
	}
	
	def calificar(){
		
	}
	
}