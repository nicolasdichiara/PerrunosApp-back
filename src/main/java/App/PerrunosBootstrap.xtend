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
import Clases.ServicioPaseo
import Clases.ServicioGuarderia
import Clases.Especialista
import Clases.Administrador

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
			password = "nico"
			fechaAlta = LocalDate.now
			apodo = "Nico"
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 38683033
			telefono = "1166899679"
			direccion = "Calle Falsa 123"
			activo = true
			tipoPerfil = Duenio.instance // creas una unica instancia 
			calificacion = 5.0
		]

		val brian = new Usuario => [
			email = "brian@hotmail.com"
			nombre = "Brian"
			apellido = "Zerial"
			password = "brian"
			fechaAlta = LocalDate.now
			apodo = "Linkin"
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 37494994
			telefono = "123456789"
			direccion = "Calle Falsa 1234"
			activo = true
			tipoPerfil = Paseador.instance
			calificacion = 5.0
		]

		val maxi = new Usuario => [
			email = "maxi@hotmail.com"
			nombre = "Maximiliano"
			apellido = "Bianco"
			password = "maxi"
			fechaAlta = LocalDate.now
			apodo = "El Masi"
			fechaNacimiento = LocalDate.of(1994, 11, 17)
			dni = 38282882
			telefono = "123456789"
			direccion = "Calle Falsa 1234"
			activo = true
			tipoPerfil = Duenio.instance
			calificacion = 5.0
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
		
		val ovejeroAleman = new Raza => [
			nombre = "Ovejero alemán"
		]
		
		val bulldogFrances = new Raza => [
			nombre = "Bulldog francés"
		]
		
		val chihuahua = new Raza => [
			nombre = "Chihuahua"
		]
		
		val canicheToy = new Raza => [
			nombre = "Caniche toy"
		]
		
		val rottweiler = new Raza => [
			nombre = "Rottweiler"
		]
		
		val boxer = new Raza => [
			nombre = "Boxer"
		]
		
		val shnauser = new Raza => [
			nombre = "Shnauser"
		]
		
		val bojeroDeBerna = new Raza => [
			nombre = "Bojero de berna"
		]
		
		val galgo = new Raza => [
			nombre = "Galgo"
		]
		
		val pug = new Raza => [
			nombre = "Pug"
		]
		
		val husky = new Raza => [
			nombre = "Husky Siberiano"
		]
		
		val bullTerrier = new Raza => [
			nombre = "Bull Terrier"
		]
		
		val beagle = new Raza => [
			nombre = "Beagle"
		]
		
		val springerSp = new Raza => [
			nombre = "Springer Spaniel"
		]
		
		val cockerSp = new Raza => [
			nombre = "Cocker spaniel"
		]
		
		val dachshund = new Raza => [
			nombre = "Dachshund - Salchicha"
		]
		
		val maltes = new Raza => [
			nombre = "Bichón Maltés"
		]
		
		val doberman = new Raza => [
			nombre = "Dóberman"
		]
		
		val dogoBur = new Raza => [
			nombre = "Dogo de Burdeos"
		]
		
		val dogoAr = new Raza => [
			nombre = "Dogo Argentino"
		]
		
		val foxTerr = new Raza => [
			nombre = "Fox terrier"
		]
		
		val granDanes = new Raza => [
			nombre = "Gran danés"
		]
		
		val dalmata = new Raza => [
			nombre = "Dálmata"
		]
		
		val sanBer = new Raza => [
			nombre = "San Bernardo"
		]
		
		val shihTzu = new Raza => [
			nombre = "Shih Tzu"
		]
		
		val poodle = new Raza => [
			nombre = "Poodle"
		]
		
		val sharPei = new Raza => [
			nombre = "Shar Pei"
		]
		
		val chow = new Raza => [
			nombre = "Chow Chow"
		]
		
		val yorkTerr = new Raza => [
			nombre = "Yorkshire terrier"
		]
		
		val mestizo = new Raza => [
			nombre = "Mestizo"
		]

		// ////////////////////////////////////////////
		// CREO LOS PERROS                           //
		// ////////////////////////////////////////////
		// PERROS DE NICO
		val remi = new Perro => [
			nombre = "Remi"
			raza = borderCollie	//TODO es un objeto hay que verlo
			
			fechaNacimiento = LocalDate.of(2017, 11, 10)
			poseeLibretaSanitaria = true
			imagenLibretaVacunacion = "aca va a ir un path al server"
			descripcion = "amigable"
			cuidadosEspeciales = "ninguno"
			vacunaDeLaRabia = true
			desparasitado = true
			enfermedadesPrevias = "ninguna"
			paseaFrecuente = true
			paseoAlgunaVez = true
			paseoConUnPaseador = false
			paseoConOtrosPerros = false
			activo = true
		]

		// ////////////////////////////////////////////
		// CREO LOS AVISOS                           //
		// ////////////////////////////////////////////
//		val avisoNicoPaseo = new Aviso => [
//			recurrente = true
//			lunes = true
//			martes = false
//			miercoles = true
//			jueves = false
//			viernes = false
//			sabado = false
//			domingo = false
//			horario = LocalTime.of(14, 30)
//			detalle = "Tiene collar de ahorque"
//			activo = true
//			tipoServicio = ServicioPaseo.instance
//			idPerro = remi.idPerro//TODO:Ver tema de id que queda null porque todavia no persiste
//		]
//
//		val avisoNicoPaseo2 = new Aviso => [
//			recurrente = false
//			lunes = false
//			martes = false
//			miercoles = false
//			jueves = false
//			viernes = false
//			sabado = false
//			domingo = false
//			fechaParticular = true
//			fecha = LocalDate.of(2020, 7, 15)
//			horario = LocalTime.of(14, 30)
//			detalle = "Aca iria una descripcion pero no se que poner"
//			activo = true
//			tipoServicio = ServicioPaseo.instance
//			idPerro = remi.idPerro
//		]

		// AGREGO LOS PERROS A LOS USUARIOS
		nico.agregarPerro(remi)

		// AGREGO LOS AVISOS A LOS USUARIOS
//		nico.agregarAviso(avisoNicoPaseo)
//		nico.agregarAviso(avisoNicoPaseo2)

		// ////////////////////////////////////////////
		// PERSISTO LAS COSAS                        //
		// ////////////////////////////////////////////
		// PERSISTO LOS PERFILES
		repoPerfil.create(Paseador.instance) // como es un tipo de perfil creamos un unico tipo de paseador
		repoPerfil.create(Guarderia.instance)
		repoPerfil.create(Duenio.instance)
		repoPerfil.create(Especialista.instance)
		repoPerfil.create(Administrador.instance)

		// PERSISTO LOS TIPOS DE SERVICIO
		repoTipoDeServicio.create(ServicioPaseo.instance)
		repoTipoDeServicio.create(ServicioGuarderia.instance)

		// PERSISTO LAS RAZAS TODO:Repo razas
		repoRazas.create(pointer)
		repoRazas.create(pitbull)
		repoRazas.create(borderCollie)
		repoRazas.create(labrador)
		repoRazas.create(golden)
		repoRazas.create(ovejeroAleman)
		repoRazas.create(bulldogFrances)
		repoRazas.create(chihuahua)
		repoRazas.create(canicheToy)
		repoRazas.create(rottweiler)
		repoRazas.create(boxer)
		repoRazas.create(shnauser)
		repoRazas.create(bojeroDeBerna)
		repoRazas.create(galgo)
		repoRazas.create(pug)
		repoRazas.create(husky)
		repoRazas.create(bullTerrier)
		repoRazas.create(beagle)
		repoRazas.create(springerSp)
		repoRazas.create(cockerSp)
		repoRazas.create(dachshund)
		repoRazas.create(maltes)
		repoRazas.create(doberman)
		repoRazas.create(dogoBur)
		repoRazas.create(foxTerr)
		repoRazas.create(granDanes)
		repoRazas.create(dalmata)
		repoRazas.create(sanBer)
		repoRazas.create(shihTzu)
		repoRazas.create(poodle)
		repoRazas.create(sharPei)
		repoRazas.create(chow)
		repoRazas.create(yorkTerr)
		repoRazas.create(mestizo)
		repoRazas.create(dogoAr)

		// PERSISTO LOS PERROS TODO:Repo perros
		repoPerros.create(remi)

		// PERSISTO LOS AVISOS
//		repoAviso.create(avisoNicoPaseo)
//		repoAviso.create(avisoNicoPaseo2)
		
		// PERSISTO LOS USUARIOS
		repoU.create(nico)
		repoU.create(brian)
		repoU.create(maxi)

	}
}
