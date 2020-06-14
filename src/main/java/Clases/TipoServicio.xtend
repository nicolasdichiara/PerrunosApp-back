package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType

@Entity
@Accessors
abstract class TipoServicio {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idTipoServicio
	
}