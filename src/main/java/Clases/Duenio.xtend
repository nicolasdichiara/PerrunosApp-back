package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import javax.persistence.Entity
import java.util.List
import javax.persistence.OneToMany
import javax.persistence.FetchType

@Accessors
@Entity
class Duenio extends Usuario{
	
	@OneToMany(fetch=FetchType.LAZY)
	List<Perro> perros = newArrayList
	
	def agregarPerro(Perro unPerro){
		perros.add(unPerro)
	}
	
	def eliminarPerro(Perro unPerro){
		perros.remove(unPerro)
	}
	
}