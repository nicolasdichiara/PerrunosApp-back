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
import javax.persistence.ManyToMany

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
	
	@Column(length=150)
	String apodo

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
	
	@ManyToOne(fetch=FetchType.EAGER)
	Perfil tipoPerfil
	
	@OneToMany(fetch=FetchType.LAZY)
	List<Perro> perros = newArrayList
	
	@OneToMany(fetch=FetchType.LAZY)
	List<Aviso> avisos = newArrayList
	
	@ManyToMany(fetch=FetchType.LAZY)
	List<Servicio> servicios = newArrayList
	
	@Column
	Double calificacion
	
	@Column(length=150)
	String imagenPerfil
	
	def agregarPerro(Perro unPerro){
		if("Duenio"==Duenio.instance.nombrePerfil){
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
	
	def agregarAviso(Aviso aviso) {
		avisos.add(aviso)
	}
	
	def agregarServicio(Servicio servicio) {
		servicios.add(servicio)
	}
	
	def tieneAviso(Long idAviso) {
		avisos.map[aviso|aviso.idAviso].contains(idAviso)
	}
	
	def calificaciones(){
		if(tipoPerfil.nombrePerfil=="Duenio"){
			servicios.filter[servicio|servicio.calificacionDuenio!==null].map[servicio|servicio.calificacionDuenio].toList
		} else {
			servicios.filter[servicio|servicio.calificacionPrestador!==null].map[servicio|servicio.calificacionPrestador].toList
		}
	}
	
	def actualizarCalificacion(Servicio unServicio) {
		calificacion = calificaciones.fold(0.0, [acum, calificacion|acum + calificacion]) / cantidadCalificacionesParaPromediar
	}
	
	def cantidadCalificacionesParaPromediar(){//Devuelve 1 si no hay
		if(calificaciones.size==0){
			1
		} else {
			calificaciones.size
		}
	}
}
