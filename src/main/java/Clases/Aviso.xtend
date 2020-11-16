package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import java.time.LocalTime
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.FetchType

@Entity
@Accessors
class Aviso {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idAviso
	@Column
	Boolean recurrente
	@Column
	Boolean lunes
	@Column
	Boolean martes
	@Column
	Boolean miercoles
	@Column
	Boolean jueves
	@Column
	Boolean viernes
	@Column
	Boolean sabado
	@Column
	Boolean domingo
	@Column
	Boolean fechaParticular
	@Column
	LocalDate fecha
	@Column
	LocalTime horario
	@Column(length=512)
	String detalle
	@Column
	Boolean activo
	@ManyToOne(fetch=FetchType.EAGER)
	TipoServicio tipoServicio
	@Column
	Long idPerro
	@Column
	Long Precio
	
	def finalizarAviso(){//porque lo contrataron o porque lo dio de baja
		activo = false
	}
	
	
	
}