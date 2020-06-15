package App

import Clases.Duenio
import java.time.LocalDate
import Repositorio.RepositorioUsuario
import Clases.Paseador
import Clases.Raza
import Repositorio.RepositorioRazas
import Repositorio.RepositorioPerros
import Clases.Perro
import Clases.Usuario
import Repositorio.RepositorioPerfil
import Clases.Guarderia
import Repositorio.RepositorioAvisos
import Clases.Aviso
import java.time.LocalTime
import Repositorio.RepositorioTipoServicio

class PerrunosBootstrap {

	static RepositorioUsuario repoU = new RepositorioUsuario
	static RepositorioRazas repoRazas = new RepositorioRazas
	static RepositorioPerros repoPerros = new RepositorioPerros
	static RepositorioPerfil repoPerfil = new RepositorioPerfil
	static RepositorioAvisos repoAviso = new RepositorioAvisos
	static RepositorioTipoServicio repoTipoDeServicio = new RepositorioTipoServicio

	def static crearDatosSiNoHay() {
		if (repoRazas.allInstances.size == 0) {
			crearDatos
		} else {
			println("Ya hay datos cargados en la base, se saltea la creación de datos de prueba")
		}
	}

	def static crearDatos() {
		// ////////////////////////////////////////////
		// CREO LOS USUARIOS                         //
		// ////////////////////////////////////////////
		val nico = new Usuario => [
			email = "nicolasdichiara@hotmail.com"
			nombre = "Nicolás"
			apellido = "Dichiara"
			password = "ndichiara"
			fechaAlta = LocalDate.now
			apodo = "Nico"
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 38683033
			telefono = "1166899679"
			direccion = "Calle Falsa 123"
			activo = true
			tipoPerfil = Duenio.instance // creas una unica instancia 
		]

		val brian = new Usuario => [
			email = "brian@hotmail.com"
			nombre = "Brian"
			apellido = "Zerial"
			password = "bzerial"
			fechaAlta = LocalDate.now
			apodo = "Linkin"
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 37494994
			telefono = "123456789"
			direccion = "Calle Falsa 1234"
			activo = true
			tipoPerfil = Paseador.instance
		]

		val maxi = new Usuario => [
			email = "maxi@hotmail.com"
			nombre = "Maximiliano"
			apellido = "Bianco"
			password = "mbianco"
			fechaAlta = LocalDate.now
			apodo = "El Masi"
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 38282882
			telefono = "123456789"
			direccion = "Calle Falsa 1234"
			activo = true
			tipoPerfil = Duenio.instance
		]

		// ////////////////////////////////////////////
		// CREO LAS RAZAS                            //
		// ////////////////////////////////////////////
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

		// ////////////////////////////////////////////
		// CREO LOS PERROS                           //
		// ////////////////////////////////////////////
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
			activo = true
		]

		// ////////////////////////////////////////////
		// CREO LOS AVISOS                           //
		// ////////////////////////////////////////////
		val avisoNicoPaseo = new Aviso => [
			recurrente = true
			lunes = true
			martes = false
			miercoles = true
			jueves = false
			viernes = false
			sabado = false
			domingo = false
			horario = LocalTime.of(15, 30)
			detalle = "Tiene collar de ahorque"
			activo = true
			tipoServicio = ServicioPaseo.instance
			idPerro = Long.parseLong("9")
		]

		val avisoNicoPaseo2 = new Aviso => [
			recurrente = false
			lunes = false
			martes = false
			miercoles = false
			jueves = false
			viernes = false
			sabado = false
			domingo = false
			fechaParticular = true
			fecha = LocalDate.of(2020, 7, 15)
			horario = LocalTime.of(15, 30)
			detalle = "Aca iria una descripcion pero no se que poner"
			activo = true
			tipoServicio = ServicioPaseo.instance
			idPerro = Long.parseLong("9")
		]

		// AGREGO LOS PERROS A LOS USUARIOS
		nico.agregarPerro(remi)

		// AGREGO LOS AVISOS A LOS USUARIOS
		nico.agregarAviso(avisoNicoPaseo)
		nico.agregarAviso(avisoNicoPaseo2)

		// ////////////////////////////////////////////
		// PERSISTO LAS COSAS                        //
		// ////////////////////////////////////////////
		// PERSISTO LOS PERFILES
		repoPerfil.create(Paseador.instance) // como es un tipo de perfil creamos un unico tipo de paseador
		repoPerfil.create(Guarderia.instance)
		repoPerfil.create(Duenio.instance)

		// PERSISTO LOS TIPOS DE SERVICIO
		repoTipoDeServicio.create(ServicioPaseo.instance)
		repoTipoDeServicio.create(ServicioGuarderia.instance)

		// PERSISTO LAS RAZAS TODO:Repo razas
		repoRazas.create(pointer)
		repoRazas.create(pitbull)
		repoRazas.create(borderCollie)
		repoRazas.create(labrador)
		repoRazas.create(golden)

		// PERSISTO LOS PERROS TODO:Repo perros
		repoPerros.create(remi)

		// PERSISTO LOS AVISOS
		repoAviso.create(avisoNicoPaseo)
		repoAviso.create(avisoNicoPaseo2)
		
		// PERSISTO LOS USUARIOS
		repoU.create(nico)
		repoU.create(brian)
		repoU.create(maxi)

	}
}
