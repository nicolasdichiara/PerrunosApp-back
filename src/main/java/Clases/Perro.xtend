package Clases

import org.eclipse.xtend.lib.annotations.Accessors
import java.time.LocalDate

@Accessors
class Perro {
	Integer ID
	String nombre
	String raza
	String imagen //hay que cargar la imagen del perro
	LocalDate fechaNacimiento
	String poseeLibretaSanitaria //check
	String imagenLibretaVacunacion
	String vacunaDeLaRabia //check
	String desparasitado //check
	String enfermedadesPrevias
	String paseaFrecuente 
	String paseoAlgunaVez
	String paseoConUnPaseador
	String paseoConOtrosPerros
	
}