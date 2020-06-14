package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import javax.persistence.Entity
import org.uqbar.commons.model.annotations.Observable
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import javax.persistence.OneToMany
import javax.persistence.FetchType
import java.util.List
import javax.persistence.ManyToOne


@Entity
@Observable
@Accessors
class Usuario {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Long idUsuario

	@Column(length=150)
	String email

	@Column(length=150)
	String nombre
	
	@Column(length=150)
	String apellido
	
	@Column(length=150)
	String password

	@Column
	LocalDate fechaAlta

	@Column
	LocalDate fechaNacimiento
	
	@Column(length=150)
	Integer dni
	
	@Column(length=150)
	String telefono
	
	@Column(length=150)
	String direccion
	
	@Column
	Boolean activo
	
	@ManyToOne(fetch=FetchType.LAZY)
	Perfil tipoPerfil
	
	@OneToMany(fetch=FetchType.LAZY)
	List<Perro> perros = newArrayList
	
	def agregarPerro(Perro unPerro){
		if("Due�o"==Duenio.instance.nombrePerfil){
			perros.add(unPerro)
		}
	}
	
	def eliminarPerro(Perro unPerro){
		perros.remove(unPerro)
	}

	def verificarUsuario(String usuarioLogin, String passwordLogin) {
		return (email == usuarioLogin && password == passwordLogin)
	}
	
	def deshabilitarPerfil(){
		activo = false
	}

}
