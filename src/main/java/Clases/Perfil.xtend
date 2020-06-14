package Clases

import javax.persistence.Entity
import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType

@Entity
@Accessors
abstract class Perfil {//STRATEGY
	
	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idPerfil
	
}