package App

import Clases.Duenio
import java.time.LocalDate
import Repositorio.RepositorioUsuario

class PerrunosBootstrap {
	
	static RepositorioUsuario repoU = new RepositorioUsuario

	def static crearDatos() {
		// CREO LOS USUARIOS
		val nico = new Duenio => [
			username = "ndichiara"
			password = "ndichiara"
			fechaAlta = LocalDate.now
			nombre = "Nicolás"
			apellido = "Dichiara"
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 38683033
			telefono = "1166899679"
			direccion = "Calle Falsa 123"
			activo = true
			email = "nicolasdichiara@hotmail.com"
		]

		//PERSISTO LOS USUARIOS
		repoU.create(nico)
	}
}
