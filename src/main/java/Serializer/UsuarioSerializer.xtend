package Serializer

import Clases.Usuario
import ParserStringToLong.ParserStringToLong
import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer

class UsuarioSerializer extends StdSerializer<Usuario>{
	new(Class<Usuario> s){
		super(s)
	}
	
	static ParserStringToLong parserStringToLong = ParserStringToLong.instance
	
	override serialize(Usuario value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject();
		gen.writeStringField("usuario", value.username);
		gen.writeStringField("id", parserStringToLong.parsearDeLongAString(value.idUsuario));
		gen.writeStringField("nombre", value.nombre);
		gen.writeStringField("apellido", value.apellido);
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