package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Transient

@Accessors
@Entity
class Administrador extends Perfil{
	
	@Column
	String nombrePerfil = "Administrador"
	
	@Transient
	static Administrador instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new Administrador
		}
		instance
	}
	
}