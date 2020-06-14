package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Transient
import javax.persistence.Column

@Entity
@Accessors
class Guarderia extends Perfil{
	
	@Column
	String nombrePerfil = "Guarderia"
	
	@Transient
	static Guarderia instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new Guarderia
		}
		instance
	}
}