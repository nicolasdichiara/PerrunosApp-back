package App

import Clases.Aviso
import Clases.Duenio
import Clases.Paseador
import Clases.Perro
import Clases.Servicio
import Clases.Usuario
import ParserStringToLong.ParserStringToLong
import Repositorio.RepositorioAvisos
import Repositorio.RepositorioPerros
import Repositorio.RepositorioRazas
import Repositorio.RepositorioServicio
import Repositorio.RepositorioTipoServicio
import Repositorio.RepositorioUsuario
import Serializer.GpsSerializerDuenio
import Serializer.GpsSerializerPrestador
import Serializer.UsuarioSerializer
import com.fasterxml.jackson.databind.exc.UnrecognizedPropertyException
import java.time.LocalDate
import java.time.LocalTime
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.exceptions.UserException
import org.uqbar.xtrest.api.annotation.Body
import org.uqbar.xtrest.api.annotation.Controller
import org.uqbar.xtrest.api.annotation.Delete
import org.uqbar.xtrest.api.annotation.Get
import org.uqbar.xtrest.api.annotation.Post
import org.uqbar.xtrest.json.JSONUtils
import Repositorio.RepositorioPagos
import Clases.Promocion
import Repositorio.RepositorioPromociones
import Repositorio.RepositorioPerfil
import Repositorio.RepositorioZonas
import Repositorio.ServicioConUsuario
import java.util.List

@Controller //maneja las llamadas post, etc
class PerrunosRestAPI {

