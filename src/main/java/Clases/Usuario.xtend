package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable

@Entity
@Observable
@Accessors
class Usuario {
	Integer ID
	String usuario
	String password
	LocalDate fechaAlta
	String nombre
	String apellido
	LocalDate fechaNacimiento
	Integer dni
	Integer telefono
	String direccion
	String activo
	String tipo
	String email
	
		def verificarUsuario(String usuarioLogin, String passwordLogin) {
		return (usuario == usuarioLogin && password == passwordLogin)
	}
	
	  
	
}