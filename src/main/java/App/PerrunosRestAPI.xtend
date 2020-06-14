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
import Clases.Raza
import Repositorio.RepositorioPerros
import org.hibernate.query.criteria.internal.expression.SearchedCaseExpression.WhenClause
import Repositorio.RepositorioRazas

@Controller			//maneja las llamadas post, etc
class PerrunosRestAPI {

	extension JSONUtils = new JSONUtils		//permite combertir a json y diceversa (serializar y deserealizar)
	RepositorioUsuario repoUsuario = new RepositorioUsuario	
	RepositorioPerros repoPerro = new RepositorioPerros
	RepositorioRazas repoRaza = new RepositorioRazas

	static ParserStringToLong parserStringToLong = ParserStringToLong.instance	//los ID en hibernate son de tipo long o inter y los pasamos a tipo string

	new() {
	}

	// /////////////////////////////////////////////////////////////////////////////////
	// LOGIN                                                                          //
	// /////////////////////////////////////////////////////////////////////////////////
	@Post("/usuario/login")						//te permite enviar un body de json sin que se vea en la direccion esto te lo envia el front, envia informa y espera respuesta
	def login(@Body String body) {				
		try {
			val usuarioLogeadoBody = body.fromJson(UsuarioLogeadoRequest) 	//fromJson deserealiza de json a tipo objeto y trae el usaurio y contrasenia
			try {
				val usuarioLogeado = this.repoUsuario.verificarLogin(usuarioLogeadoBody.usuario,
					usuarioLogeadoBody.password)
				return ok(usuarioLogeado.idUsuario.toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {		//el segundo sirve por si se trata de asignar una propiedad objeto por otro medio como constructor
			return badRequest()
		}
	}

	@Get("/usuario/:id")						//busca informacion en el back
	def dameUsuario() {
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
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
			val nuevoDuenio = new Usuario => [
				email = body.getPropertyValue("email")
				nombre = body.getPropertyValue("nombre")
				apellido = body.getPropertyValue("apellido")
				password = body.getPropertyValue("password")
				fechaAlta = LocalDate.now
				activo = true
				tipoPerfil = Duenio.instance
			]
			repoUsuario.create(nuevoDuenio)
			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

	@Post("/usuario/createPaseador")
	def crearPaseador(@Body String body) {
		try {
			val nuevoPaseador = new Usuario => [
				email = body.getPropertyValue("email")
				nombre = body.getPropertyValue("nombre")
				apellido = body.getPropertyValue("apellido")
				password = body.getPropertyValue("password")
				fechaAlta = LocalDate.now
				activo = true
				tipoPerfil = Paseador.instance
			]
			repoUsuario.create(nuevoPaseador)
			return ok()
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
			usuario.fechaNacimiento = body.getPropertyAsDate("fechaNacimiento", "dd/MM/yyyy")
			usuario.dni = Integer.parseInt(body.getPropertyValue("dni"))
			usuario.telefono = body.getPropertyValue("telefono")
			usuario.direccion = body.getPropertyValue("direccion")
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
				raza = razaPerro
				imagen = body.getPropertyValue("imagen")
				fechaNacimiento = body.getPropertyAsDate("fechaNacimiento", "dd/MM/yyyy")
				poseeLibretaSanitaria = Boolean.parseBoolean(body.getPropertyValue("poseeLibretaSanitaria"))
				imagenLibretaVacunacion = body.getPropertyValue("imagenLibretaVacunacion")
				vacunaDeLaRabia = Boolean.parseBoolean(body.getPropertyValue("vacunaDeLaRabia"))
				desparasitado = Boolean.parseBoolean(body.getPropertyValue("desparasitado"))
				enfermedadesPrevias = body.getPropertyValue("enfermedadesPrevias")
				paseaFrecuente = Boolean.parseBoolean(body.getPropertyValue("paseaFrecuente"))
				paseoAlgunaVez = Boolean.parseBoolean(body.getPropertyValue("paseoAlgunaVez"))
				paseoConUnPaseador = Boolean.parseBoolean(body.getPropertyValue("paseoConUnPaseador"))
				paseoConOtrosPerros = Boolean.parseBoolean(body.getPropertyValue("paseoConOtrosPerros"))
			]
			usuario.agregarPerro(nuevoPerro)
			repoPerro.create(nuevoPerro)
			repoUsuario.update(usuario)

			return ok()
		} catch (UserException exception) {
			return badRequest()
		}
	}

// TODO:GETRAZA
}

@Accessors
class UsuarioLogeadoRequest {
	String usuario
	String password
}
