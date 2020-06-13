package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate
import javax.persistence.Entity
import javax.persistence.Id
import javax.persistence.GeneratedValue
import javax.persistence.GenerationType
import javax.persistence.Column
import javax.persistence.ManyToOne
import javax.persistence.FetchType

@Entity
@Accessors
class Perro {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	Integer ID
	@Column(length=150)
	String nombre
	@ManyToOne(fetch=FetchType.LAZY)
	Raza raza
	@Column(length=150)
	String imagen // hay que cargar la imagen del perro
	@Column
	LocalDate fechaNacimiento
	@Column
	Boolean poseeLibretaSanitaria // check
	@Column(length=150)
	String imagenLibretaVacunacion
	@Column
	Boolean vacunaDeLaRabia // check
	@Column
	Boolean desparasitado // check
	@Column(length=150)
	String enfermedadesPrevias
	@Column
	Boolean paseaFrecuente
	@Column
	Boolean paseoAlgunaVez
	@Column
	Boolean paseoConUnPaseador
	@Column
	Boolean paseoConOtrosPerros

}
