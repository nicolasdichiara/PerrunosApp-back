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
	//                            REGISTRO USUARIO                                   //
	///////////////////////////////////////////////////////////////////////////////////
	
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
	
	///////////////////////////////////////////////////////////////////////////////////
	//                            ABM PERFIL                                         //
	///////////////////////////////////////////////////////////////////////////////////
	
	@Post("/usuario/perfil/completarPerfil/:id")
	def completarPerfil(@Body String body){
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
			usuario.fechaNacimiento = body.getPropertyAsDate("fechaNacimiento","dd/MM/yyyy")
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
	def deshabilitarPerfil(){
		try {
			val usuario = repoUsuario.searchByID(parserStringToLong.parsearDeStringALong(id))
			usuario.deshabilitarPerfil
			repoUsuario.update(usuario)
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
