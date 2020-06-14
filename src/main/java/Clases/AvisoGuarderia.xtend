package Clases

import javax.persistence.Column
import javax.persistence.Transient
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity

@Entity
@Accessors
class AvisoGuarderia extends TipoServicio{
	
	@Column
	String nombreAviso = "Aviso de Guarderia"
	
	@Transient
	static AvisoGuarderia instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new AvisoGuarderia
		}
		instance
	}
}