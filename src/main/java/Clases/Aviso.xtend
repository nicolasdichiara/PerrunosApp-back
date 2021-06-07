package Clases

import java.time.LocalDate
import javax.persistence.Column
import javax.persistence.Entity
import javax.persistence.FetchType
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.OneToOne
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.ManyToOne

@Entity
@Accessors
class Aviso {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idAviso
	@Column
	LocalDate fechaPublicacion
	@Column(length=100)
	String horario 
	@Column(length=4000)
	String detalle
	@Column
	Boolean activo
	@OneToOne(fetch=FetchType.EAGER)
	TipoServicio tipoServicio
	@Column
	Double Precio
	@OneToOne(fetch=FetchType.EAGER)
	Zona zona
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
	@ManyToOne
	Usuario usuarioPublicante
	
	def finalizarAviso(){//porque lo contrataron o porque lo dio de baja
		activo = false
	}
	
	
	
}