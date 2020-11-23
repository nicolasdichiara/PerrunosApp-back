package Clases

import javax.persistence.Entity
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import org.eclipse.xtend.lib.annotations.Accessors

@Entity
@Accessors
abstract class TipoServicio {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idTipoServicio
	
	Double PrecioStandard
}