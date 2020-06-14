package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Transient
import javax.persistence.Column

@Entity
@Accessors
class Paseador extends Perfil{
	
	@Column
	String nombrePerfil = "Paseador"
	
	@Transient
	static Paseador instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new Paseador
		}
		instance
	}
}