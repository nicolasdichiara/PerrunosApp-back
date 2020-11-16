package Clases

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Transient

@Entity
@Accessors
class ServicioPaseo extends TipoServicio {
	
	String nombre = "Servicio de Paseo"
	
	Double PrecioStandard = 200.0
	
	@Transient
	static ServicioPaseo instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new ServicioPaseo
		}
		instance
	}
}