	extension JSONUtils = new JSONUtils // permite combertir a json y diceversa (serializar y deserealizar)
	RepositorioUsuario repoUsuario = new RepositorioUsuario
	RepositorioPerros repoPerro = new RepositorioPerros
	RepositorioRazas repoRaza = new RepositorioRazas
	RepositorioAvisos repoAviso = new RepositorioAvisos
	RepositorioServicio repoServicio = new RepositorioServicio
	RepositorioTipoServicio repoTipoServicio = new RepositorioTipoServicio
	RepositorioPagos repoPagoServicio = new RepositorioPagos
	RepositorioPromociones repoPromociones = new RepositorioPromociones
	RepositorioPerfil repoPerfil = new RepositorioPerfil
	RepositorioZonas repoZonas = new RepositorioZonas

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
				// usuarioLogeado.fechaNacimiento.plusDays(1)
				return ok(UsuarioSerializer.toJson(usuarioLogeado))
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) { // el segundo sirve por si se trata de asignar una propiedad objeto por otro medio como constructor
			return badRequest()
		}
	} // OK

	@Get("/usuario/:id") // busca informacion en el back
	def dameUsuario() {
		try {
			val usuario = repoUsuario.searchByID(Long.parseLong(id))
			usuario.fechaAlta.plusDays(1)
			// usuario.fechaAlta = usuario.fechaNacimiento.plusDays(1)
			return ok(UsuarioSerializer.toJson(usuario))

		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// REGISTRO USUARIO                                                               //
	// /////////////////////////////////////////////////////////////////////////////////
	@Get("/perfiles")
	def getTodosLosPerfiles() {
		try {
			val perfiles = repoPerfil.allInstances.filter[perfil|!perfil.nombrePerfil.equals("Administrador")].toList
			println(perfiles)
			return ok(perfiles.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

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
			} else {
				throw new Exception("Ya existe un usuario con ese correo")
			}
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/createUsuario") // TODO:ESTE ES EL POSTA
	def crearUsuario(@Body String body) {
		try {
			val tipoDePerfil = repoPerfil.searchByID(Long.parseLong(body.getPropertyValue("tipo")))
			if (repoUsuario.validarCreate(body.getPropertyValue("email"))) {
				val nuevoUsuario = new Usuario => [
					email = body.getPropertyValue("email")
					nombre = body.getPropertyValue("nombre")
					apellido = body.getPropertyValue("apellido")
					password = body.getPropertyValue("password")
					fechaAlta = LocalDate.now
					activo = true
					tipoPerfil = tipoDePerfil
					calificacion = 5.0
				]
				println(nuevoUsuario.tipoPerfil)
				repoUsuario.create(nuevoUsuario)
				return ok()
			} else {
				throw new Exception("Ya existe un usuario con ese correo")
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
			val usuario = repoUsuario.usuarioConFetchDePerros(parserStringToLong.parsearDeStringALong(idUser))
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
	// ZONAS			                                                              //
	// /////////////////////////////////////////////////////////////////////////////////
	@Get("/zonas")
	def dameTodasLasZonas() {
		try {
			val zonas = repoZonas.allInstances
			return ok(zonas.toJson)
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
			val avisosDelUsuario = repoUsuario.usuarioConFetchDeAvisos(parserStringToLong.parsearDeStringALong(idUser)).
				avisos
			val avisosFiltrados = avisosDelUsuario.filter[aviso|aviso.activo].toList
			avisosFiltrados.forEach[aviso|aviso.fechaPublicacion = aviso.fechaPublicacion.plusDays(1)]
			avisosFiltrados.forEach[aviso|aviso.usuarioPublicante = null]
			return ok(avisosFiltrados.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/usuario/traerUnAviso/:idAviso")
	def dameUnAviso() {
		try {
			val aviso = repoAviso.avisoPorIdConUsuario(Long.parseLong(idAviso))
			aviso.fechaPublicacion = aviso.fechaPublicacion.plusDays(1)
			return ok(aviso.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/avisos/crearAviso/:idUser")
	def crearAviso(@Body String body) {
		try {
			val usuario = repoUsuario.usuarioConFetchDeAvisos(parserStringToLong.parsearDeStringALong(idUser))
			val zonaElegida = repoZonas.searchByID(Long.parseLong(body.getPropertyValue("zona")))
			val nuevoAviso = new Aviso => [
				fechaPublicacion = LocalDate.now
				horario = body.getPropertyValue("horario")
				detalle = body.getPropertyValue("detalle")
				activo = true
				precio = Double.parseDouble(body.getPropertyValue("precio"))
				tipoServicio = repoTipoServicio.searchByID(Long.parseLong(body.getPropertyValue("tipoServicio")))
				lunes = Boolean.parseBoolean(body.getPropertyValue("lunes"))
				martes = Boolean.parseBoolean(body.getPropertyValue("martes"))
				miercoles = Boolean.parseBoolean(body.getPropertyValue("miercoles"))
				jueves = Boolean.parseBoolean(body.getPropertyValue("jueves"))
				viernes = Boolean.parseBoolean(body.getPropertyValue("viernes"))
				sabado = Boolean.parseBoolean(body.getPropertyValue("sabado"))
				domingo = Boolean.parseBoolean(body.getPropertyValue("domingo"))
				zona = zonaElegida
				usuarioPublicante = usuario
			]
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
			println("AVISO: " + repoAviso.searchByID(Long.parseLong(idAviso)))
			val avisoAEditar = repoAviso.searchByID(Long.parseLong(idAviso))
			val zonaElegida = repoZonas.searchByID(Long.parseLong(body.getPropertyValue("zona")))
			avisoAEditar.horario = body.getPropertyValue("horario")
			avisoAEditar.detalle = body.getPropertyValue("detalle")
			avisoAEditar.precio = Double.parseDouble(body.getPropertyValue("precio"))
			avisoAEditar.lunes = Boolean.parseBoolean(body.getPropertyValue("lunes"))
			avisoAEditar.martes = Boolean.parseBoolean(body.getPropertyValue("martes"))
			avisoAEditar.miercoles = Boolean.parseBoolean(body.getPropertyValue("miercoles"))
			avisoAEditar.jueves = Boolean.parseBoolean(body.getPropertyValue("jueves"))
			avisoAEditar.viernes = Boolean.parseBoolean(body.getPropertyValue("viernes"))
			avisoAEditar.sabado = Boolean.parseBoolean(body.getPropertyValue("sabado"))
			avisoAEditar.domingo = Boolean.parseBoolean(body.getPropertyValue("domingo"))
			avisoAEditar.zona = zonaElegida
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
			val avisos = repoAviso.avisosActivosConUsuario
			avisos.forEach[aviso|aviso.fechaPublicacion = aviso.fechaPublicacion.plusDays(1)]
			return ok(avisos.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/usuario/avisosContactados/:idUser")
	def getAvisosContactados() {
		try {
			val avisosDelUsuario = repoUsuario.usuarioConFetchDeAvisosContactados(
				parserStringToLong.parsearDeStringALong(idUser)).avisosContactados
			val avisosFiltrados = avisosDelUsuario.filter[aviso|aviso.activo].toList
			avisosFiltrados.forEach[aviso|aviso.fechaPublicacion = aviso.fechaPublicacion.plusDays(1)]
			avisosFiltrados.forEach[aviso|aviso.usuarioPublicante = null]
			return ok(avisosFiltrados.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/contactarAviso")
	def contactarAviso(@Body String body) {
		try {
			var usuario = repoUsuario.usuarioConFetchDeAvisosContactados(
				Long.parseLong(body.getPropertyValue("idUser")))
			val aviso = repoAviso.searchByID(Long.parseLong(body.getPropertyValue("idAviso")))
			if (!usuario.avisosContactados.exists[avs|avs.idAviso == aviso.idAviso]) {
				usuario.avisosContactados.add(aviso)
			}
			repoUsuario.update(usuario)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/eliminarAvisoContactado")
	def quitarAvisoContactado(@Body String body) {
		try {
			var usuario = repoUsuario.usuarioConFetchDeAvisosContactados(
				Long.parseLong(body.getPropertyValue("idUser")))
			val aviso = repoAviso.searchByID(Long.parseLong(body.getPropertyValue("idAviso")))
			usuario.avisosContactados.remove(usuario.avisosContactados.findFirst[avs|avs.idAviso == aviso.idAviso])
			repoUsuario.update(usuario)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// ABMC SERVICIOS                                                                 //
	// /////////////////////////////////////////////////////////////////////////////////
	@Get("/servicios/tiposDeServicio")
	def getTiposDeServicios() {
		try {
			val tiposDeServicios = repoTipoServicio.allInstances
			return ok(tiposDeServicios.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/servicios/tiposDeServicio/:id")
	def getTiposDeServicios() {
		try {
			val tipoDeServicio = repoTipoServicio.searchByID(Long.parseLong(id))
			return ok(tipoDeServicio.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/servicios/tiposDeServicioPorUsuario/:id")
	def getTiposDeServiciosPorUsuario() {
		try {
			val usuario = repoUsuario.searchByID(Long.parseLong(id))
			val tiposDeServicios = repoTipoServicio.searchByID(usuario.tipoPerfil.tipoServicio.idTipoServicio)
			return ok(tiposDeServicios.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/servicios/contratarPaseo")
	def crearServicio(@Body String body) {
		try {
			val tipo = repoTipoServicio.searchByID(Long.parseLong(body.getPropertyValue("tipo")))
			val aviso = repoAviso.searchByID(Long.parseLong(body.getPropertyValue("idAviso")))
			val contratante = repoUsuario.usuarioConFetchDeServicios(
				Long.parseLong(body.getPropertyValue("idContratante")))
			val publicante = repoUsuario.usuarioConFetchDeServicios(repoUsuario.idUsuarioDelAviso(aviso.idAviso))
			val nuevoServicio = new Servicio => [
				activo = true
				fechaRealizacion = LocalDate.now
//				pago = false
				horario = LocalTime.now
				calificacionDuenio = null
				calificacionPrestador = null
				tipoServicio = tipo
				duenio = contratante
				prestador = publicante
				precio = aviso.precio
			]
			contratante.agregarServicio(nuevoServicio)
			publicante.agregarServicio(nuevoServicio)
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
	@Get("/usuario/serviciosActualesDelUsuario/:idUsuario") // TODO YA FUNCA
	def serviciosActualesDelUsuario() {
		try {
			val usuario = repoUsuario.usuarioConFetchDeServicios(Long.parseLong(idUsuario))
			var List<ServicioConUsuario> serviciosDelUsuario
			if (usuario.tipoPerfil.nombrePerfil == 'Duenio') {
				serviciosDelUsuario = repoServicio.
					serviciosActivosDelDuenioConUsuarios(usuario.idUsuario, 'serv.duenio')
			} else {
				serviciosDelUsuario = repoServicio.serviciosActivosDelDuenioConUsuarios(usuario.idUsuario,
					'serv.prestador')
			}
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
		val usuario = repoUsuario.usuarioConFetchDeServicios(Long.parseLong(idUsuario))
			var List<ServicioConUsuario> serviciosDelUsuario
			if (usuario.tipoPerfil.nombrePerfil == 'Duenio') {
				serviciosDelUsuario = repoServicio.
					serviciosFinalizadosDelDuenioConUsuarios(usuario.idUsuario, 'serv.duenio')
			} else {
				serviciosDelUsuario = repoServicio.serviciosFinalizadosDelDuenioConUsuarios(usuario.idUsuario,
					'serv.prestador')
			}
			val serviciosFiltrados = serviciosDelUsuario.filter[servicio|!servicio.activo].toList
			serviciosFiltrados.forEach[servicio|servicio.fechaRealizacion = servicio.fechaRealizacion.plusDays(1)]
			return ok(serviciosFiltrados.toJson)
	}

	@Get("/usuario/traerUnServicio/:idServicio")
	def dameUnServicio() {
		try {
			val servicio = repoServicio.serviciosPorIdConUsuarios(Long.parseLong(idServicio))
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
			val duenio = repoUsuario.usuarioConFetchDeServicios(servicioACalificar.duenio.idUsuario)
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
			val prestador = repoUsuario.usuarioConFetchDeServicios(servicioACalificar.prestador.idUsuario)
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

	// /////////////////////////////////////////////////////////////////////////////////
	// PAGO DEL SEVICIO                                                               //
	// /////////////////////////////////////////////////////////////////////////////////
//	@Post("/servicios/pagarServicio")
//	def pagarServicio(@Body String body) {
//		try {
//			val servicioAPagar = repoServicio.searchByIDSinWhereDeActivo(
//				Long.parseLong(body.getPropertyValue("idServicio")))
//			val pagoServicioNuevo = new PagoServicio => [
//				collectionId = body.getPropertyValue("collection_id")
//				collectionStatus = body.getPropertyValue("collection_status")
//				paymentId = body.getPropertyValue("payment_id")
//				status = body.getPropertyValue("status")
//				externalReference = body.getPropertyValue("external_reference")
//				paymentType = body.getPropertyValue("payment_type")
//				merchantOrderId = body.getPropertyValue("merchant_order_id")
//				preferenceId = body.getPropertyValue("preference_id")
//				siteId = body.getPropertyValue("site_id")
//				processingMode = body.getPropertyValue("processing_mode")
//				merchantAccountId = body.getPropertyValue("merchant_account_id")
//			]
//			servicioAPagar.pago = true
//			servicioAPagar.pagarServicio(pagoServicioNuevo)
//			repoPagoServicio.create(pagoServicioNuevo)
//			repoServicio.update(servicioAPagar)
//			return ok()
//		} catch (UserException exception) {
//			return badRequest()
//		}
//	}
	// /////////////////////////////////////////////////////////////////////////////////
	// ABMC PROMOCIONES                                                               //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/promociones/crearPromocion")
	def crearPromocion(@Body String body) {
		try {
			val nuevaPromo = new Promocion => [
				imagenPromo = body.getPropertyValue("imagenPromo")
				fechaVigencia = body.getPropertyAsDate("fechaVigencia")
				activa = Boolean.parseBoolean(body.getPropertyValue("activa"))
			]
			repoPromociones.create(nuevaPromo)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/promociones/getTodasLasPromociones")
	def getTodasLasPromociones() {
		try {
			val promociones = repoPromociones.allInstances
			return ok(promociones.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Get("/promociones/getPromocion/:id")
	def getPromocion() {
		try {
			val promocion = repoPromociones.searchByID(Long.parseLong(id))
			return ok(promocion.toJson)
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/promociones/updatePromocion")
	def modificarPromocion(@Body String body) {
		try {
			val promocion = repoPromociones.searchByID(Long.parseLong(body.getPropertyValue("id")))
			promocion.imagenPromo = body.getPropertyValue("imagenPromo")
			promocion.fechaVigencia = body.getPropertyAsDate("fechaVigencia")
			promocion.activa = Boolean.parseBoolean(body.getPropertyValue("activa"))
			repoPromociones.update(promocion)
			return ok(promocion.toJson)
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
