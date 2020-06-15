package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Transient

@Entity
@Accessors
class ServicioGuarderia extends TipoServicio {
	
	String nombre = "Servicio de Guarderia"		//tipo de servicio
	
	@Transient
	static ServicioGuarderia instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new ServicioGuarderia
		}
		instance
	}
}