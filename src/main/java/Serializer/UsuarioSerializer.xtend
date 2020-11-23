package Serializer

import Clases.Usuario
import ParserStringToLong.ParserStringToLong
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import java.time.format.DateTimeFormatter
import java.time.LocalDate

class UsuarioSerializer extends StdSerializer<Usuario> {
	new(Class<Usuario> s) {
		super(s)
	}

	static ParserStringToLong parserStringToLong = ParserStringToLong.instance

	static val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")

	static def getStringDateFromLocalDate(LocalDate date) { date.format(formatter) }

	override serialize(Usuario value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject();
		gen.writeStringField("id", parserStringToLong.parsearDeLongAString(value.idUsuario));
		gen.writeStringField("email", value.email);
		gen.writeStringField("nombre", value.nombre);
		gen.writeStringField("apellido", value.apellido);
		gen.writeStringField("apodo", value.apodo);
		gen.writeStringField("fechaAlta", getStringDateFromLocalDate(value.fechaAlta));
		
		if(value.imagenPerfil !== null){
			gen.writeStringField("imagenPerfil", value.imagenPerfil)
			
		} else {
			gen.writeStringField("fechaNacimiento","https://lh3.googleusercontent.com/proxy/VkIjNMnPeXHIeLkARjmhlfA1s4AnWWbhiduH5vyN-389-gGXOBi1ZclPY6u5Sh_1ls56_8UDmFhuACcxMkkfjDL8TAMhfB5yhPd5DsZMgBGVg1B88_oVqzLR_AYHGmKZ")
		}
	
		if (value.fechaNacimiento !== null) {
			gen.writeStringField("fechaNacimiento", getStringDateFromLocalDate(value.fechaNacimiento));
		} else {
			gen.writeStringField("fechaNacimiento",null)
		}
		if (value.dni !== null) {
			gen.writeStringField("dni", value.dni.toString);
		} else {
			gen.writeStringField("dni", null)
		}
		gen.writeStringField("telefono", value.telefono);
		gen.writeStringField("direccion", value.direccion);
		gen.writeStringField("tipoPerfil", value.tipoPerfil.nombrePerfil)
		gen.writeStringField("calificacion", value.calificacion.toString)
		gen.writeEndObject();
	}

	static def String toJson(Usuario usuario) {
		if (usuario === null) {
			return "[ ]"
		}
		mapper().writeValueAsString(usuario)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Usuario, new UsuarioSerializer(Usuario))
		mapper.registerModule(module)
		mapper
	}
}
