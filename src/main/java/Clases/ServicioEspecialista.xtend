package Clases

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Transient

@Entity
@Accessors
class ServicioEspecialista extends TipoServicio {
	
	String nombre = "Servicio de Especialista"
	
	Double PrecioStandard = 200.0
	
	@Transient
	static ServicioEspecialista instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new ServicioEspecialista
		}
		instance
	}
	
}