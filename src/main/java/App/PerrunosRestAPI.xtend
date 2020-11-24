package App

import org.uqbar.xtrest.api.annotation.Controller
import Repositorio.RepositorioUsuario
import org.uqbar.xtrest.json.JSONUtils
import org.uqbar.xtrest.api.annotation.Body
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.xtrest.api.annotation.Post
import ParserStringToLong.ParserStringToLong
import org.uqbar.commons.model.exceptions.UserException
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import org.uqbar.xtrest.api.annotation.Get
import Serializer.UsuarioSerializer
import Clases.Duenio
import java.time.LocalDate
import Clases.Paseador
import Clases.Usuario
import org.uqbar.xtrest.api.annotation.Delete
import Clases.Perro
import Repositorio.RepositorioPerros
import Repositorio.RepositorioRazas
import Clases.Aviso
import Repositorio.RepositorioAvisos
import Repositorio.RepositorioServicio
import java.time.LocalTime
import Repositorio.RepositorioTipoServicio
import Clases.Servicio
import Clases.ServicioPaseo
import Serializer.GpsSerializerDuenio
import Serializer.GpsSerializerPrestador
import EntityManager.EntityManager

@Controller //maneja las llamadas post, etc
class PerrunosRestAPI {

	extension JSONUtils = new JSONUtils // permite combertir a json y diceversa (serializar y deserealizar)
	RepositorioUsuario repoUsuario = new RepositorioUsuario
	RepositorioPerros repoPerro = new RepositorioPerros
	RepositorioRazas repoRaza = new RepositorioRazas
	RepositorioAvisos repoAviso = new RepositorioAvisos
	RepositorioServicio repoServicio = new RepositorioServicio
	RepositorioTipoServicio repoTipoServicio = new RepositorioTipoServicio
	public static EntityManager singletonDeEntityManager = EntityManager.instance

	static ParserStringToLong parserStringToLong = ParserStringToLong.instance // los ID en hibernate son de tipo long o inter y los pasamos a tipo string

