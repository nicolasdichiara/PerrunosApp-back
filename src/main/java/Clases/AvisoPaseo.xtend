package Clases

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Column
import javax.persistence.Transient

@Entity
@Accessors
class AvisoPaseo extends TipoServicio{
	
	@Column
	String nombreAviso = "Aviso de Paseo"
	
	@Transient
	static AvisoPaseo instance = null

	private new() {
	}

	static def getInstance() {
		if (instance === null) {
			instance = new AvisoPaseo
		}
		instance
	}
	
}