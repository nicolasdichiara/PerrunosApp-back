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
class PagoServicio {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idPago
	@Column
	LocalDate fechaPago
	@Column
	String medioPago
	@Column
	String linkRecibo
}