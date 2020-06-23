package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Transient
import javax.persistence.Column

@Accessors
@Entity
class Duenio extends Perfil {
	
	@Column
	String nombrePerfil = "Duenio"
	
	@Transient
	static Duenio instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new Duenio
		}
		instance
	}
}
