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

class UsuarioSerializer extends StdSerializer<Usuario>{
	new(Class<Usuario> s){
		super(s)
	}
	
	static ParserStringToLong parserStringToLong = ParserStringToLong.instance
	
	static val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")
	
	static def getStringDateFromLocalDate(LocalDate date) { 	date.format(formatter) 	}
	
	override serialize(Usuario value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject();
		gen.writeStringField("id", parserStringToLong.parsearDeLongAString(value.idUsuario));
		gen.writeStringField("email", value.email);
		gen.writeStringField("nombre", value.nombre);
		gen.writeStringField("apellido", value.apellido);
		gen.writeStringField("fechaAlta", getStringDateFromLocalDate(value.fechaAlta));
		gen.writeStringField("fechaNacimiento", getStringDateFromLocalDate(value.fechaNacimiento));
		gen.writeStringField("dni", value.dni.toString);
		gen.writeStringField("telefono", value.telefono);
		gen.writeStringField("direccion", value.direccion);
		gen.writeEndObject();
	}
	
	static def String toJson(Usuario usuario) {
		if(usuario === null){return "[ ]"}
		mapper().writeValueAsString(usuario)
	}
	
	static def mapper(){
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Usuario, new UsuarioSerializer(Usuario))
		mapper.registerModule(module)
		mapper
	}
}