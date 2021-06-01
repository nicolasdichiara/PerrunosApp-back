package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Column
import javax.persistence.Transient
import javax.persistence.OneToOne
import javax.persistence.FetchType

@Accessors
@Entity
class Especialista extends Perfil {
	
	@Column
	String nombrePerfil = "Especialista"
	
	@Transient
	static Especialista instance = null
	
	@OneToOne(fetch=FetchType.EAGER)
	TipoServicio tipoServicio

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new Especialista
		}
		instance
	}
}