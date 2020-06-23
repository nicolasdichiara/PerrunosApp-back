package Serializer

import com.fasterxml.jackson.core.JsonGenerator
import com.fasterxml.jackson.databind.SerializerProvider
import java.io.IOException
import com.fasterxml.jackson.databind.ObjectMapper
import com.fasterxml.jackson.databind.module.SimpleModule
import com.fasterxml.jackson.databind.ser.std.StdSerializer
import java.time.format.DateTimeFormatter
import java.time.LocalDate
import Clases.Servicio

class GpsSerializerDuenio extends StdSerializer<Servicio> {
	new(Class<Servicio> s) {
		super(s)
	}

	static val DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy")

	static def getStringDateFromLocalDate(LocalDate date) { date.format(formatter) }

	override serialize(Servicio value, JsonGenerator gen, SerializerProvider provider) throws IOException {
		gen.writeStartObject();
		gen.writeStringField("lat", value.latitudDuenio);
		gen.writeStringField("lng", value.longitudDuenio);
		gen.writeEndObject();
	}

	static def String toJson(Servicio servicio) {
		if (servicio === null) {
			return "[ ]"
		}
		mapper().writeValueAsString(servicio)
	}

	static def mapper() {
		val ObjectMapper mapper = new ObjectMapper()
		val SimpleModule module = new SimpleModule()
		module.addSerializer(Servicio, new GpsSerializerDuenio(Servicio))
		mapper.registerModule(module)
		mapper
	}
}