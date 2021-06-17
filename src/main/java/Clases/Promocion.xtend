package Clases

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import java.time.LocalDate

@Entity
@Accessors
class Promocion {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idPromocion
	@Column
	String imagenPromo
	@Column
	LocalDate fechaVigencia
	@Column
	Boolean activa
	@Column
	String detalle
	@Column 
	Integer cantidadPaseos
	
}