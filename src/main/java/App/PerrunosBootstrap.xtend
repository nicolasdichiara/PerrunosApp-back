package App

import Clases.Duenio
import java.time.LocalDate
import Repositorio.RepositorioUsuario
import Clases.Paseador
import Clases.Raza
import Repositorio.RepositorioRazas
import Repositorio.RepositorioPerros
import Clases.Perro

class PerrunosBootstrap {

	static RepositorioUsuario repoU = new RepositorioUsuario
	static RepositorioRazas repoRazas = new RepositorioRazas
	static RepositorioPerros repoPerros = new RepositorioPerros

	def static crearDatosSiNoHay() {
		if (repoPerros.allInstances.size == 0) {
			crearDatos
		} else {
			println("Ya hay datos cargados en al base, se saltea la creación de datos de prueba")
		}
	}

	def static crearDatos() {
		// CREO LOS USUARIOS
		val nico = new Duenio => [
			email = "nicolasdichiara@hotmail.com"
			nombre = "Nicolás"
			apellido = "Dichiara"
			password = "ndichiara"
			fechaAlta = LocalDate.now
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 38683033
			telefono = "1166899679"
			direccion = "Calle Falsa 123"
			activo = true
		]

		val brian = new Paseador => [
			email = "brian@hotmail.com"
			nombre = "Brian"
			apellido = "Zerial"
			password = "bzerial"
			fechaAlta = LocalDate.now
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 37494994
			telefono = "123456789"
			direccion = "Calle Falsa 1234"
			activo = true
		]

		val maxi = new Duenio => [
			email = "maxi@hotmail.com"
			nombre = "Maximiliano"
			apellido = "Bianco"
			password = "mbianco"
			fechaAlta = LocalDate.now
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 38282882
			telefono = "123456789"
			direccion = "Calle Falsa 1234"
			activo = true
		]

		// CREO LAS RAZAS
		val pointer = new Raza => [
			nombre = "Pointer"
		]
		val pitbull = new Raza => [
			nombre = "Pitbull"
		]
		val borderCollie = new Raza => [
			nombre = "Border Collie"
		]
		val labrador = new Raza => [
			nombre = "Labrador Retriever"
		]

		val golden = new Raza => [
			nombre = "Golden Retriever"
		]

		// CREO LOS PERROS
		// PERROS DE NICO
		val remi = new Perro => [
			nombre = "Remi"
			raza = borderCollie
			imagen = "aca va a ir un path al server"
			fechaNacimiento = LocalDate.of(2017, 11, 10)
			poseeLibretaSanitaria = true
			imagenLibretaVacunacion = "aca va a ir un path al server"
			vacunaDeLaRabia = true
			desparasitado = true
			enfermedadesPrevias = "Ninguna"
			paseaFrecuente = true
			paseoAlgunaVez = true
			paseoConUnPaseador = false
			paseoConOtrosPerros = false
		]

		// AGREGO LOS PERROS A LOS USUARIOS
		nico.agregarPerro(remi)
		
		// PERSISTO LAS RAZAS TODO:Repo razas
		repoRazas.create(pointer)
		repoRazas.create(pitbull)
		repoRazas.create(borderCollie)
		repoRazas.create(labrador)
		repoRazas.create(golden)
		
		// PERSISTO LOS PERROS TODO:Repo perros
		repoPerros.create(remi)

		// PERSISTO LOS USUARIOS
		repoU.create(nico)
		repoU.create(brian)
		repoU.create(maxi)


	}
}