	new() {
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// LOGIN                                                                          //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/usuario/login") // te permite enviar un body de json sin que se vea en la direccion esto te lo envia el front, envia informa y espera respuesta
	def login(@Body String body) {
		try {
			val usuarioLogeadoBody = body.fromJson(UsuarioLogeadoRequest) // fromJson deserealiza de json a tipo objeto y trae el usaurio y contrasenia
			try {
				val usuarioLogeado = this.repoUsuario.verificarLogin(usuarioLogeadoBody.usuario,
					usuarioLogeadoBody.password)
				usuarioLogeado.fechaAlta = usuarioLogeado.fechaAlta.plusDays(1)
				//usuarioLogeado.fechaNacimiento.plusDays(1)
				return ok(UsuarioSerializer.toJson(usuarioLogeado))
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) { // el segundo sirve por si se trata de asignar una propiedad objeto por otro medio como constructor
			return badRequest()
		}
	}//OK

	@Get("/usuario/:id") // busca informacion en el back
	def dameUsuario() {
		try {
			val usuario = repoUsuario.searchByID(Long.parseLong(id))
			usuario.fechaAlta.plusDays(1)
			//usuario.fechaAlta = usuario.fechaNacimiento.plusDays(1)
			return ok(UsuarioSerializer.toJson(usuario))

		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// REGISTRO USUARIO                                                               //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/usuario/createDuenio")
	def crearDuenio(@Body String body) {
		try {
			if (repoUsuario.validarCreate(body.getPropertyValue("email"))) {
				val nuevoDuenio = new Usuario => [
					email = body.getPropertyValue("email")
					nombre = body.getPropertyValue("nombre")
					apellido = body.getPropertyValue("apellido")
					password = body.getPropertyValue("password")
					fechaAlta = LocalDate.now
					activo = true
					tipoPerfil = Duenio.instance
					calificacion = 5.0
				]
				repoUsuario.create(nuevoDuenio)
				return ok()
			} else {
				throw new Exception("Ya existe un usuario con ese correo")
			}
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/createPaseador")
	def crearPaseador(@Body String body) {
		try {
			if (repoUsuario.validarCreate(body.getPropertyValue("email"))) {
				val nuevoPaseador = new Usuario => [
					email = body.getPropertyValue("email")
					nombre = body.getPropertyValue("nombre")
					apellido = body.getPropertyValue("apellido")
					password = body.getPropertyValue("password")
					fechaAlta = LocalDate.now
					activo = true
					tipoPerfil = Paseador.instance
					calificacion = 5.0
				]
				repoUsuario.create(nuevoPaseador)
				return ok()
			}
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// ABM PERFIL                                                                     //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/usuario/perfil/completarPerfil/:id")
	def completarPerfil(@Body String body) {
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
			usuario.apodo = body.getPropertyValue("apodo")
			usuario.fechaNacimiento = body.getPropertyAsDate("fechaNacimiento", "dd/MM/yyyy")
			usuario.dni = Integer.parseInt(body.getPropertyValue("dni"))
			usuario.telefono = body.getPropertyValue("telefono")
			usuario.direccion = body.getPropertyValue("direccion")
			usuario.imagenPerfil = body.getPropertyValue("imagen")
			repoUsuario.update(usuario)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Delete("/usuario/perfil/deshabilitarPerfil/:id")
	def deshabilitarPerfil() {
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
			usuario.deshabilitarPerfil
			repoUsuario.update(usuario)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}
	
	@Post("/usuario/perfil/cargarImagen/:id")
	def cargarImagenAlUsuario(@Body String body) {
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
			usuario.imagenPerfil = body.getPropertyValue("imagen")
			repoUsuario.update(usuario)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}
	
	@Get("/usuario/perfil/dameImagen/:id")
	def dameImagenPerfilUsuario() {
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
			return ok(usuario.imagenPerfil.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// ABMC PERROS                                                                    //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/perros/crearPerro/:idUser")
	def crearPerro(@Body String body) {
		try {
			val razaPerro = repoRaza.searchByID(parserStringToLong.parsearDeStringALong(body.getPropertyValue("raza")))
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(idUser))
			val nuevoPerro = new Perro => [
				nombre = body.getPropertyValue("nombre")
				cuidadosEspeciales = body.getPropertyValue("cuidadosEspeciales")
				descripcion = body.getPropertyValue("descripcion")
				enfermedadesPrevias = body.getPropertyValue("enfermedadesPrevias")
				fechaNacimiento = body.getPropertyAsDate("fechaNacimiento", "dd/MM/yyyy")
				desparasitado = Boolean.parseBoolean(body.getPropertyValue("desparasitado"))
				paseoAlgunaVez = Boolean.parseBoolean(body.getPropertyValue("paseoAlgunaVez"))
				imagenLibretaVacunacion = body.getPropertyValue("imagenLibretaVacunacion")
				imagen = body.getPropertyValue("imagen")
				paseoConUnPaseador = Boolean.parseBoolean(body.getPropertyValue("paseoConUnPaseador"))
				paseaFrecuente = Boolean.parseBoolean(body.getPropertyValue("paseaFrecuente"))
				paseoConOtrosPerros = Boolean.parseBoolean(body.getPropertyValue("paseoConOtrosPerros"))
				raza = razaPerro
				poseeLibretaSanitaria = Boolean.parseBoolean(body.getPropertyValue("poseeLibretaSanitaria"))
				vacunaDeLaRabia = Boolean.parseBoolean(body.getPropertyValue("vacunaDeLaRabia"))
				activo = true
			]
			usuario.agregarPerro(nuevoPerro)
			repoPerro.create(nuevoPerro)
			repoUsuario.update(usuario)

			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/perros/modificarPerro/:id")
	def modificarPerro(@Body String body) {
		try {
			val perro = repoPerro.searchByID(parserStringToLong.parsearDeStringALong(id))
			val razaPerro = repoRaza.searchByID(parserStringToLong.parsearDeStringALong(body.getPropertyValue("raza")))
			perro.nombre = body.getPropertyValue("nombre")
			perro.raza = razaPerro
			perro.imagen = body.getPropertyValue("imagen")
			perro.fechaNacimiento = body.getPropertyAsDate("fechaNacimiento", "dd/MM/yyyy")
			perro.poseeLibretaSanitaria = Boolean.parseBoolean(body.getPropertyValue("poseeLibretaSanitaria"))
			perro.imagenLibretaVacunacion = body.getPropertyValue("imagenLibretaVacunacion")
			perro.vacunaDeLaRabia = Boolean.parseBoolean(body.getPropertyValue("vacunaDeLaRabia"))
			perro.desparasitado = Boolean.parseBoolean(body.getPropertyValue("desparasitado"))
			perro.enfermedadesPrevias = body.getPropertyValue("enfermedadesPrevias")
			perro.paseaFrecuente = Boolean.parseBoolean(body.getPropertyValue("paseaFrecuente"))
			perro.paseoAlgunaVez = Boolean.parseBoolean(body.getPropertyValue("paseoAlgunaVez"))
			perro.paseoConUnPaseador = Boolean.parseBoolean(body.getPropertyValue("paseoConUnPaseador"))
			perro.paseoConOtrosPerros = Boolean.parseBoolean(body.getPropertyValue("paseoConOtrosPerros"))
			perro.descripcion = body.getPropertyValue("descripcion")
			perro.cuidadosEspeciales = body.getPropertyValue("cuidadosEspeciales")

			repoPerro.update(perro)

			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Delete("/perros/deshabilitarPerro/:id")
	def deshabilitarPerro() {
		try {
			val perro = repoPerro.searchByID(parserStringToLong.parsearDeStringALong(id))
			perro.deshabilitarPerro
			repoPerro.update(perro)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/perros/:id")
	def dameElPerro() {
		try {
			val perro = repoPerro.searchByID(parserStringToLong.parsearDeStringALong(id))
			perro.fechaNacimiento = perro.fechaNacimiento.plusDays(1)
			return ok(perro.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/usuario/perros/:idUser")
	def perrosDelUsuario() {
		try {
			val perrosDelUsuario = repoUsuario.usuarioConFetchDePerros(parserStringToLong.parsearDeStringALong(idUser)).
				perros
			val perrosFiltrados = perrosDelUsuario.filter[perro|perro.activo].toList
			return ok(perrosFiltrados.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}
	
	@Post("/perros/cargarImagen/:id")
	def cargarImagenAlPerro(@Body String body) {
		try {
			val perro = repoPerro.searchByID(parserStringToLong.parsearDeStringALong(id))
			perro.imagen = body.getPropertyValue("imagen")
			repoPerro.update(perro)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}
	
	@Get("/perros/dameImagen/:id")
	def dameImagenPerfilPerro() {
		try {
			val perro = repoPerro.searchByID(parserStringToLong.parsearDeStringALong(id))
			return ok(perro.imagen.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// GET RAZAS                                                                      //
	// /////////////////////////////////////////////////////////////////////////////////
	@Get("/razas")
	def dameTodasLasRazas() {
		try {
			val razas = repoRaza.allInstances
			return ok(razas.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// ABMC AVISOS                                                                    //
	// /////////////////////////////////////////////////////////////////////////////////
	@Get("/usuario/avisos/:idUser")
	def avisosDelUsuario() {
		try {
			val avisosDelUsuario = repoUsuario.usuarioConFetchDePerros(parserStringToLong.parsearDeStringALong(idUser)).
				avisos
			val avisosFiltrados = avisosDelUsuario.filter[aviso|aviso.activo].toList
			avisosFiltrados.forEach[aviso|aviso.fecha = aviso.fecha.plusDays(1)]
			println(avisosFiltrados.toJson)
			return ok(avisosFiltrados.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/usuario/traerUnAviso/:idAviso")
	def dameUnAviso() {
		try {
			val aviso = repoAviso.searchByID(Long.parseLong(idAviso))
			aviso.fecha = aviso.fecha.plusDays(1)
			return ok(aviso.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/avisos/crearAviso/:idUser")
	def crearAviso(@Body String body) {
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(idUser))
			val idPerroValidado = repoPerro.validarIdPerro(body.getPropertyValue("idPerro"))
			val nuevoAviso = new Aviso => [
				recurrente = Boolean.parseBoolean(body.getPropertyValue("recurrente"))
				lunes = Boolean.parseBoolean(body.getPropertyValue("lunes"))
				martes = Boolean.parseBoolean(body.getPropertyValue("martes"))
				miercoles = Boolean.parseBoolean(body.getPropertyValue("miercoles"))
				jueves = Boolean.parseBoolean(body.getPropertyValue("jueves"))
				viernes = Boolean.parseBoolean(body.getPropertyValue("viernes"))
				sabado = Boolean.parseBoolean(body.getPropertyValue("sabado"))
				domingo = Boolean.parseBoolean(body.getPropertyValue("domingo"))
				fechaParticular = Boolean.parseBoolean(body.getPropertyValue("fechaparticular"))
				fecha = body.getPropertyAsDate("fecha", "dd/MM/yyyy")
				horario = LocalTime.parse(body.getPropertyValue("horario"))
				detalle = body.getPropertyValue("detalle")
				activo = true
				tipoServicio = repoTipoServicio.searchByID(Long.parseLong(body.getPropertyValue("tipoServicio")))
				idPerro = idPerroValidado
				if(body.getPropertyValue("precio")!==null){
					precio = Double.parseDouble(body.getPropertyValue("precio"))
				} else{
					precio=tipoServicio.precioStandard
				}
				
			]
			println("TIPO DE SERVICIOOOOOOOOOOOOOO" + nuevoAviso.tipoServicio.toJson)
			usuario.agregarAviso(nuevoAviso)
			repoAviso.create(nuevoAviso)
			repoUsuario.update(usuario)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/avisos/modificarAviso/:idAviso")
	def modificarAviso(@Body String body) {
		try {
			val idPerroValidado = repoPerro.validarIdPerro(body.getPropertyValue("idPerro"))
			val avisoAEditar = repoAviso.searchByID(Long.parseLong(idAviso))
			avisoAEditar.recurrente = Boolean.parseBoolean(body.getPropertyValue("recurrente"))
			avisoAEditar.lunes = Boolean.parseBoolean(body.getPropertyValue("lunes"))
			avisoAEditar.martes = Boolean.parseBoolean(body.getPropertyValue("martes"))
			avisoAEditar.miercoles = Boolean.parseBoolean(body.getPropertyValue("miercoles"))
			avisoAEditar.jueves = Boolean.parseBoolean(body.getPropertyValue("jueves"))
			avisoAEditar.viernes = Boolean.parseBoolean(body.getPropertyValue("viernes"))
			avisoAEditar.sabado = Boolean.parseBoolean(body.getPropertyValue("sabado"))
			avisoAEditar.domingo = Boolean.parseBoolean(body.getPropertyValue("domingo"))
			avisoAEditar.fechaParticular = Boolean.parseBoolean(body.getPropertyValue("fechaparticular"))
			avisoAEditar.fecha = body.getPropertyAsDate("fecha", "dd/MM/yyyy")
			avisoAEditar.horario = LocalTime.parse(body.getPropertyValue("horario"))
			avisoAEditar.detalle = body.getPropertyValue("detalle")
			avisoAEditar.activo = true
			avisoAEditar.tipoServicio = repoTipoServicio.tipoDeServicio(body.getPropertyValue("tipoServicio"))
			avisoAEditar.idPerro = idPerroValidado
			avisoAEditar.precio = Double.parseDouble(body.getPropertyValue("precio"))
			repoAviso.update(avisoAEditar)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Delete("/usuario/eliminarAviso/:idAviso")
	def deshabilitarAviso() {
		try {
			val aviso = repoAviso.searchByID(Long.parseLong(idAviso))
			aviso.finalizarAviso
			repoAviso.update(aviso)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/avisos/traerTodosLosAvisos")
	def dameTodosLosAvisos() {
		try {
			val avisos = repoAviso.avisosActivos
			avisos.forEach[aviso|aviso.fecha = aviso.fecha.plusDays(1)]
			return ok(avisos.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// ABMC SERVICIOS                                                                 //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/usuario/servicios/contratarPaseo")
	def crearServicio(@Body String body) {
		try {
			val avisoADarDeBaja = repoAviso.searchByID(Long.parseLong(body.getPropertyValue("idAviso")))
			val contratante = repoUsuario.searchByID(Long.parseLong(body.getPropertyValue("idContratante")))
			val idPerroValidado = repoPerro.validarIdPerro(body.getPropertyValue("idPerro"))
			val precioServicio = Double.parseDouble(body.getPropertyValue("precio"))
			val publicante = repoUsuario.searchByID(repoUsuario.idUsuarioDelAviso(avisoADarDeBaja.idAviso))
			val nuevoServicio = new Servicio => [
				idPerro = idPerroValidado
				activo = true
				fechaRealizacion = avisoADarDeBaja.fecha
				horario = avisoADarDeBaja.horario
				pago = false
				calificacionDuenio = null
				calificacionPrestador = null
				tipoServicio = ServicioPaseo.instance
				idDuenio = publicante.idUsuario.toString // TODO:Cuando los paseadores puedan publicar esto hay que cambiarlo
				idPrestador = contratante.idUsuario.toString
				precio=precioServicio
			]
			avisoADarDeBaja.finalizarAviso
			contratante.agregarServicio(nuevoServicio)
			println(contratante.servicios)
			publicante.agregarServicio(nuevoServicio)
			repoAviso.update(avisoADarDeBaja)
			repoServicio.create(nuevoServicio)
			repoUsuario.update(contratante)
			repoUsuario.update(publicante)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/servicios/finalizarServicio/:idServicio")
	def finalizarServicio(@Body String body) {
		try {
			val serviciofinalizado = repoServicio.searchByID(Long.parseLong(idServicio))
			serviciofinalizado.finalizarServicio
			repoServicio.update(serviciofinalizado)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// Ver Servicio Actual
	@Get("/usuario/serviciosActualesDelUsuario/:idUsuario")
	def serviciosActualesDelUsuario() {
		try {
			val serviciosDelUsuario = repoUsuario.usuarioConFetchDePerros(
				parserStringToLong.parsearDeStringALong(idUsuario)).servicios
			val serviciosFiltrados = serviciosDelUsuario.filter[servicio|servicio.activo].toList
			serviciosFiltrados.forEach[servicio|servicio.fechaRealizacion = servicio.fechaRealizacion.plusDays(1)]
			return ok(serviciosFiltrados.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// Historial De Servicios
	@Get("/usuario/historialDeServicios/:idUsuario")
	def historialDeServicios() {
		try {
			val serviciosDelUsuario = repoUsuario.usuarioConFetchDePerros(
				parserStringToLong.parsearDeStringALong(idUsuario)).servicios
			val serviciosFiltrados = serviciosDelUsuario.filter[servicio|!servicio.activo].toList
			serviciosFiltrados.forEach[servicio|servicio.fechaRealizacion = servicio.fechaRealizacion.plusDays(1)]
			return ok(serviciosFiltrados.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/usuario/traerUnServicio/:idServicio")
	def dameUnServicio() {
		try {
			val servicio = repoServicio.searchByID(Long.parseLong(idServicio))
			servicio.fechaRealizacion = servicio.fechaRealizacion.plusDays(1)
			return ok(servicio.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// CALIFICAR SERVICIO                                                             //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/servicios/calificarAlDuenio")
	def calificarServicioDuenio(@Body String body) {
		try {
			val servicioACalificar = repoServicio.searchByIDSinWhereDeActivo(
				Long.parseLong(body.getPropertyValue("idServicio")))
			servicioACalificar.calificacionDuenio = Double.parseDouble(body.getPropertyValue("calificacion"))
			repoServicio.update(servicioACalificar)
			val duenio = repoUsuario.searchByID(Long.parseLong(servicioACalificar.idDuenio))
			duenio.actualizarCalificacion(servicioACalificar)
			repoUsuario.update(duenio)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/servicios/calificarAlPrestador")
	def calificarServicioPrestador(@Body String body) {
		try {
			val servicioACalificar = repoServicio.searchByIDSinWhereDeActivo(
				Long.parseLong(body.getPropertyValue("idServicio")))
			servicioACalificar.calificacionPrestador = Double.parseDouble(body.getPropertyValue("calificacion"))
			repoServicio.update(servicioACalificar)
			val prestador = repoUsuario.searchByID(Long.parseLong(servicioACalificar.idPrestador))
			prestador.actualizarCalificacion(servicioACalificar)
			repoUsuario.update(prestador)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// GEOLOCALIZACION                                                                //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/servicios/geolocalizacionDuenio")
	def establecerUbicacionDuenio(@Body String body) {
		try {
			val servicioAEstablecerGPS = repoServicio.searchByID(Long.parseLong(body.getPropertyValue("idServicio")))
			servicioAEstablecerGPS.latitudDuenio = body.getPropertyValue("lat")
			servicioAEstablecerGPS.longitudDuenio = body.getPropertyValue("lng")
			repoServicio.update(servicioAEstablecerGPS)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/servicios/geolocalizacionPrestador")
	def establecerUbicacionPrestador(@Body String body) {
		try {
			val servicioAEstablecerGPS = repoServicio.searchByID(Long.parseLong(body.getPropertyValue("idServicio")))
			servicioAEstablecerGPS.latitudPrestador = body.getPropertyValue("lat")
			servicioAEstablecerGPS.longitudPrestador = body.getPropertyValue("lng")
			repoServicio.update(servicioAEstablecerGPS)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/servicios/getGPSDuenio/:idServicio")
	def dameUbicacionDuenio() {
		try {
			val servicio = repoServicio.searchByID(Long.parseLong(idServicio))
			return ok(GpsSerializerDuenio.toJson(servicio))
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/servicios/getGPSPrestador/:idServicio")
	def dameUbicacionPrestador() {
		try {
			val servicio = repoServicio.searchByID(Long.parseLong(idServicio))
			return ok(GpsSerializerPrestador.toJson(servicio))
		} catch (UserException exception) {
			return badRequest()
		}
	}

}

@Accessors
class UsuarioLogeadoRequest {
	String usuario
	String password
}
