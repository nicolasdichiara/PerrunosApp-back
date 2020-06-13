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

@Controller
class PerrunosRestAPI {

	extension JSONUtils = new JSONUtils
	RepositorioUsuario repoUsuario = new RepositorioUsuario

	static ParserStringToLong parserStringToLong = ParserStringToLong.instance

	new() {
	}

	///////////////////////////////////////////////////////////////////////////////////
	//                            LOGIN                                              //
	///////////////////////////////////////////////////////////////////////////////////
	@Post("/usuario/login")
	def login(@Body String body) {
		try {
			val usuarioLogeadoBody = body.fromJson(UsuarioLogeadoRequest)
			try {
				val usuarioLogeado = this.repoUsuario.verificarLogin(usuarioLogeadoBody.usuario,
					usuarioLogeadoBody.password)
				return ok(usuarioLogeado.idUsuario.toJson)
			} catch (UserException exception) {
				return badRequest()
			}
		} catch (UnrecognizedPropertyException exception) {
			return badRequest()
		}
	}

	@Get("/usuario/:id")
	def dameUsuario() {
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
			return ok(UsuarioSerializer.toJson(usuario))

		} catch (UserException exception) {
			return badRequest()
		}
	}
	
	///////////////////////////////////////////////////////////////////////////////////
	//                            ABM USUARIO                                        //
	///////////////////////////////////////////////////////////////////////////////////
	
	@Post("/usuario/createDuenio")
	def crearDuenio(@Body String body) {
		try {
			val nuevoDuenio = new Duenio => [
				username = body.getPropertyValue("username")
				password = body.getPropertyValue("password")
				fechaAlta = LocalDate.now
				nombre = body.getPropertyValue("nombre")
				apellido = body.getPropertyValue("apellido")
				fechaNacimiento = body.getPropertyAsDate("fechaNacimiento","dd/MM/yyyy")
				dni = Integer.parseInt(body.getPropertyValue("dni"))
				telefono = body.getPropertyValue("telefono")
				direccion = body.getPropertyValue("direccion")
				activo = true
				email = body.getPropertyValue("email")
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
			val nuevoPaseador = new Paseador => [
				username = body.getPropertyValue("username")
				password = body.getPropertyValue("password")
				fechaAlta = LocalDate.now
				nombre = body.getPropertyValue("nombre")
				apellido = body.getPropertyValue("apellido")
				fechaNacimiento = body.getPropertyAsDate("fechaNacimiento","dd/MM/yyyy")//LocalDate.of(1994, 11, 17)
				dni = Integer.parseInt(body.getPropertyValue("dni"))
				telefono = body.getPropertyValue("telefono")
				direccion = body.getPropertyValue("direccion")
				activo = true
				email = body.getPropertyValue("email")
			]
			println("el usuario nuevo es: " + nuevoPaseador.toJson)
			return ok()
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
