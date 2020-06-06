package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column

@Entity
@Observable
@Accessors
class Usuario {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idUsuario

	@Column(length=150)
	String username

	@Column(length=150)
	String password

	@Column
	LocalDate fechaAlta

	@Column(length=150)
	String nombre
	
	@Column(length=150)
	String apellido
	
	@Column
	LocalDate fechaNacimiento
	
	@Column(length=150)
	Integer dni
	
	@Column(length=150)
	String telefono
	
	@Column(length=150)
	String direccion
	
	@Column
	String activo
	
	@Column(length=150)
	String email

	def verificarUsuario(String usuarioLogin, String passwordLogin) {
		return (username == usuarioLogin && password == passwordLogin)
	}

}
