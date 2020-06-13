package Clases

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Id
import javax.persistence.Column

@Entity
@Accessors
class Raza {
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idRaza
	
	@Column
	String nombre
	
}