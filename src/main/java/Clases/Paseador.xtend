package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import javax.persistence.Transient
import javax.persistence.Column
import javax.persistence.OneToOne
import javax.persistence.FetchType

@Entity
@Accessors
class Paseador extends Perfil{
	
	@Column
	String nombrePerfil = "Paseador"
	
	@Transient
	static Paseador instance = null
	
	@OneToOne(fetch=FetchType.EAGER)
	TipoServicio tipoServicio

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new Paseador
		}
		instance
	}
}